json.array!(@recipients) do |recipient|
  json.extract! recipient, :id, :name, :number, :program
  json.url recipient_url(recipient, format: :json)
end
