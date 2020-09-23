view: testjoinstuff {
  sql_table_name: demo_db.orders ;;


   dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }
}
