json.extract! task, :id, :title, :description
json.start task.start_date
json.end task.end_date
json.url task_url(task, format: :html)