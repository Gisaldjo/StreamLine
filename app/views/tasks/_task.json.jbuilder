date_format = task.all_day_task? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'

json.id task.id
json.title task.title
json.start task.start.localtime
json.end task.end.localtime

json.color task.color unless task.color.blank?
json.allDay task.all_day_task? ? true : false

json.update_url task_path(task, method: :patch)
json.edit_url edit_task_path(task)