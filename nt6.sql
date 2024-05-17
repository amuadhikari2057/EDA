select 
count(ws.website_session_id) as sessions,
count(o.website_session_id) as orders,
count(o.order_id)/count(ws.website_session_id) as rate
from website_sessions ws 
left join orders o on o.website_session_id = ws.website_session_id
where ws.utm_source = 'gsearch' and ws.utm_campaign = 'nonbrand' and ws.created_at < '2012-04-14'