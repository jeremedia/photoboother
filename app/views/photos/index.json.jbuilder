json.array!(@photos) do |photo|
  json.extract! photo, :id, :file
  json.url photo_url(photo, format: :json)
end
