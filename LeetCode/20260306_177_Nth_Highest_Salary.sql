CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      SELECT salary
      FROM (
        SELECT
            salary,
            RANK() OVER (ORDER BY salary DESC) AS r
        FROM (SELECT DISTINCT(salary) FROM Employee) AS t
      ) AS t
      WHERE r = N
  );
END
