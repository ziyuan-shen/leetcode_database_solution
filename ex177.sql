CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  -- DECLARE a INT DEFAULT N - 1;
  RETURN (
      # Write your MySQL query statement below.
      SELECT Salary
      FROM (
          SELECT RANK() OVER (ORDER BY Salary DESC) AS r, Salary
          FROM (
              SELECT DISTINCT Salary
              FROM Employee
          ) AS s
      ) AS hei
      WHERE r = N
  );
END