view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    group_label: "ID STUFF"
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: days_since_order {
    sql: current_date - ${created_date} ;;
  }

  dimension: orders_bucket {
    case: {
      when: {
        sql: ${days_since_order} <= 99;;
        label: "6"
      }
      when: {
        sql: ${days_since_order} >= 99 ;;
        label: "7"
      }

      else: "Nothing"
    }
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
    drill_fields: [user_id]
  }
  parameter: testing_stuff {
    allowed_value: {
      label: "test"
      value: "testier"
    }
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
    link: {label: "Explore Top 20 Results by Sale Price" url: "{{ link }}&sorts=order_items.sale_price+desc&limit=20" }
    #html: {{percentage_of_total_orders._rendered_value}} ;;
  }
  measure: percentage_of_total_orders{
    type: percent_of_total
    sql: ${count} ;;
    drill_fields: [order_items.count,user.gender,user.age_tier]
    #html:   <img src="https://chart.googleapis.com/chart?chs=400x250&cht=gom&chma=10,0,0,0&chxt=y&chco=635189,B1A8C4,1EA8DF,8ED3EF&chf=bg,s,FFFFFF00&chl={{ rendered_value }}&chd=t:{{ value }}">;;
  }

  measure: count_last_28_days {
    type:  count
    filters: {
      field: created_date
      value: "last 28 days"
    }
  }
  measure: formatted_count {
    type: count
    html:
    {% if value > 100 %}
      <font color="darkgreen">{{ rendered_value }}</font>
    {% elsif value > 50 %}
      <font color="goldenrod">{{ rendered_value }}</font>
    {% else %}
      <font color="darkred">{{ rendered_value }}</font>
    {% endif %} ;;
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
