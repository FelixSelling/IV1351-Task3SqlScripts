-- Query 1, How many lessons per type and total for 2022
SELECT 	tbl1.month,
		tbl1.ensembles_lessons, tbl2.group_lessons,
		tbl3.individual_lessons, tbl1.ensembles_lessons + tbl2.group_lessons + tbl3.individual_lessons AS total_lessons
FROM
(
	SELECT
		TO_CHAR(DATE_TRUNC('month', scheduled_date), 'Month') AS Month,
		COUNT(id) AS ensembles_lessons
	FROM public.ensembles_lesson
	WHERE DATE_TRUNC('year', scheduled_date) = '2022-01-01 00:00:00'
	GROUP BY DATE_TRUNC('month',scheduled_date)
) tbl1
JOIN
(
	SELECT
		TO_CHAR(DATE_TRUNC('month', scheduled_date), 'Month') AS month,
		COUNT(id) AS group_lessons
	FROM public.group_lesson
	WHERE DATE_TRUNC('year', scheduled_date) = '2022-01-01 00:00:00'
	GROUP BY DATE_TRUNC('month',scheduled_date)
) tbl2
ON tbl1.month = tbl2.month
JOIN
(
	SELECT
		TO_CHAR(DATE_TRUNC('month', booked_date), 'Month') AS Month,
		COUNT(id) AS individual_lessons
	FROM public.student_individual_lesson
	WHERE DATE_TRUNC('year', booked_date) = '2022-01-01 00:00:00'
	GROUP BY DATE_TRUNC('month', booked_date)
) tbl3
ON tbl1.month = tbl3.month
ORDER BY EXTRACT(MONTH FROM TO_DATE(tbl1.Month, 'Month'));

