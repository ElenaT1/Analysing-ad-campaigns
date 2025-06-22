with conversion_records as (
select 
variation,
geo,
sum(clicks) as conv
FROM
  `sbc-interview.dataset.ad_performance_test`
where profit>0
group by
variation,
geo),
main as (
SELECT
  ad_perf.variation as variation,
  ad_perf.geo as geo,
  SUM(impressions) AS `Total number of impressions`,
  SUM(clicks) AS `Total clicks`,
  (SUM(Clicks)/SUM(Impressions))*100 as `Click-through rate`,
  SUM(profit) AS `Total profit`,
  (SUM(profit)/SUM(clicks))*100 as `Profit per click`,
  SUM(profit)/SUM(total_spend) as `Profit per money spend`
FROM
  `sbc-interview.dataset.ad_performance_test1` as ad_perf
GROUP BY
  ad_perf.variation,
  ad_perf.geo)
select 
main.variation,
main.geo,
main.`Total number of impressions`, 
main.`Total clicks`,
main.`Click-through rate`,
main.`Total profit`,
main.`Profit per click`,
main.`Profit per money spend`,
conv.conv as `Conversion proxy`,
conv.conv*100/main.`Total clicks` as `Conversion rate proxy` 
from main join conversion_records conv on conv.variation=main.variation and main.geo=conv.geo

