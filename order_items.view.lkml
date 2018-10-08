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

  dimension: parameter_test {
  sql: ${TABLE}.order_id  ;;
  html:  {% if orders.testing_stuff == 'testier' %}
    {{ rendered_value }}
    {% else %}
    ${{ rendered_value }}
    {% endif %} ;;
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
#   measure: Total_sales_price {
#     type: sum
#     sql: ${sale_price} ;;
#     value_format_name: usd
#     drill_fields: [sales_details*]
#   }

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
  measure: total_sale_price {
    type: sum
    value_format_name: usd
    sql: ${sale_price} ;;
    drill_fields: [orders.created_month, users.gender, total_sale_price]
    link: {
      label: "Table Calc & Total"
      url: "
      {% assign table_calc = '[
      { \"table_calculation\": \"percent_of_total\",
      \"label\": \"Percent of Total\",
      \"expression\": \"${order_items.total_sale_price:row_total} / sum(${order_items.total_sale_price:row_total})\",
      \"value_format\": null,
      \"value_format_name\": \"percent_2\",
      \"_kind_hint\": \"supermeasure\",
      \"_type_hint\": \"number\"
      },
      { \"table_calculation\": \"growth_rate\",
      \"label\": \"Growth Rate\",
      \"expression\": \"${order_items.total_sale_price} / offset(${order_items.total_sale_price},1) - 1\",
      \"value_format\": null,
      \"value_format_name\": \"percent_2\",
      \"_kind_hint\": \"measure\",
      \"_type_hint\": \"number\"
      }]' %}
      {% assign vis_config = '{
      \"type\": \"table\",
      \"show_view_names\": false,
      \"show_row_numbers\": false,
      \"truncate_column_names\": false,
      \"table_theme\": \"gray\",
      \"enable_conditional_formatting\": true,
      \"conditional_formatting\": [
      {
      \"type\": \"low to high\",
      \"value\": null,
      \"background_color\": null,
      \"font_color\": null,
      \"palette\": {
      \"name\": \"Custom\",
      \"colors\": [
      \"#FFFFFF\",
      \"#6e00ff\"
      ]},
      \"bold\": false,
      \"italic\": false,
      \"strikethrough\": false,
      \"fields\": [
      \"growth_rate\"
      ]},{
      \"type\": \"low to high\",
      \"value\": null,
      \"background_color\": null,
      \"font_color\": null,
      \"palette\": {
      \"name\": \"Custom\",
      \"colors\": [
      \"#FFFFFF\",
      \"#88ff78\"
      ]},
      \"bold\": false,
      \"italic\": false,
      \"strikethrough\": false,
      \"fields\": [
      \"percent_of_total\"
      ]}]}' %}
      {{link}}&total=on&row_total=right&dynamic_fields={{ table_calc | replace: '  ', '' | encode_uri }}&pivots=users.gender&vis_config={{ vis_config | replace: '  ', '' | encode_uri }}"
    }
  }

  measure: stddev {
    type: number
    sql: stddev(${sale_price}) ;;
  }

  measure: average {
    type: average
    sql: ${sale_price} ;;
  }

  measure: zscore {
    type: number
    sql: ${sale_price} - ${average} / ${stddev} ;;
  }


  set: sales_details {
    fields: [products.item_name,sale_price,count]
  }
}
