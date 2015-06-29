# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Category.create! [{title: "Anh đến Nhật Bản khi nào?",
#                    description: "Hôm nay tại kí túc xá dành cho du học sinhmà chị Anna
#                                  sống có một bữa tiệc dành cho các
#                                  sinh viên người nước ngoài. Chị Anna giới thiệu
#                                  anh Rodrigo, bạn cùng lớp người Mexico với chị Sakura."},
#                   {title: "Chị nhất định đến nhé!",
#                    description: "Kí túc xá dành cho du học sinh nơi chị Anna sống sẽ
#                                  có một bữa tiệc. Chị Anna mời chị Sakura tham dự."},
#                   {title: "Tất cả mọi người có mặt chưa?",
#                    description: "Hôm nay, chị Anna có buổi khám sức khỏe tại trường đại học.
#                                  Các sinh viên đã tập trung tại nơi khám sức khỏe"},
#                   {title: "Xin thày nói lại một lần nữa ạ!",
#                    description: "Chị Anna đang ở trong lớp tiếng Nhật của Giáo sư Suzuki ở trường."},
#                   {title: "Số điện thoại của chị là bao nhiêu?",
#                    description: "Chị Anna va chị Sakura tiếp tục trò chuyện trong phòng chị Anna.
#                                  Chị Sakura muốn hỏi chị Anna số điện thoại của chị Anna."}]
japanese = <<-EOS
 水 曜 日 に お 届 け す る に は 今 か ら 時 間 分 以 内 に お 急 ぎ
 便 ま た は 当 お 急 ぎ 便 を 選 択 し て 注 文 を 確 定 し て く だ
 さ い （ 有 料 オ プ シ ョ ン ラ イ ム 会 員 は 無 料
EOS
vietnamese = <<-EOS
 Giai đoạn đó có rất nhiều trở ngại từ quốc hội chính phủ Mỹ
 báo giới người dân cựu binh và cả cộng đồng người Việt di tản
 sau chiến tranh. Có những trở ngại gần như gây nản chí nếu
 mình mong nó phát triển nhanh Khó khăn này kéo dài suốt từ
 những năm là tất yếu do lịch sử để lại Việt
 Mỹ từng ở hai bên chiến tuyến dùng tất cả những gì có thể để
 đánh bại bên kia, khi cuộc chiến chấm dứt thì những điều đó
 vẫn còn đọng lại trong từng người không dễ mất đi được
 Nhưng cả lãnh đạo và nhân dân Việt Nam đều mong muốn phá
 bỏ bao vây cấm vận điều đó là cần thiết Từ tháng tư cảm
 nhận về việc mình sắp ra đi Giáo sư Khê liên lạc với bạn bè thân thiết
 trong đó có nhà văn nhà báo Nguyễn Đắc Xuân ở Huế để gửi gắm về việc
 lo giúp mình hậu sự Ngay khi nghe tin Trần Văn Khê nhập viện nguy kịch
 ông Nguyễn Đắc Xuân bay từ Huế vào TP HCM và sát cánh bên gia đình giáo
 sư đến ngày ông mất
EOS
japaneses = japanese.split(" ")
vietnameses = vietnamese.split(" ")
japaneses.each_with_index do |word, index|
  jp_word = word
  answer_1 = vietnameses[4*index]
  answer_2 = vietnameses[4*index+1]
  answer_3 = vietnameses[4*index+2]
  answer_4 = vietnameses[4*index+3]
  correct_answer = rand(1..4)
  category_id = rand(1..5)
  Word.create!(jp_word: jp_word,correct_answer: correct_answer,
               answer_1: answer_1,answer_2: answer_2,
               answer_3: answer_3,answer_4: answer_4,category_id: category_id)
end

User.create!(username:  "Admin DV",
             email: "dev.ducvu@gmail.com",
             password:              "abc123",
             password_confirmation: "abc123",
             admin: true)
50.times do |n|
  name  = Faker::Name.name
  email = "dev.ducvu-#{n+1}@gmail.com"
  password = "abc123"
  User.create!(username: name,
              email: email,
              password:              password,
              password_confirmation: password)
end

users = User.all
user  = users.first
following = users[2..20]
followers = users[3..20]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}
