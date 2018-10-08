# If necessary, uncomment the line below to include explore_source.
#include: "mystuffs.model.lkml"
include: "orders.view.lkml"
include: "NDT_file.view.lkml"
include: "order_items.view.lkml"
include: "inventory_items.view.lkml"

explore: NDT_file {}
