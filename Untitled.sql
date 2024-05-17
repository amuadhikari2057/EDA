select 
count(ws.website_session_id) as total_sessions,
count(o.order_id) as ordered_sessions,
count(o.order_id)/count(ws.website_session_id) as rate,
min(date(ws.created_at)) as month_start,
month(ws.created_at) as mnth
from website_sessions ws
left join orders o on o.website_session_id = ws.website_session_id
where ws.created_at < '2012-11-27' and ws.utm_source = 'gsearch'
group by year(ws.created_at), month(ws.created_at);
#-------------------------------------------------------------------------------
select 
count(distinct case when ws.utm_campaign = 'nonbrand' then ws.website_session_id else null end) as nonbrand_sessions,
count(distinct case when ws.utm_campaign = 'brand' then ws.website_session_id else null end) as brand_sessions,
count(distinct case when utm_campaign = 'nonbrand' then o.order_id else null end) as nonbrand_orders,
count(distinct case when utm_campaign = 'brand' then o.order_id else null end) as brand_orders,
min(date(ws.created_at)) as month_start,
month(ws.created_at) as mnth
from website_sessions ws
left join orders o on o.website_session_id = ws.website_session_id
where ws.created_at < '2012-11-27' and ws.utm_source = 'gsearch' 
group by year(ws.created_at), month(ws.created_at);
#------------------------------------------------------------------------------------------
select 
count(case when device_type = 'mobile' then ws.website_session_id else null end) as mobile_sessions,
count(case when device_type = 'desktop' then ws.website_session_id else null end) as desktop_sessions,
count(case when device_type = 'mobile' then o.order_id else null end) as mobile_ordered_sessions,
count(case when device_type = 'desktop' then o.order_id else null end) as desktop_ordered_sessions,
year(ws.created_at),
month(ws.created_at)
from website_sessions ws 
left join orders o on o.website_session_id = ws.website_session_id
where ws.created_at < '2012-11-27' and ws.utm_source = 'gsearch' and ws.utm_campaign = 'nonbrand'
group by 5,6;
#-----------------------------------------------------------------------------------------------------
with cte as (select 
ws.utm_source,
count(ws.website_session_id) as total_session,
count(o.order_id) as ordered_session,
year(ws.created_at) as yr,
month(ws.created_at) as mnth
from website_sessions ws
left join orders o on o.website_session_id = ws.website_session_id
where ws.created_at < '2012-11-27'
group by 1,4,5)
select * from cte
where utm_source is not null;
#--------------------------------------------------------------------------------------------
select 
year(ws.created_at) as yr,
month(ws.created_at) as mnth,
count(ws.website_session_id) as total_sessions,
count(o.order_id) as ordered_sessions,
count(o.order_id)/count(ws.website_session_id) as rate
 from website_sessions ws 
 left join orders o on o.website_session_id = ws.website_session_id
 where ws.created_at < '2012-11-27'
 group by 1,2;
 #----------------------------------------------------------------------------------------------
 select 
min(website_pageview_id)
 from website_pageviews
 where pageview_url = '/lander-1';

select 
count(o.order_id) as ordered_sessions,
count(b.website_session_id) as total_sessions,
b.pageview_url,
count(o.order_id)/count(b.website_session_id) as rate
 from orders o 
 right join
 (select 
a.*
from website_sessions ws
join
 (select
 website_session_id, 
 website_pageview_id,
 pageview_url from website_pageviews
 where website_pageview_id in (select 
 min(website_pageview_id) as website_pageview_id
 from website_pageviews
 where website_pageview_id >= 23504
 group by website_session_id))a on a.website_session_id = ws.website_session_id
 where ws.utm_source = 'gsearch' and ws.utm_campaign = 'nonbrand' and ws.created_at between '2012-06-19' and '2012-07-28')b
 on b.website_session_id = o.website_session_id
 group by b.pageview_url;
#------------------------------------------------------------------------------------------------------------------
select
sum(case when pageview_url = '/lander-1' then 1 else 0 end)as lander_1_page,
sum(case when pageview_url = '/home' then 1 else 0 end) as home_page,
sum(case when pageview_url = '/products' then 1 else 0 end) as product_page,
sum(case when pageview_url = '/the-original-mr-fuzzy' then 1 else 0 end) as fuzzy_page,
sum(case when pageview_url = '/cart' then 1 else 0 end)as cart_page,
sum(case when pageview_url = '/shipping' then 1 else 0 end) as shipping_page,
sum(case when pageview_url = '/billing' then 1 else 0 end) as billing_page,
sum(case when pageview_url = '/thank-you-for-your-order' then 1 else 0 end) as thankyou_page
from
 website_pageviews
 where created_at  between '2012-06-19' and '2012-07-28';
#---------------------------------------------------------------------------------------------














