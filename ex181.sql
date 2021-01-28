# Write your MySQL query statement below
SELECT employer.Name as Employee
FROM
  (SELECT Id, Name, Salary, ManagerId
   FROM Employee
   WHERE ManagerId IS NOT NULL
  ) employer
LEFT JOIN Employee manager
  ON employer.ManagerId = manager.Id
WHERE employer.Salary > manager.Salary