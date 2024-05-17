SELECT 
    COUNT(distinct website_session_id) AS number_of_sessions,
    utm_source,
    utm_campaign,
    http_referer
FROM
    website_sessions
WHERE
    DATE(created_at) < '2012-04-12'
GROUP BY 2 , 3 , 4;
