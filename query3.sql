-- NOTE that: NOW() *- interval '1 year'* since my imported data is for 2022, if data was current year *- interval '1 year'* can be removed
-- Query 3, Instructors with more lesson given than 3 for the given period (start of month -> today (-1 year))
EXPLAIN ANALYZE
SELECT *
FROM
(
	SELECT coalesce(tbl1.instructor_id, tbl2.instructor_id, tbl3.instructor_id) AS instructor_id,
		coalesce(tbl1.ensembles_lesson_count, 0) + coalesce(tbl2.group_lesson_count, 0) + coalesce(tbl3.individual_lesson_count, 0) AS total_lessons_given
	FROM
	(
		SELECT instructor_id, COUNT(instructor_id) AS ensembles_lesson_count
		FROM public.ensembles_lesson
		WHERE scheduled_date BETWEEN DATE_TRUNC('month', now() - interval '1 year') AND NOW() - interval '1 year'
		GROUP BY instructor_id
	) tbl1
	FULL JOIN
	(
		SELECT instructor_id, COUNT(instructor_id) AS group_lesson_count
		FROM public.group_lesson
		WHERE scheduled_date BETWEEN DATE_TRUNC('month', now() - interval '1 year') AND NOW() - interval '1 year'
		GROUP BY instructor_id
	) tbl2
	ON tbl1.instructor_id = tbl2.instructor_id
	FULL JOIN
	(
		SELECT instructor_id, COUNT(instructor_id) AS individual_lesson_count
		FROM public.student_individual_lesson
		WHERE booked_date BETWEEN DATE_TRUNC('month', now() - interval '1 year') AND NOW() - interval '1 year'
		GROUP BY instructor_id
	) tbl3
	ON tbl1.instructor_id = tbl3.instructor_id
)tbl
WHERE tbl.total_lessons_given > 3