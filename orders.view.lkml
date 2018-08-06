view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      hour,
      date,
      week,
      day_of_week,
      month,
      month_name,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: date_month {
    datatype: datetime
    type: date_month
    sql: ${TABLE}.created_at ;;
  }

measure: latest_order {
  type: date
  sql: MAX(${created_raw}) ;;
  convert_tz: no
  }

  dimension: year {
    type: string
    sql: ${TABLE}.created_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.first_name, users.id, order_items.count]
  }
  measure: percentage_of_total_orders{
    type: percent_of_total
    sql: ${count} ;;
    drill_fields: [order_items.count,user.gender,user.age_tier]
  }



  measure: sales_cost_calculation{
    type: sum
    sql: order_items.sale_price-inventory_items.cost ;;
    value_format_name: usd
  }
  dimension: last_3_month {
    type: number
    sql: CASE
    WHEN ${created_date} IS NOT NULL AND DATEDIFF(NOW(), ${created_date} ) <=21
    THEN DATEDIFF(NOW(), ${created_date} )
    ELSE NULL
    END
    ;;
  }
}
