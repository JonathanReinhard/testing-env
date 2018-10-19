connection: "thelook"

# include all the views
include: "*.view"
include: "*explore"

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

explore: testjoinstuff {
  join: contacts {
    from: users
    sql_on: ${contacts.id}=${testjoinstuff.user_id} AND ${contacts.city}="New York" ;;
    relationship: many_to_one
  }
  join: leads {
    from: users
    sql_on: ${leads.id}=${testjoinstuff.user_id} AND ${leads.city}="Chicago" ;;
    relationship: many_to_one

  }
}

explore: top10 {}

explore: pdt_test {}
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
  join: num {
    type: cross
    relationship: one_to_many
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

  join: num {
    type: cross
    relationship: one_to_many
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
  join: customer_facts {
    type: left_outer
    sql_on: ${customer_facts.user_id}=${orders.user_id} ;;
    relationship: one_to_one
  }
  join: sql_runner_query {
    type: left_outer
    sql_on: ${sql_runner_query.user_id}=${orders.user_id} ;;
    relationship: one_to_one
  }
  join: days_of_future_past {
    type: left_outer
    sql_on: ${orders.created_date}=${days_of_future_past.date} ;;
    relationship: many_to_many
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
  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id}=${orders.id} ;;
    relationship: one_to_one
  }
  join: customer_facts {
    type: left_outer
    sql_on: ${customer_facts.user_id}=${orders.user_id} ;;
    relationship: one_to_one
  }
  join: num {
    type: cross
    relationship: one_to_many
  }
  join: products_total {
    sql_on: ${products.id}=${products_total.id} ;;
    relationship: one_to_many
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

explore: user_michael {
  view_name: users
  sql_always_where: ${users.first_name}= "Michael" ;;
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

explore: customer_facts {
}
