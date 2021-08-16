json.array!(@events) do |event|
  json.id event.id
  json.start event.start_time
  json.end event.end_time
  json.class_name event.class.name
end