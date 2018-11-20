json.array! @tasks.items.each do |event|
  date_format = '%Y-%m-%dT%H:%M:%S'
  json.id event.id
  json.title event.summary
  json.start event.start.date_time
  json.end event.end.date_time
end