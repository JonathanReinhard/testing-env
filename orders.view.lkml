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

  dimension: yesno {
    type: yesno
    sql: ${status}="complete" ;;
  }


  parameter:  bucket_size {
    default_value: "10"
    type: unquoted
#hidden: yes
    label: "Filter - Tier Attainment % Band Size"
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

  parameter: Month_Selector {
    allowed_value: {
      label: "January"
      value: "01"
    }
    allowed_value: {
      label: "February"
      value: "02"
    }
    allowed_value: {
      label: "March"
      value: "03"
    }
    allowed_value: {
      label: "April"
      value: "04"
    }
    allowed_value: {
      label: "May"
      value: "05"
    }
    allowed_value: {
      label: "June"
      value: "06"
    }
    allowed_value: {
      label: "July"
      value: "07"
    }
    allowed_value: {
      label: "August"
      value: "08"
    }
    allowed_value: {
      label: "September"
      value: "09"
    }
    allowed_value: {
      label: "October"
      value: "10"
    }
    allowed_value: {
      label: "November"
      value: "11"
    }
    allowed_value: {
      label: "December"
      value: "12"
    }
  }

  dimension: yesno_same_month {
    type: yesno
    sql: MONTH(${orders.created_raw})= {% parameter Month_Selector %} ;;
    hidden: yes
  }

  measure: filtered_count {
    type: count
    filters: {
      field: yesno_same_month
      value: "Yes"
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
      fiscal_quarter_of_year,
      year
    ]
    sql: ${TABLE}.created_at ;;
    drill_fields: [user_id]
    hidden: no
  }

  dimension: date_month2 {
    type: date_month
    sql: ${created_raw} ;;
  }

  measure: first_order {
    type: date
    sql: min(${created_raw}) ;;
    convert_tz: no
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
  parameter: max_rank {
    type: number
  }

  dimension: rank_limit {
    type: number
    sql: {% parameter max_rank %} ;;
  }

  dimension: complete {
    type: number
    sql: Count(${status}!="complete") ;;
  }


}
