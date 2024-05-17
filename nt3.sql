select 
count(a.website_pageview_id),
a.pageview_url
from
(select 
wp.website_session_id,
wp.website_pageview_id,
wp.pageview_url
from website_pageviews wp
where wp.website_pageview_id in 
(select 
min(website_pageview_id) as website_pageview_id
 from website_pageviews
 where created_at < '2012-06-12'
 group by website_session_id))a
 group by a.pageview_url;