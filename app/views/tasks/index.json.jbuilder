json.array! @tasks do |task|
  date_format = '%Y-%m-%dT%H:%M:%S'
  json.id task.id
  json.title task.title
  json.start task.start_date.strftime(date_format)
  json.end task.end_date.strftime(date_format)
  json.color nil
  json.allDay false
  json.update_url task_path(task, method: :patch)
  json.edit_url edit_task_path(task)
end