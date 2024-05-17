select
sum(case when b.no_of_pageviews = 1 then 1 else 0 end) as bounced_sessions,
count(b.no_of_pageviews) as total_sessions,
min(b.created_at) as week_start,
b.pageview_url,
sum(case when b.no_of_pageviews = 1 then 1 else 0 end)/count(b.no_of_pageviews) as rate

from
website_sessions ws
join
(select 
a.*, wp.created_at,wp.pageview_url
from website_pageviews wp
join
 (select
website_session_id,
min(website_pageview_id) as website_pageview_id,
count(website_pageview_id) as no_of_pageviews
from website_pageviews
group by website_session_id)a on a.website_pageview_id = wp.website_pageview_id)b on b.website_session_id = ws.website_session_id
where ws.utm_source = 'gsearch' and ws.utm_campaign = 'nonbrand' and ws.created_at between '2012-06-01' and '2012-08-31'
group by b.pageview_url, year(b.created_at), week(b.created_at) ;
