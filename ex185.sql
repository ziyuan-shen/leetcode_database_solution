# Write your MySQL query statement below
SELECT d.Name AS Department, e.Name as Employee, e.Salary
FROM Employee e
LEFT JOIN
    (
        SELECT RANK() OVER (PARTITION BY DepartmentId ORDER BY Salary DESC) AS srank, DepartmentId, Salary
        FROM (
            SELECT DISTINCT Salary, DepartmentId
            FROM Employee
        ) distinct_salary
    ) r
  ON e.DepartmentId = r.DepartmentId AND e.Salary = r.Salary
LEFT JOIN Department d
  ON e.DepartmentId = d.Id
WHERE r.srank <= 3
  AND d.Name IS NOT NULL