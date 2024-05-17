with cte1 as (
SELECT 
    ws.website_session_id,
    b.website_pageview_id,
    b.pageview_url,
    b.created_at
FROM
    website_sessions ws
join
(select 
wp.website_pageview_id,
wp.pageview_url,
a.*
from website_pageviews wp
join 
(select 
website_session_id,
min(created_at) as created_at
from website_pageviews
group by website_session_id)a on a.created_at = wp.created_at)b on b.website_session_id = ws.website_session_id
where b.created_at between '2012-06-01' and '2012-08-31'
and ws.utm_source = 'gsearch' and ws.utm_campaign = 'nonbrand'
and b.pageview_url in ('/home', '/lander-1')),
 cte3 as (
select 
date(min(created_at)) as created_at,
count(website_pageview_id) as total_sessions,
pageview_url
from cte1
group by year(created_at), week(created_at), pageview_url),


 cte2 as (
SELECT 
    ws.website_session_id,
    b.website_pageview_id,
    b.pageview_url,
    b.created_at
FROM
    website_sessions ws
join
(select 
wp.website_pageview_id,
wp.pageview_url,
a.*
from website_pageviews wp
join 
(select 
website_session_id,
min(created_at) as created_at
from website_pageviews
group by website_session_id
having count(website_session_id) = 1)a on a.created_at = wp.created_at)b on b.website_session_id = ws.website_session_id
where b.created_at between '2012-06-01' and '2012-08-31'
and ws.utm_source = 'gsearch' and ws.utm_campaign = 'nonbrand'
and b.pageview_url in ('/home', '/lander-1'))