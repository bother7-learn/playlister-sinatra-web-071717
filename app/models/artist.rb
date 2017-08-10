class Artist < ActiveRecord::Base
has_many :songs
has_many :song_genres, through: :songs
has_many :genres, through: :song_genres

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
