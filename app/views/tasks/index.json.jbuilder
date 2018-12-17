json.array! @tasks do |event|
  date_format = event.all_day_task? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'
  json.id event.id
  json.title event.title
  json.start event.start.localtime
  json.end event.end.localtime
  case event.color
  when "blue"
    json.color "#9EDEE5"
  when "green"
    json.color "#BBE59E"
  when "red"
    json.color "#E5A59E"
  else
    json.color "#C99EE5"
  end
  json.allDay event.all_day_task? ? true : false
  json.update_url task_path(event, method: :patch)
  json.edit_url edit_task_path(event)
end