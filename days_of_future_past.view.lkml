view: days_of_future_past {
  sql_table_name: demo_db.orders ;;

 dimension: is_past {
  type: number
   sql: CASE WHEN ${date} > CURRENT_DATE THEN NULL ELSE 1 END;;
  hidden: no
  }
  dimension: days_from_today {
    type: number
    sql: DATEDIFF(${date}, current_date);;
  }
  dimension: days_from_today_past {
    type: number
    sql: DATEDIFF(${date}, current_date)*${is_past};;
  }
  dimension: date {
    type: date
    sql: ${TABLE}.created_at ;;
  }
  }
