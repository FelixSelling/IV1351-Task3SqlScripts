-- Query 2, How many siblings per student
EXPLAIN ANALYZE
SELECT coalesce(siblings,0) AS number_of_siblings, COUNT(coalesce(siblings,0)) AS students_with_number_of_siblings
FROM public.student
FULL JOIN
(
	SELECT coalesce(student_id_1, student_id_2) AS student_id, coalesce(sibling_count_1, 0) + coalesce(sibling_count_2, 0) AS siblings
	FROM
	(
		SELECT student_id_1, COUNT(student_id_1) AS sibling_count_1
		FROM public.sibling_pair
		GROUP BY student_id_1
	) tbl1
	Full JOIN
	(
		SELECT student_id_2, COUNT(student_id_2) AS sibling_count_2
		FROM public.sibling_pair
		GROUP BY student_id_2
	) tbl2
	ON tbl1.student_id_1 = tbl2.student_id_2
) tbl
ON student.id = tbl.student_id
GROUP BY siblings
ORDER BY number_of_siblings;