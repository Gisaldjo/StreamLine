json.extract! note, :id, :title, :description, :group, :created_at, :updated_at
json.url note_url(note, format: :json)
