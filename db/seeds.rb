
# Add seed data here. Seed your database with `rake db:seed`

list = Dir["./db/data/*"]
list.each do |info|
info.slice! ".mp3"
info.slice! "./db/data/"
list2 = info.split(' - ')
artist = Artist.find_or_create_by(name: list2[0])
list3 = list2[1].split(" ")
song = Song.create(name: list3[0])
genre = Genre.find_or_create_by(name: list3[1].delete("[]"))
artist.songs << song
song.genres << genre
artist.save
song.save
genre.save
end
