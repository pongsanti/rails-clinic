# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Prefixes
Prefix.create(name: 'นาย', sex: "M")
Prefix.create(name: 'นางสาว', sex: "F")
Prefix.create(name: 'นาง', sex: "F")
Prefix.create(name: 'เด็กชาย', sex: "M")
Prefix.create(name: 'เด็กหญิง', sex: "F")

Diag.create([
  {name: "Enteric  Fever", description: "Enteric  Fever"},
  {name: "Shigellosis", description: "Shigellosis"},
  {name: "Bacterial enteritis", description: "Bacterial enteritis"}])

# Store unit
StoreUnit.create([
  {title: "เม็ด"},
  {title: "ชุด"},
  {title: "กล่อง"}
])