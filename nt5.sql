select
count(website_session_id) as total_sessions,
week(created_at) as week_at,
min(created_at) as week_start
from website_sessions
where utm_source = 'gsearch' and utm_campaign = 'nonbrand' and created_at between '2012-03-19' and '2012-05-10'
group by year(created_at), week(created_at);
