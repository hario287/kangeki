Admin.create!(
email: ENV["ADMIN_EMAIL"],
password: ENV["ADMIN_PASSWORD"]
)

5.times do |n|
  User.create!(
    email: "user#{n + 1}@example.com",
    name: "ユーザー#{n + 1}",
    password: ENV["USER_PASSWORD"],
    introduction: "テキストテキストテキストテキストテキストテキスト",
  )
end

Topic.create!(
  [{ topic_name: "質問" },
  { topic_name: "雑談" },
  { topic_name: "おすすめを教えて！" },
  { topic_name: "作品を語ろう" },
  { topic_name: "アーティストを語ろう" },
  { topic_name: "その他" },
  { topic_name: "宣伝" },]
)
