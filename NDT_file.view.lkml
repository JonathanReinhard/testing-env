# If necessary, uncomment the line below to include explore_source.
# include: "mystuffs.model.lkml"
include: "orders.view.lkml"
include: "order_items.view.lkml"
include: "inventory_items.view.lkml"

view: NDT_file {
  derived_table: {
    explore_source: orders {
      column: created_time {}
      column: status {}
      column: count {}
      column: id {}
      column: sale_price { field: order_items.sale_price }
    }
  }
  dimension: created_time {
    type: date
  }
  dimension: status {
    type: string
  }
  measure: count {
    type: count
  }
  dimension: id {
    primary_key: yes
    type: number
  }

  measure: sales_price {
    type: sum
  }


}
