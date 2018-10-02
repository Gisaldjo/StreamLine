json.extract! note, :id, :user_id, :title, :content, :group, :created_at, :updated_at
json.url note_url(note, format: :json)
