require 'sinatra'

wins = 0
loss = 0
tied = 0

before do
  content_type :txt
  @defeat = {rock: :scissors, paper: :rock, scissors: :paper, rock: :lizard, lizard: :spock, lizard: :paper, spock: :scissors, spock: :rock, scissors: :lizard, paper: :spock}
  @throws = @defeat.keys
end

['/', '/throw/?'].each do |route|
	get route do
		halt 403, "please use localhost:4567/throw/ #{@throws} to choose a action.\n
		Also type localhost:4567/stats to view stats."
	end
end

get '/sup' do
  content_type :html
  erb :sup
end

get'/throw/:type' do  
  player_throw = params[:type].to_sym
  if !@throws.include?(player_throw)
    halt 403, "You must throw one of the following: #{@throws}"
  end
  computer_throw = @throws.sample
  if player_throw == computer_throw
	tied += 1
    "You tied with computer try again"
  elsif computer_throw == @defeat[player_throw]
	wins += 1
    "Nicely done; #{player_throw} beats #{computer_throw}!"
  else
	loss += 1
    "Ouch, #{computer_throw} beats #{player_throw}!"
  end
end
get '/stats' do
	"Wins: #{wins}		Losses: #{loss}		Ties: #{tied}"
end
