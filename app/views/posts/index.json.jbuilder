
json.array!(@posts) do |post|
  json.extract! post, :id, :content, :latitude, :longitude, :created_at, :good, :bad, :comments
  json.url post_url(post, format: :json)
end
