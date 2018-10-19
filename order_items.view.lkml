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
  parameter: max_rank {
    type: number
  }

  dimension: rank_limit {
    type: number
    sql: {% parameter max_rank %} ;;
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

  measure: count2 {
    type: count_distinct
    sql: ${id} ;;
    drill_fields: [orders.created_date, total_sale_price]
    link: {
      label: "Show as scatter plot"
      url: "
      {% assign vis_config = '{
      \"stacking\"                  : \"\",
      \"show_value_labels\"         : false,
      \"label_density\"             : 25,
      \"legend_position\"           : \"center\",
      \"x_axis_gridlines\"          : true,
      \"y_axis_gridlines\"          : true,
      \"show_view_names\"           : false,
      \"limit_displayed_rows\"      : false,
      \"y_axis_combined\"           : true,
      \"show_y_axis_labels\"        : true,
      \"show_y_axis_ticks\"         : true,
      \"y_axis_tick_density\"       : \"default\",
      \"y_axis_tick_density_custom\": 5,
      \"show_x_axis_label\"         : false,
      \"show_x_axis_ticks\"         : true,
      \"x_axis_scale\"              : \"auto\",
      \"y_axis_scale_mode\"         : \"linear\",
      \"show_null_points\"          : true,
      \"point_style\"               : \"circle\",
      \"ordering\"                  : \"none\",
      \"show_null_labels\"          : false,
      \"show_totals_labels\"        : false,
      \"show_silhouette\"           : false,
      \"totals_color\"              : \"#808080\",
      \"type\"                      : \"looker_scatter\",
      \"interpolation\"             : \"linear\",
      \"series_types\"              : {},
      \"colors\": [
      \"palette: Santa Cruz\"
      ],
      \"series_colors\"             : {},
      \"x_axis_datetime_tick_count\": null,
      \"trend_lines\": [
      {
      \"color\"             : \"#000000\",
      \"label_position\"    : \"left\",
      \"period\"            : 30,
      \"regression_type\"   : \"average\",
      \"series_index\"      : 1,
      \"show_label\"        : true,
      \"label_type\"        : \"string\",
      \"label\"             : \"30 day moving average\"
      }
      ]
      }' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
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
