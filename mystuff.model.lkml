connection: "thelook"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: mystuff_default_datagroup {
 sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: mystuff_default_datagroup

datagroup: mystuff_orders_datagroup {
 sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "4 hours"
}

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
  join: order_items {
    type: left_outer
    relationship: many_to_one
    sql_on: ${inventory_items.id} = ${order_items.inventory_item_id} ;;
  }
}

explore: order_items {
  label: "Order Items"
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  persist_with: mystuff_orders_datagroup
  fields: [ALL_FIELDS*, -order_items.count_last_28d]

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  join: order_items {
    type: left_outer
    sql_on: ${order_items.order_id}=${orders.id} ;;
    relationship: one_to_one
  }
}

explore: products {
  join: inventory_items {
    type: left_outer
    sql_on: ${inventory_items.product_id}=${products.id};;
  relationship:one_to_one
  }
  join: order_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id}=${inventory_items.id} ;;
    relationship: one_to_one
  }

}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {

}

explore: customers {
  from: users
  label: "Customer Data"
  persist_with:mystuff_orders_datagroup
  fields: [ALL_FIELDS*,-customers.full_name,-customers.first_name,-customers.last_name,-customers.email]
    join:  orders{
    type: inner
    sql_on: ${customers.id}=${orders.user_id};;
    relationship: one_to_many
  }
}
explore: users_nn {
  }

explore: customer_facts {}

view: customer_facts {
 derived_table: {
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
 }

dimension: user_id {
  label: "User ID"
  sql: ${TABLE}.user_id ;;
}
}
