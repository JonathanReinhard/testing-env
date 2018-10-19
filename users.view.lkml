view: users {
  sql_table_name: demo_db.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    drill_fields: [detail*]
  }


  dimension: id2 {
    type: string
    sql: ${TABLE}.id ;;
    drill_fields: [detail*]
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [0,20, 30, 40, 50, 60]
    style: classic
    sql: ${age} ;;
  }

  dimension: age_tier_case {
    case: {
      when: {
        sql: ${age}<10 ;;
        label: "Ten"
      }
      when: {
        sql: ${age}<20 AND ${age}>10 ;;
        label: "Twenty"
      }
      when: {
        sql: ${age}=${age} ;;
        label: "All"
      }
      else: "Someotherstuff"
    }
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    link: {
      label: "{{ value }}"
      url: "http://www.google.com/search?q={{ value }}"
      icon_url: "http://google.com/favicon.ico"
    }
#     html: <div style="width:100%; text-align: centre;"> <details>
#     <summary style="outline:none">{{ city._linked_value }}</summary>
#      Order Count: {{ orders.count._value }}
#     <br/>
#
#
#     </details>
#     </div>;;

  }

  dimension: department {
    case: {
      when: {
        sql: ${city}="San Francisco" ;;
        label:"Department A"
      }
      when: {
        sql: ${city}="San Diego" ;;
        label: "Department B"
      }
      else: "Other Department"
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
    sql: CONCAT(${first_name},',',${last_name}) ;;
    link:{
      label: "test"
      url: "https://localhost:9999/dashboards/1?customer={{users.full_name._value | replace: ',','^,'}}"
    }  }
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
#     html: <div style="width:100%; text-align: centre;"> <details>
#     <summary style="outline:none">{{ state._linked_value }}</summary>
#     City: {{ city._linked_value }}
#     <br/>
#       </details>
#     </div>;;
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

  dimension: Score_tier_label{
    label: "Score_label"
    link: {
      label:"{{value}}"
      url:"{{users.score_tier_link._value}}"
    }
    case: {
      when: {
        sql: ${age}= 0 ;;
        label: "Paid Liens"
      }
      when: {
        sql: ${age}>0 AND ${age}<20 ;;

        label: "Lien Score 1-449"
      }
      when: {
        sql: ${age}>= 20 AND ${age}<30 ;;
        label: "Lien Score 450-549"
      }
      when: {
        sql: ${age}>= 30 AND ${age}<60 ;;
        label: "Lien Score 550-650"
      }
    }
  }


  dimension: score_tier_link {
    type: string
    hidden: yes
    sql:
      CASE WHEN ${Score_tier_label} = 'Paid Liens'
    THEN "https://localhost:9999/dashboards/1152"
    WHEN ${Score_tier_label} = 'Lien Score 1-449'
    THEN "https://localhost:9999/dashboards/1153"
      WHEN ${Score_tier_label} = 'Lien Score 450-549'
    THEN "https://localhost:9999/dashboards/1153"
    WHEN ${Score_tier_label} = 'Lien Score 550-650'
    THEN "https://localhost:9999/dashboards/1154"
    ELSE null
    END;;
  }

  dimension: is_top_ten_countries_by_quantity {
    type: yesno
    sql: ${state} IN
        (SELECT state FROM
        (
        SELECT
        state
        FROM public.users AS users
        GROUP BY 1
        ORDER BY SUM(${id}) DESC
        LIMIT 10
        ));;
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
