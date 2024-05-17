select 
min(ws.created_at) as week_start,
week(ws.created_at) as week_at,
ws.device_type,
count(ws.website_session_id) as total_sessions,
count(o.order_id) as ordered_sessions,
count(o.order_id)/count(ws.website_session_id) as rate
from website_sessions ws 
left join orders o on ws.website_session_id = o.website_session_id
where ws.created_at between '2012-04-15'and '2012-06-09' and ws.utm_source = 'gsearch' and ws.utm_campaign = 'nonbrand'
group by ws.device_type, year(ws.created_at), week(ws.created_at)
order by ws.device_type;
