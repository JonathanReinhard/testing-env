view: inventory_items {
  sql_table_name: demo_db.inventory_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: sold {
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
    sql: ${TABLE}.sold_at ;;
  }
  dimension: is_sold {
    type: yesno
    sql: ${sold_raw} is not null ;;
  }

  measure: count {
    type: count
    drill_fields: [id, products.item_name, products.id, order_items.count]
  }
  measure: number_on_hand {
    type: count
    filters: {
      field: is_sold
      value: "No"
    }
  }
  measure: stock_coverage_ratio {
    type:  number
    description: "Stock on Hand vs Trailing 28d Sales Ratio"
    sql:  1.0 * ${number_on_hand} / nullif(${order_items.count_last_28d},0) ;;
    value_format_name: decimal_2
# Optional HTML styling to color-code:
    html: <p style="color: black; background-color: rgba({{ value | times: -100.0 | round | plus: 250 }},{{value | times: 100.0 | round | plus: 100}},100,80); font-size:100%; text-align:center">{{ rendered_value }}</p> ;;
  }
}
