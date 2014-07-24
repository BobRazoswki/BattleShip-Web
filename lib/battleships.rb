require 'sinatra/base'
require_relative '../files'

class BattleShips < Sinatra::Base
  
set :views, Proc.new { File.join(root, "..", "views") }

	use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :expire_after => 2592000, # In seconds
                           :secret => 'change_me'


	GAME = Game.new
	# (player_one: session[:player1], player_two: session[:player2])


  get '/' do
  	puts GAME
    erb :homepage
  end

  get '/newgame' do 
  	erb :newgame
  end

  post '/newgame' do
  	session[:player] = Player.new(name: params[:name], board: Board.new(content: Water.new))
  	GAME.add_(session[:player])

    redirect to "/waiting_page"

  end

  get '/waiting_page' do
    

    if !GAME.enough_players?
      erb :waiting_page
    else
      redirect to "/play_game"
    end
   
  end

  get '/play_game' do
    erb :play_game
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
