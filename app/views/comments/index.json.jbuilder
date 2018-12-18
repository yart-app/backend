json.errors @errors

unless @comments.nil?
  json.comments do
    json.array! @comments[:chunk] do |comment|
      json.text comment.text
      json.username comment.user.name
    end
  end
  json.next @comments[:next]
end
