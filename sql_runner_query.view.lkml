view: sql_runner_query {
  derived_table: {
    sql: SELECT
        users.city  AS `users.city`,
        users.id AS `users.id`
      FROM demo_db.orders  AS orders
      LEFT JOIN demo_db.users  AS users ON orders.user_id = users.id

      GROUP BY 1
      ORDER BY users.state  DESC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: city {
    type: string
    sql: ${TABLE}.`users.city` ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.`users.id` ;;
  }

  set: detail {
    fields: []
  }
}
