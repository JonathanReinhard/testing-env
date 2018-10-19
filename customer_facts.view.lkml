view: customer_facts {
  #view_label: "Orders"
  derived_table:{
    sql:
      SELECT users.id AS user_id,
      users.first_name as first_name
    FROM demo_db.users as users
    WHERE created_at >= {% date_start Datefilter %} AND created_at < {% date_end Datefilter %}

    ;;
persist_for: "5 minutes"
  }

  filter: Datefilter {
    type: date
    convert_tz: no
  }

  dimension: user_id {
    group_label: "ID STUFF"
    label: "User ID"
    sql: ${TABLE}.user_id ;;
  }
  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
    full_suggestions: yes
  }

  dimension: first_order_date {
    type: date_time
  }

  dimension: last_order_date {
    type: date_time
  }

  dimension: orders_created_at {
    type: date_time
    sql: ${TABLE}.orders_created_at ;;
  }

  measure: days_since_first_purchase {
    sql: ${TABLE}.days_since_first_purchase ;;
  }

  measure: total_number_of_orders {
    type: count
  }
}
