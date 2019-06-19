json.post do
  json.text @post.text
  json.created_at @post.created_at.strftime("%Y-%m-%d")
end
