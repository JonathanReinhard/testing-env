#include: "email_send_stats.view"
#include: "email_open_stats.view"
#include: "email_click_stats.view"


view: email_engagement_stats {
  #extends: [email_send_stats, email_open_stats, email_click_stats]
  derived_table: {
    create_process: {
      sql_step:
        CREATE TABLE ${SQL_TABLE_NAME} with (partitioned_by = ARRAY['company_id']) AS
        select coalesce(st.email, ot.email, ct.email)             email,
            max(st.last_send_date)                             last_send_date,
            max(nullif(st.sends_within_0_7, 0))                sends_within_0_7,
            max(nullif(st.sends_within_8_14, 0))               sends_within_8_14,
            max(nullif(st.sends_within_15_28, 0))              sends_within_15_28,
            max(nullif(st.sends_within_29_90, 0))              sends_within_29_90,
            max(nullif(st.sends_within_91_180, 0))             sends_within_91_180,
            max(nullif(st.sends_within_181_270, 0))            sends_within_181_270,
            max(nullif(st.sends_within_271_365, 0))            sends_within_271_365,
            max(ot.last_open_date)                             last_open_date,
            max(nullif(ot.opens_within_0_7, 0))                opens_within_0_7,
            max(nullif(ot.opens_within_8_14, 0))               opens_within_8_14,
            max(nullif(ot.opens_within_15_28, 0))              opens_within_15_28,
            max(nullif(ot.opens_within_29_90, 0))              opens_within_29_90,
            max(nullif(ot.opens_within_91_180, 0))             opens_within_91_180,
            max(nullif(ot.opens_within_181_270, 0))            opens_within_181_270,
            max(nullif(ot.opens_within_271_365, 0))            opens_within_271_365,
            max(ct.last_click_date)                            last_click_date,
            max(nullif(ct.clicks_within_0_7, 0))               clicks_within_0_7,
            max(nullif(ct.clicks_within_8_14, 0))              clicks_within_8_14,
            max(nullif(ct.clicks_within_15_28, 0))             clicks_within_15_28,
            max(nullif(ct.clicks_within_29_90, 0))             clicks_within_29_90,
            max(nullif(ct.clicks_within_91_180, 0))            clicks_within_91_180,
            max(nullif(ct.clicks_within_181_270, 0))           clicks_within_181_270,
            max(nullif(ct.clicks_within_271_365, 0))           clicks_within_271_365,
            max(nullif(ct.unique_clicks_within_0_7, 0))        unique_clicks_within_0_7,
            max(nullif(ct.unique_clicks_within_8_14, 0))       unique_clicks_within_8_14,
            max(nullif(ct.unique_clicks_within_15_28, 0))      unique_clicks_within_15_28,
            max(nullif(ct.unique_clicks_within_29_90, 0))      unique_clicks_within_29_90,
            max(nullif(ct.unique_clicks_within_91_180, 0))     unique_clicks_within_91_180,
            max(nullif(ct.unique_clicks_within_181_270, 0))    unique_clicks_within_181_270,
            max(nullif(ct.unique_clicks_within_271_365, 0))    unique_clicks_within_271_365,
            coalesce(st.companyid, ot.companyid, ct.companyid) company_id
          from ${email_send_stats.SQL_TABLE_NAME} st
          full outer join ${email_open_stats.SQL_TABLE_NAME} ot
            on st.companyid = ot.companyid and st.email = ot.email
          full outer join ${email_click_stats.SQL_TABLE_NAME} ct
            on ot.companyid = ct.companyid and ot.email = ct.email
          group by 1,33;;

      sql_step:
        INSERT INTO looker_scratch.pdt_status VALUES (cast(split('${SQL_TABLE_NAME}', '.')[2] as varchar) , cast('SUCCESS' as varchar), cast(current_timestamp as timestamp));;
    }
    datagroup_trigger: email_engagement_stats_datagroup
  }

  dimension: company_id {
    type: number
    hidden: yes
    sql: ${TABLE}.company_id ;;
  }

  dimension: email {
    type: string
    hidden: yes
    sql: ${TABLE}.email ;;
  }

  dimension: key {
    type: string
    primary_key: yes
    hidden: yes
    sql: cast(${company_id} as varchar) || ${email} ;;
  }
}
