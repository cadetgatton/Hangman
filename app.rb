require 'sinatra'
require_relative 'hangman.rb'
enable :sessions

get '/' do
	erb :index
end

post '/player_names' do
  player1 = params[:player1]
  player2 = params[:player2]
  player1 + player2
  "Player 1 is #{player1} and Player 2 is #{player2}!"

  redirect '/password?player1=' + player1 + '&player2=' + player2
end

get '/password' do
	session[:player1] = params[:player1]
	session[:player2] = params[:player2]
	erb :password, locals:{p1_name: session[:player1], p2_name: session[:player2]}
end

post '/gameword' do
	password = params[:word]
	session[:game] = Hangman.new(password)
	
	"Player 1 is #{session[:player1]} and Player 2 is #{session[:player2]}. Your word is #{password}."

	redirect '/guessing'
end

 get '/guessing' do
	erb :guessing, locals:{p1_name: session[:player1], p2_name: session[:player2], blank: session[:game].correct_blank, array: session[:game].guessed, counter: session[:game].counter, message: "Pick a letter.", message2: ""}
	
end
post '/guess' do
	choice = params[:letter].upcase
		if session[:game].available_guess(choice)
			true

			session[:game].update_guessed(choice)
			session[:game].make_move(choice)
				if session[:game].loser == true
					redirect '/loser'
				elsif session[:game].winner == true
					redirect '/winner'
				end
			redirect '/guessing?'
		else
			session[:game].correct_index(choice)
			erb :guessing, locals:{p1_name: session[:player1], p2_name: session[:player2], blank: session[:game].correct_blank, array: session[:game].guessed, counter: session[:game].counter, message: "", message2: "Letter already guessed. Try again."}
		end
end
get '/loser' do
	erb :loser, locals: {p1_name: session[:player1], p2_name: session[:player2], word: session[:game].name}
end

get '/winner' do
	erb :winner, locals: {p1_name: session[:player1], p2_name: session[:player2], word: session[:game].name}
end