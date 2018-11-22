json.extract! note, :id, :title, :description, :group, :sort, :created_at, :updated_at
json.url note_url(note, format: :json)
