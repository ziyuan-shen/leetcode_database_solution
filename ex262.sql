# Write your MySQL query statement below
WITH valid_request AS (
    SELECT t.Status, t.Request_at
    FROM Trips t
    LEFT JOIN Users u1
      ON t.Client_Id = u1.Users_Id
    LEFT JOIN Users u2
      ON t.Driver_Id = u2.Users_Id
    WHERE u1.Banned = "No"
      AND u2.Banned = "No"
      AND t.Request_at IN ("2013-10-01", "2013-10-02", "2013-10-03")
)

SELECT tc.Request_at AS Day, ROUND(IFNULL(cc.cancelled_count, 0) / tc.total_count, 2) AS `Cancellation Rate`
FROM
(
    SELECT COUNT(*) as total_count, Request_at
    FROM valid_request
    GROUP BY Request_at
) tc
LEFT JOIN
(
    SELECT COUNT(*) as cancelled_count, Request_at
    FROM valid_request
    WHERE Status <> "completed"
    GROUP BY Request_at
) cc
  ON tc.Request_at = cc.Request_at;