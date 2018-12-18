json.array! @tasks do |event|
  date_format = event.all_day_task? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'
  json.id event.id
  json.title event.title
  case event.color
  when "blue"
    json.color "#9EDEE5"
    json.borderColor "#5EC8D4"
  when "green"
    json.color "#BBE59E"
    json.borderColor "#81CF4A"
  when "red"
    json.color "#E5A59E"
    json.borderColor "#D46A5E"
  else
    json.color "#C99EE5"
    json.borderColor "#AB70CE"
  end
  json.start event.start.localtime.strftime(date_format)
  json.end event.end.localtime.strftime(date_format)
  json.allDay event.all_day_task? ? true : false
  json.update_url task_path(event, method: :patch)
  json.edit_url edit_task_path(event)
end