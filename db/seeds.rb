# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
lines_list = [
  [ 1, "Orange Line", "ff2800" ],
  [ 2, "Brown Line", "67340f" ],
  [ 3, "Green Line", "00a32f" ],
  [ 4, "Pink Line", "f072a5" ],
  [ 5, "Blue Line", "009fe5" ],
  [ 6, "Yellow Line", "fae900" ],
  [ 7, "Purple Line", "5c009d" ],
  [ 8, "Red Line", "d60019" ]
]

lines_list.each do |id, name, color|
  Line.create( id: id, name: name, color:color )
end
