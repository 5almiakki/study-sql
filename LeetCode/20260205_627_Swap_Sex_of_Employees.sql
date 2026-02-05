UPDATE Salary
SET sex = IF(sex = 'f', 'm', 'f');

UPDATE Salary
SET sex =
        CASE sex
            WHEN 'f' THEN 'm'
            ELSE 'f'
        END;
