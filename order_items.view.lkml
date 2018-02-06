view: order_items {
  sql_table_name: demo_db.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
    value_format: "0.00\"€\""
    html: {{ rendered_value | replace: '.', 'z' | replace: ',','.' | replace: 'z', ','}} ;;
  }

  measure: count {
    type: count
    drill_fields: [id, inventory_items.id, orders.id]
  }
  measure: Average_sales_price {
    type: average
    sql: ${sale_price} ;;
    value_format_name: usd
  }
  measure: Total_sales_price {
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd
    drill_fields: [sales_details*]
  }
  measure: most_expensive_item {
    type: max
    sql: ${sale_price} ;;
    value_format_name: usd
  }
  measure: least_expensive_item {
    type: min
    sql: ${sale_price} ;;
    value_format_name: usd
  }
  dimension: returned_item {
    type: yesno
    sql: ${returned_date} IS NOT Null ;;
  }

  measure: count_last_28d {
    type: count
    hidden: yes
    filters: {
      field: inventory_items.created_date
      value: "28 days"
    }
  }
  set: sales_details {
    fields: [products.item_name,sale_price,count]
  }
}
