
SELECT COUNT(DISTINCT utm_campaign)
FROM page_visits;

SELECT COUNT(DISTINCT utm_source)
FROM page_visits;

SELECT DISTINCT utm_campaign, utm_source
FROM page_visits;


SELECT DISTINCT page_name
FROM page_visits;


WITH first_touch AS (
    SELECT user_id,
           MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id),
ft_utm AS (
    SELECT ft.user_id,
           ft.first_touch_at,
           pv.utm_source,
           pv.utm_campaign
    FROM first_touch ft
    JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp)
SELECT COUNT(*),
       ft_utm.utm_campaign,
       ft_utm.utm_source
FROM ft_utm
GROUP BY 2
ORDER BY 1 DESC;


WITH last_touch AS (
    SELECT user_id,
           MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id),
lt_utm AS (
    SELECT lt.user_id,
   	   lt.last_touch_at,
 	   pv.utm_source,
	   pv.utm_campaign
    FROM last_touch AS 'lt'
    JOIN page_visits AS 'pv'
    	 ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp)
 SELECT COUNT(*),
 	lt_utm.utm_campaign,
        lt_utm.utm_source
 FROM lt_utm
 GROUP BY 2
 ORDER BY 1 DESC;


 SELECT COUNT(DISTINCT user_id)
 FROM page_visits
 WHERE page_name='4 - purchase';


WITH last_touch AS (
    SELECT user_id,
           MAX(timestamp) as last_touch_at
    FROM page_visits
    WHERE page_name = '4 - purchase'
    GROUP BY user_id),
lt_utm AS (
  SELECT lt.user_id,
   	 lt.last_touch_at,
 	 pv.utm_source,
	 pv.utm_campaign
  FROM last_touch AS 'lt'
  JOIN page_visits AS 'pv'
       ON lt.user_id = pv.user_id
          AND lt.last_touch_at = pv.timestamp)
 SELECT COUNT(*),
 	lt_utm.utm_campaign,
        lt_utm.utm_source
 FROM lt_utm
 GROUP BY 2
 ORDER BY 1 DESC;
