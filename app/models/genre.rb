class Genre < ActiveRecord::Base
has_many :song_genres
has_many :songs, through: :song_genres
has_many :artists, through: :songs

def slug
  string = self.name.downcase
  string.gsub!(/[()!@%&"]/,'')
  array = string.split(" ")
  array.join("-")
end

def self.find_by_slug(string)
  self.all.find {|instance| instance.slug == string}
end

end
