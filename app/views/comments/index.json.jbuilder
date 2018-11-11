json.errors @errors

unless @comments.nil?
  json.comments @comments[:chunk]
  json.next @comments[:next]
end
