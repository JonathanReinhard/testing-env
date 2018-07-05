view: users {
  sql_table_name: demo_db.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [20, 30, 40, 50, 60]
    style: integer
    sql: ${age} ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    link: {
      label: "{{ value }}"
      url: "http://www.google.com/search?q={{ value }}"
      icon_url: "http://google.com/favicon.ico"
    }

  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
    link: {
      label: "{{ value }}"
      url: "http://www.google.com/search?q={{ value }}"
      icon_url: "http://google.com/favicon.ico"
    }
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

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: no_michael {
    sql: CASE
    WHEN ${first_name} = 'Michael' THEN Null
    WHEN ${first_name} <> 'Michael' THEN ${first_name}
    END;;
  }

dimension: toto {
  sql: (${first_name} FROM (SELECT ${first_name} FROM demob_db.users WHERE ${first_name} NOT IN ('Michael'))) ;;
}

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: full_name {
    type: string
    sql: CONCAT(${first_name},' ',${last_name}) DESC ;;
  }
  dimension: full_name_test {
    type:  string
    sql: CASE
    WHEN ${first_name} = 'Zachary' THEN ${first_name}
    ELSE CONCAT(${first_name},' ',${last_name})
    END;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [state,count]
  }
  measure: average_age {
    type: average
    sql: ${age} ;;
    value_format_name: "decimal_2"
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      last_name,
      first_name,
      events.count,
      orders.count,
      user_data.count
    ]
  }
  set: setty {
    fields: [user.*]
  }
}
