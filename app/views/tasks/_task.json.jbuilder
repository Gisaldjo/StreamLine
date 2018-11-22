json.extract! task, :id, :title, :description, :group, :sort, :created_at, :updated_at
json.url task_url(task, format: :json)
