view: products_total {
  derived_table: {
    sql: SELECT id,
    MAX(products.id) AS total_number_of_products

    FROM demo_db.products ;;
  }

  dimension: id {
    sql: ${TABLE}.id ;;
    primary_key: yes
  }


  measure: total_number_of_products {
    type: count
    #drill_fields: [id, item_name, inventory_items.count]
  }
}
