json.array!(@courses) do |course|
  json.extract! course, :id, :location, :startdate, :enddate, :coursestate
  json.url course_url(course, format: :json)
end
