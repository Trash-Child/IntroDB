USE newspaper_db;

/* Q(3) - Which are the reporters whose photos were never used more than once. */ 

SELECT DISTINCT j.FirstName, j.LastName
FROM Journalist j
JOIN Photo p ON j.SSN = p.SSN
WHERE p.PhotoTitle IN (
    SELECT ap.PhotoTitle
    FROM ArticlePhoto ap
    GROUP BY ap.PhotoTitle, ap.PhotoDate, ap.SSN
    HAVING COUNT(*) = 1
) AND p.PhotoDate IN (
    SELECT ap.PhotoDate
    FROM ArticlePhoto ap
    GROUP BY ap.PhotoTitle, ap.PhotoDate, ap.SSN
    HAVING COUNT(*) = 1
) AND p.SSN IN (
    SELECT ap.SSN
    FROM ArticlePhoto ap
    GROUP BY ap.PhotoTitle, ap.PhotoDate, ap.SSN
    HAVING COUNT(*) = 1
);

/* Q(5) Which journalists were both writers and reporters, having shot at least a photo that was used for a news article they wrote.*/
