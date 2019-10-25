require 'pry'

class MusicLibraryController

  def initialize(path = "./db/mp3s")
    newImporter = MusicImporter.new(path)
    Song.all << newImporter.import
  end

  def call
     puts "Welcome to your music library!"
     puts "To list all of your songs, enter 'list songs'."
     puts "To list all of the artists in your library, enter 'list artists'."
     puts "To list all of the genres in your library, enter 'list genres'."
     puts "To list all of the songs by a particular artist, enter 'list artist'."
     puts "To list all of the songs of a particular genre, enter 'list genre'."
     puts "To play a song, enter 'play song'."
     puts "To quit, type 'exit'."
     puts "What would you like to do?"

     user_input = gets.chomp.downcase

    case user_input
      when "list songs"
        self.list_songs
      when "list artists"
        self.list_artists
      when "list genres"
        self.list_genres
      when "exit"
        'exit'
    else
      call
    end
 end

 def library(klass = Song)
   sorted_library = klass.all.collect{|object|object if object.class == klass }
   sorted_library = sorted_library.delete_if {|object|object==nil}
   sorted_library.uniq
 end

 def list_songs
   sorted_library = self.library.sort_by {|song|song.name}
   sorted_library.each do |song|
     puts "#{sorted_library.index(song) + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
   end
 end

 def list_artists
    sorted_library = self.library(Artist).sort_by {|object|object.name}
    artists = sorted_library.collect {|object|"#{object.name}"}.uniq
    artists.each {|artist| puts "#{artists.index(artist) + 1}. #{artist}"}
  end

  def list_genres
    sorted_library = self.library.sort_by {|song|song.genre.name}
    genres = sorted_library.collect {|song|"#{song.genre.name}"}.uniq
    genres.each {|genre| puts "#{genres.index(genre) + 1}. #{genre}"}
  end





end
