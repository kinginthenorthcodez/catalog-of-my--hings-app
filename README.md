# catalog-of-my--hings-app

"Catalog of my things" is a simple console app that allows users to manage collections of the things they own.

require './game'
require './author'
require 'json'
require 'fileutils'

module GameList
def add_game
puts 'Enter player Name: '
player = gets.chomp
puts 'Enter last_played:[Interger] :'
date = user_input
puts ' Enter publish date : '
publish_date = gets.chomp
print "\n"
print 'Enter is archived: [Y/N] :'
archived = parse_bool
puts 'game created!'
puts 'Create game Author [Y/N]'
option = parse_bool
while option
game = Game.new(player, date, publish_date, archived)
add_author(game)
puts 'Continue..? [Y/N]'
option = parse_bool
end
save_to_file(player, date, publish_date, archived)
end

def save_to_file(player, date, publish_date, archived)
game_object = { multplayer: player, last_played: date, publish_date: publish_date, archived: archived }
data = File.read('game.json') if File.exist?('game.json')
file_data = JSON.parse(data)
file_data << game_object
File.write('game.json', JSON.generate(file_data))
end

def list_games
p ' Game list'
data = File.read('game.json') if File.exist?('game.json')
games = JSON.parse(data)
puts '| Index | Multplayer | Last Played | Published | Archived |'
games.each_with_index do |game, index|
puts "#{[index + 1]} #{game['multplayer']} #{game['last_played']}yrs #{game['publish_date']}} #{game['archived']}"
end
end
end

require './author'
require 'json'
require 'fileutils'

module AuthorList
def add_author(item = '')
print 'First Name: '
first_name = gets.chomp
print "\n"
print 'Last Name: '
last_name = gets.chomp
puts 'Author added succefully!'

    author = Author.new(first_name, last_name)
    author.add_item(item) if item.class.to_s == 'Game'

    author_object = { first_name: first_name, last_name: last_name }
    data = File.read('author.json') if File.exist?('author.json')
    file_data = JSON.parse(data)
    file_data << author_object
    File.write('author.json', JSON.generate(file_data))

end

def list_author
p ' Authors list'
File.write('author.json', []) unless File.exist?('author.json')
data = File.read('author.json') if File.exist?('author.json')
authors = JSON.parse(data)
authors.each_with_index do |author, index|
puts "#{[index + 1]} Name : #{author['first_name']} #{author['last_name']}"
end
print " \n"
puts 'Create an Author [Y/N]'
option = parse_bool
while option
add_author
puts 'Continue..? [Y/N]'
option = parse_bool
end
end
end
