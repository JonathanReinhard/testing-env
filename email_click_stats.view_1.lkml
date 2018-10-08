view: email_click_stats {

  derived_table: {
    sql:
    select
      companyid,
      email,
      count_if(days_ago >= 0 and days_ago < 7)   as clicks_within_0_7,
      count_if(days_ago >= 8 and days_ago < 14)  as clicks_within_8_14,
      count_if(days_ago >= 15 and days_ago < 28)  as clicks_within_15_28,
      count_if(days_ago >= 29 and days_ago < 90)  as clicks_within_29_90,
      count_if(days_ago >= 91 and days_ago < 180) as clicks_within_91_180,
      count_if(days_ago >= 181 and days_ago < 270) as clicks_within_181_270,
      count_if(days_ago >= 271 and days_ago < 365) as clicks_within_271_365,
      approx_distinct(case when days_ago >= 0 and days_ago < 7 then messagepid else null end)   as unique_clicks_within_0_7,
      approx_distinct(case when days_ago >= 8 and days_ago < 14 then messagepid else null end)  as unique_clicks_within_8_14,
      approx_distinct(case when days_ago >= 15 and days_ago < 28 then messagepid else null end)  as unique_clicks_within_15_28,
      approx_distinct(case when days_ago >= 29 and days_ago < 90 then messagepid else null end)  as unique_clicks_within_29_90,
      approx_distinct(case when days_ago >= 91 and days_ago < 180 then messagepid else null end) as unique_clicks_within_91_180,
      approx_distinct(case when days_ago >= 181 and days_ago < 270 then messagepid else null end) as unique_clicks_within_181_270,
      approx_distinct(case when days_ago >= 271 and days_ago < 365 then messagepid else null end) as unique_clicks_within_271_365,
      max(clickdate) last_click_date
    FROM (
      select
      companyid, email, clickdate, messagepid, date_diff('day', date_trunc('day', clickdate), current_date) days_ago
      from email_click_base
      where clickdate between current_date - interval '1' year and current_date) x
    group by 1,2
    ;;
  }

  dimension: email_activity.last_click_date {
    type: date
    description: "Includes clicks up to 1 year ago."
    sql: ${TABLE}.last_click_date ;;
  }

  dimension: email_activity.unique_clicks_within_0_7 {
    group_label: "Unique Clicks Count"
    label: "1. Unique Clicks Past 7 Days"
    type: number
    sql: ${TABLE}.unique_clicks_within_0_7 ;;
  }

  dimension: email_activity.unique_clicks_within_8_14 {
    group_label: "Unique Clicks Count"
    label: "2. Unique Clicks Past 8-14 Days"
    type: number
    sql: ${TABLE}.unique_clicks_within_8_14 ;;
  }

  dimension: email_activity.unique_clicks_within_15_28 {
    group_label: "Unique Clicks Count"
    label: "3. Unique Clicks Past 15-28 Days"
    type: number
    sql: ${TABLE}.unique_clicks_within_15_28 ;;
  }

  dimension: email_activity.unique_clicks_within_29_90 {
    group_label: "Unique Clicks Count"
    label: "4. Unique Clicks Past 29-90 Days"
    type: number
    sql: ${TABLE}.unique_clicks_within_29_90 ;;
  }

  dimension: email_activity.unique_clicks_within_91_180 {
    group_label: "Unique Clicks Count"
    label: "5. Unique Clicks Past 91-180 Days"
    type: number
    sql: ${TABLE}.unique_clicks_within_91_180 ;;
  }

  dimension: email_activity.unique_clicks_within_181_270 {
    group_label: "Unique Clicks Count"
    label: "6. Unique Clicks Past 181-270 Days"
    type: number
    sql: ${TABLE}.unique_clicks_within_181_270 ;;
  }

  dimension: email_activity.unique_clicks_within_271_365 {
    group_label: "Unique Clicks Count"
    label: "7. Unique Clicks Past 271-365 Days"
    type: number
    sql: ${TABLE}.unique_clicks_within_271_365 ;;
  }

  dimension: email_activity.clicks_within_0_7 {
    group_label: "Total Clicks Count"
    label: "1. Clicks Past 7 Days"
    type: number
    sql: ${TABLE}.clicks_within_0_7 ;;
  }

  dimension: email_activity.clicks_within_8_14 {
    group_label: "Total Clicks Count"
    label: "2. Clicks Past 8-14 Days"
    type: number
    sql: ${TABLE}.clicks_within_8_14 ;;
  }

  dimension: email_activity.clicks_within_15_28 {
    group_label: "Total Clicks Count"
    label: "3. Clicks Past 15-28 Days"
    type: number
    sql: ${TABLE}.clicks_within_15_28 ;;
  }

  dimension: email_activity.clicks_within_29_90 {
    group_label: "Total Clicks Count"
    label: "4. Clicks Past 29-90 Days"
    type: number
    sql: ${TABLE}.clicks_within_29_90 ;;
  }

  dimension: email_activity.clicks_within_91_180 {
    group_label: "Total Clicks Count"
    label: "5. Clicks Past 91-180 Days"
    type: number
    sql: ${TABLE}.clicks_within_91_180 ;;
  }

  dimension: email_activity.clicks_within_181_270 {
    group_label: "Total Clicks Count"
    label: "6. Clicks Past 181-270 Days"
    type: number
    sql: ${TABLE}.clicks_within_181_270 ;;
  }

  dimension: email_activity.clicks_within_271_365 {
    group_label: "Total Clicks Count"
    label: "7. Clicks Past 271-365 Days"
    type: number
    sql: ${TABLE}.clicks_within_271_365 ;;
  }

}
