view: customer_facts {
  derived_table:{
    sql:
      SELECT users.id AS user_id,
           average_orders_per_month,
           COUNT(orders.user_id) AS total_number_of_orders,
           MIN(DATE(orders.created_at)) AS first_order_date,
           MAX(DATE(orders.created_at)) AS last_order_date,
           DATEDIFF(NOW(),MIN(DATE(orders.created_at))) AS days_since_first_purchase,
           IF(COUNT(orders.user_id)>1,"Yes","No") AS Repeat_customer
    FROM users
    LEFT JOIN
      (SELECT users.id,
              (COUNT(*) / COUNT(DISTINCT DATE_FORMAT(orders.created_at, "%M %Y"))) AS average_orders_per_month
       FROM users
       RIGHT JOIN orders ON users.id=orders.user_id
       GROUP BY 1
       ) AS avg_orders ON users.id = avg_orders.id
    RIGHT JOIN orders ON users.id=orders.user_id
    GROUP BY 1, 2
      ;;
    sql_trigger_value: SELECT FLOOR((UNIX_TIMESTAMP(NOW()) - 60*60*18)/(60*60*24)) ;;
    indexes: ["user_id"]
  }
  dimension: user_id {
    label: "User ID"
    sql: ${TABLE}.user_id ;;
  }

  dimension: first_order_date {
    type: date_time
  }

  dimension: last_order_date {
    type: date_time
  }

  measure: days_since_first_purchase {
    sql: ${TABLE}.days_since_first_purchase ;;
  }

  measure: total_number_of_orders {
    type: count
  }
  }
