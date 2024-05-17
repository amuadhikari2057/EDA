select 
sum(case when a.total_webpageviews = 1 then 1 else 0 end) as bounded_session,
count(a.website_session_id) as total_sessions, 
sum(case when a.total_webpageviews = 1 then 1 else 0 end)/count(a.website_session_id) as rate
from
(select 
count(website_pageview_id) as total_webpageviews, 
website_session_id
from website_pageviews
where created_at < '2012-06-14'
group by website_session_id)a;
select 
sum(case when b.count_pageviews = 1 then 1 else 0 end) as bounded_sessions,
b.pageview_url,
count(b.website_pageview_id) as total_sessions,
sum(case when b.count_pageviews = 1 then 1 else 0 end)/ count(b.website_pageview_id) as rate
