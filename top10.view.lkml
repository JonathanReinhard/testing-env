view: top10 {
  derived_table: {
    sql: SELECT
        users.state  AS state,
        COUNT(*) AS count
      FROM demo_db.users  AS users

      GROUP BY 1
      ORDER BY count DESC
      LIMIT 10
       ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: count {
    type: number
    sql: ${TABLE}.count ;;
  }

  set: detail {
    fields: [state, count]
  }
}
