json.array! @events do |event|
  date_format =  '%Y-%m-%d' 
  json.id event.id
  json.title event.leave.subject
  json.start event.assign_date.strftime(date_format)
  json.end event.assign_date.strftime(date_format)
  json.assign Employee.find(@events.first.assign_to.to_i).name
  # json.allDay event.all_day_event? ? true : false
  # json.update_url event_path(event, method: :patch)
  # json.edit_url edit_event_path(event)
end

json.array! @leaves do |leave|
  date_format =  '%Y-%m-%d' 
  json.id leave.id
  json.title leave.subject
  json.start leave.from_date.strftime(date_format)
  json.end leave.to_date.strftime(date_format)
  json.color '#93A661'
  json.assign 'self'
  # json.allDay event.all_day_event? ? true : false
  # json.update_url event_path(event, method: :patch)
  # json.edit_url edit_event_path(event)
end
