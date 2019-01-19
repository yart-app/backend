json.errors @errors
json.comment do
  json.text @comment.text
  json.username @comment.user.name
end
