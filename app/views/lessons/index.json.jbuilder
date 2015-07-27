json.array! @lessons do |lesson|
  json.id lesson.id
  json.name lesson.name
  json.colorId lesson.color_id
  json.position lesson.position
  json.description lesson.description
  json.videos lesson.videos do |video|
    json.id video.id
    json.name video.name
    json.signedInOnly video.signed_in_only
    json.link video.link
  end
end
