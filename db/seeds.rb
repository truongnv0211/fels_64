# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

3.times do
  title = Faker::Lorem.sentence
  description = Faker::Lorem.sentence(4)
  Category.create! title: title, description: description
end

150.times do
  jp_word = Faker::Lorem.word
  category_id = rand(1..3)
  Word.create! jp_word: jp_word, category_id: category_id
end

wordlist = Word.all

wordlist.each do |word|
  4.times do |n|
    answer_content = Faker::Lorem.sentence
    word_id = word.id
    correct = (n+1)%4 == 0 ? true : false
    Answer.create! answer_content: answer_content, word_id: word_id, correct: correct
  end
end

User.create!(username:  "Admin",
             email: "admin@gmail.com",
             password:              "adminadmin",
             password_confirmation: "adminadmin",
             admin: true)
