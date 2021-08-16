# frozen_string_literal: true

json.array!(@events) do |event|
  json.id event.id
  json.title event.title
  json.start event.start_date
  json.end event.end_date
  json.class_name event.class.name
end
