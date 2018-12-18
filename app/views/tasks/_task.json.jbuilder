date_format = task.all_day_task? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'
json.id task.id
json.title task.title
case task.color
when "blue"
  json.color "#9EDEE5"
when "green"
  json.color "#BBE59E"
when "red"
  json.color "#E5A59E"
else
  json.color "#C99EE5"
end
json.start task.start.localtime.strftime(date_format)
json.end task.end.localtime.strftime(date_format)
json.allDay task.all_day_task? ? true : false
json.update_url task_path(task, method: :patch)
json.edit_url edit_task_path(task)