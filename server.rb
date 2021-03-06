require 'sinatra/base'
require_relative 'lib/player'
require_relative 'lib/game'
require_relative 'lib/weapon'

class Server < Sinatra::Base

  enable :sessions

  get '/' do
    computer = Player.new({:name => "Computer"})
    computer.weapon_choice = Weapon.new.random_weapon
    @game = Game.new
    session[:game] = @game
    @game.add_player(computer)
    erb :index
  end

  post '/' do
    if params[:player_name].empty?
      erb :index
    else
      @player_name = params[:player_name]
      human = Player.new({name: @player_name})
      session[:human] = human
      @game = session[:game]
      @game.add_player(human)
      erb :game
    end
  end

  post '/game' do
    erb :game
  end

  post '/result' do
    if params[:weapon_choice] == "no_weapon"
      erb :game
    else
      @player_weapon = params[:weapon_choice]
      @player_name = params[:player_name]

      human = session[:human]

      if @player_weapon == "rock"
        human.weapon_choice = Weapon.new.rock
      elsif @player_weapon = "paper"
         human.weapon_choice = Weapon.new.paper
      else
         human.weapon_choice = Weapon.new.scissors
      end

      @game = session[:game]
      computer = @game.players.select{|player| player.name == "Computer"}.first
      @computer_weapon = computer.weapon_choice

      winner = @game.result
      if winner == "draw"
        @winner = "It's a " + winner +"!"
      else
        @winner = winner.name + " wins!"
      end

      erb :result
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
