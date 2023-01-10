-- NOTE that: NOW() *- interval '1 year'* since my imported data is for 2022, if data was current year *- interval '1 year'* can be removed
-- Query 4, Show the number of students enrolled in each ensemble lesson for the next 7 days, and the status of seats left in each ensemble lesson.

SELECT 	target_genre,
		scheduled_date,
		ensembles_lesson.id AS ensembles_lesson_id,
		count(ensembles_lesson.id) AS student_count,
		size_max,
		CASE
		    WHEN size_max - count(ensembles_lesson.id) < 0 THEN 'OVERBOOKED!!'
			WHEN size_max - count(ensembles_lesson.id) = 1
			OR size_max - count(ensembles_lesson.id) = 2 THEN '1-2 seats left'
			WHEN size_max - count(ensembles_lesson.id) = 0 THEN 'FULL'
			WHEN size_max - count(ensembles_lesson.id) > 2 THEN 'More seats left'
		END seats_left
FROM public.ensembles_lesson
LEFT JOIN public.student_ensembles_lesson
ON ensembles_lesson.id = student_ensembles_lesson.ensembles_lesson_id
WHERE scheduled_date BETWEEN now() - interval '1 year' AND now() + interval '7 days' - interval '1 year'
GROUP BY ensembles_lesson.id
ORDER BY target_genre, scheduled_date