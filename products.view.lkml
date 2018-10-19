view: products {
  sql_table_name: demo_db.products ;;

  filter: brand_select {
  suggest_dimension:brand
  }

  dimension: brand_comparitor {
  sql: CASE
      WHEN {% condition brand_select %} ${brand} {% endcondition %}
        THEN ${brand}
      ELSE 'Rest of Population'
    END;;
  }


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: {% if _user_attributes['test'] == 'test' %} ${TABLE}.brand {% else %} null {% endif %} ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
    drill_fields: [item_name,id,brand,order_items.sale_price,inventory_items.cost]
  }


  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }

 dimension: brand_comparitor2{
    sql:
      CASE
        WHEN {% condition brand_select %} ${brand} {% endcondition %} AND ${num.n} = 1
          THEN ${brand}
        ELSE 'Total Of Population'
      END;;
      }
  measure: average_retail_price {
    type: average
    sql: ${retail_price} ;;
    value_format_name: usd
  }
  measure: total_retail_price {
    type: sum
    sql: ${retail_price} ;;
    value_format_name: usd
  }


  ## Percentage of total, independent of filters
  measure: fake_pot {
    type: number
    sql: ${total_retail_price} / (SELECT SUM(retail_price) FROM  demo_db.products) ;;
  }

  dimension: country {
    type: string
    label: "Country"
    sql: ${TABLE}.COUNTRY ;;
  }


}
