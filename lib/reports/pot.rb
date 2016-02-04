def Report::pot_frankfurt
  sql = "
SELECT pid, lastname, firstname, email
FROM people
WHERE
(
  EXISTS (SELECT 1 FROM person_event_assignments
    INNER JOIN events ON person_event_assignments.event_id = events.id
    INNER JOIN event_types ON events.event_type_id = event_types.id
    WHERE person_id = people.id AND event_types.code = 'FGK' )
AND
   (SELECT COUNT(*) FROM person_event_assignments
    INNER JOIN events ON person_event_assignments.event_id = events.id
    INNER JOIN event_types ON events.event_type_id = event_types.id
    WHERE person_id = people.id AND event_types.description LIKE 'Seminar%' ) >= 1
)

OR
   (SELECT COUNT(*) FROM person_event_assignments
    INNER JOIN events ON person_event_assignments.event_id = events.id
    INNER JOIN event_types ON events.event_type_id = event_types.id
    WHERE person_id = people.id AND event_types.description LIKE 'Seminar%' ) >= 2

ORDER BY lastname, firstname
  "

  results = ActiveRecord::Base.connection.execute(sql)
end
