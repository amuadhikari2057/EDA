SELECT 
    SUM(CASE
        WHEN c.count_pageviews = 1 THEN 1
        ELSE 0
    END) AS bounded_sessions,
    c.pageview_url,
    COUNT(c.website_pageview_id) AS total_sessions,
    SUM(CASE
        WHEN c.count_pageviews = 1 THEN 1
        ELSE 0
    END) / COUNT(c.website_pageview_id) AS rate
FROM
    (SELECT 
        b.*
    FROM
        website_sessions ws
    JOIN (SELECT 
        a.*, wp.pageview_url
    FROM
        website_pageviews wp
    JOIN (SELECT 
        COUNT(website_pageview_id) AS count_pageviews,
            website_session_id,
            MIN(website_pageview_id) AS website_pageview_id
    FROM
        website_pageviews
    WHERE
        created_at BETWEEN '2012-06-19' AND '2012-07-28'
    GROUP BY website_session_id) a ON a.website_pageview_id = wp.website_pageview_id) b ON ws.website_session_id = b.website_session_id
    WHERE
        ws.utm_source = 'gsearch'
            AND ws.utm_campaign = 'nonbrand') c
GROUP BY c.pageview_url;


select 
a.*, min(ws.created_at) as week_start
from
website_sessions ws 