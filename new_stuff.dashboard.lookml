- dashboard: mystuff__public
  title: MyStuff - public
  layout: newspaper
  embed_style:
    background_color: "#da4ab6"
    show_title: false
    title_color: "#228ab1"
    show_filters_bar: false
    tile_text_color: "#0e2027"
    text_tile_text_color: ''
  elements:
  - name: add_a_unique_name_1525947452
    title: Untitled Visualization
    model: mystuffs
    explore: users
    type: looker_donut_multiples
    fields: [users.count, users.state, users.age_tier]
    pivots: [users.age_tier]
    fill_fields: [users.age_tier]
    sorts: [users.count desc 1, users.age_tier 0]
    limit: 3
    column_limit: 50
    row_total: right
    query_timezone: America/Los_Angeles
    show_value_labels: true
    font_size: 12
    map: auto
    map_projection: ''
    show_view_names: true
    quantize_colors: false
    stacking: ''
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    interpolation: linear
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
  # - title: Total_Sale_MyStuff_last_3_months
  #   name: Total_Sale_MyStuff_last_3_months
  #   model: mystuffs
  #   explore: order_items
  #   type: single_value
  #   fields:
  #   - order_items.Total_sales_price
  #   filters:
  #     order_items.returned_item: 'No'
  #     orders.created_month: 3 months
  #   sorts:
  #   - order_items.Total_sales_price desc
  #   limit: 500
  #   query_timezone: America/Los_Angeles
  #   custom_color_enabled: false
  #   custom_color: forestgreen
  #   show_single_value_title: true
  #   show_comparison: false
  #   comparison_type: value
  #   comparison_reverse_colors: false
  #   show_comparison_label: true
  #   row: 0
  #   col: 9
  #   width: 9
  #   height: 3
  - name: ----------
    type: text
    title_text: ""
    subtitle_text: ""
    body_text: <img src="https://wwwstatic-a.lookercdn.com/homepage/new_home/looker.svg" width="100%"/>
    row: 3
    col: 9
    width: 9
    height: 6
  # - name: Sales_distribution_US_MyStuff_last_3_month
  #   title: Sales_distribution_US_MyStuff_last_3_month
  #   model: mystuffs
  #   explore: orders
  #   type: looker_geo_choropleth
  #   fields:
  #   - orders.percentage_of_total_orders
  #   - users.state
  #   filters:
  #     orders.created_month: 3 months
  #   sorts:
  #   - orders.percentage_of_total_orders desc
  #   limit: 500
  #   query_timezone: America/Los_Angeles
  #   map: usa
  #   map_projection: ''
  #   show_view_names: true
  #   quantize_colors: false
  #   stacking: ''
  #   show_value_labels: false
  #   label_density: 25
  #   legend_position: center
  #   x_axis_gridlines: false
  #   y_axis_gridlines: true
  #   limit_displayed_rows: false
  #   y_axis_combined: true
  #   show_y_axis_labels: true
  #   show_y_axis_ticks: true
  #   y_axis_tick_density: default
  #   y_axis_tick_density_custom: 5
  #   show_x_axis_label: true
  #   show_x_axis_ticks: true
  #   x_axis_scale: auto
  #   y_axis_scale_mode: linear
  #   ordering: none
  #   show_null_labels: false
  #   show_totals_labels: false
  #   show_silhouette: false
  #   totals_color: "#808080"
  #   show_null_points: true
  #   point_style: circle
  #   font_size: '12'
  #   series_types: {}
  #   row: 3
  #   col: 9
  #   width: 9
  #   height: 6
  - name: Customers_by age_tier_in_Top3_states_MyStuff
    title: Customers_by age_tier_in_Top3_states_MyStuff
    model: mystuffs
    explore: users
    type: looker_donut_multiples
    fields:
    - users.count
    - users.state
    - users.age_tier
    pivots:
    - users.age_tier
    fill_fields:
    - users.age_tier
    sorts:
    - users.count desc 1
    - users.age_tier 0
    limit: 3
    column_limit: 50
    row_total: right
    query_timezone: America/Los_Angeles
    show_value_labels: true
    font_size: 12
    map: auto
    map_projection: ''
    show_view_names: true
    quantize_colors: false
    stacking: ''
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    interpolation: linear
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    row: 18
    col: 0
    width: 9
    height: 6
  - name: New_Customers_by age_tier_in_Top3_states_MyStuff_last_3_month
    title: New_Customers_by age_tier_in_Top3_states_MyStuff_last_3_month
    model: mystuffs
    explore: users
    type: looker_donut_multiples
    fields:
    - users.count
    - users.state
    - users.age_tier
    pivots:
    - users.age_tier
    fill_fields:
    - users.age_tier
    filters:
      users.created_month: 3 months
    sorts:
    - users.count desc 1
    - users.age_tier 0
    limit: 3
    column_limit: 50
    row_total: right
    query_timezone: America/Los_Angeles
    show_value_labels: true
    font_size: 13
    map: auto
    map_projection: ''
    show_view_names: true
    quantize_colors: false
    stacking: ''
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    interpolation: linear
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    row: 18
    col: 9
    width: 9
    height: 6
  - name: New Customers_MyStuff_last_3_month
    title: New Customers_MyStuff_last_3_month
    model: mystuffs
    explore: users
    type: single_value
    fields:
    - users.count
    filters:
      users.created_month: 3 months
    sorts:
    - users.count desc
    limit: 500
    column_limit: 50
    row_total: right
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    map: usa
    map_projection: ''
    quantize_colors: false
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    font_size: '13'
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    interpolation: linear
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    series_types: {}
    row: 9
    col: 9
    width: 9
    height: 3
  - name: New Customers_by_State_MyStuff_last_3_month
    title: New Customers_by_State_MyStuff_last_3_month
    model: mystuffs
    explore: users
    type: looker_geo_choropleth
    fields:
    - users.count
    - users.state
    filters:
      users.created_month: 3 months
    sorts:
    - users.count desc
    limit: 500
    column_limit: 50
    row_total: right
    query_timezone: America/Los_Angeles
    map: usa
    map_projection: ''
    show_view_names: true
    quantize_colors: false
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    font_size: '13'
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    interpolation: linear
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    series_types: {}
    row: 12
    col: 9
    width: 9
    height: 6
  - name: Total_#_of_customers_MyStuff
    title: Total_#_of_customers_MyStuff
    model: mystuffs
    explore: users
    type: single_value
    fields:
    - users.count
    sorts:
    - users.count desc
    limit: 500
    column_limit: 50
    row_total: right
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    map: usa
    map_projection: ''
    show_view_names: true
    quantize_colors: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    font_size: '13'
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    interpolation: linear
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    series_types: {}
    row: 9
    col: 0
    width: 9
    height: 3
  # - name: Total_Sale_MyStuff
  #   title: Total_Sale_MyStuff
  #   model: mystuffs
  #   explore: order_items
  #   type: single_value
  #   fields:
  #   - order_items.Total_sales_price
  #   filters:
  #     order_items.returned_item: 'No'
  #   sorts:
  #   - order_items.Total_sales_price desc
  #   limit: 500
  #   column_limit: 50
  #   query_timezone: America/Los_Angeles
  #   custom_color_enabled: false
  #   custom_color: forestgreen
  #   show_single_value_title: true
  #   show_comparison: false
  #   comparison_type: value
  #   comparison_reverse_colors: false
  #   show_comparison_label: true
  #   row: 0
  #   col: 0
  #   width: 9
  #   height: 3
  - name: Customers_by_State_MyStuff
    title: Customers_by_State_MyStuff
    model: mystuffs
    explore: users
    type: looker_geo_choropleth
    fields:
    - users.count
    - users.state
    sorts:
    - users.count desc
    limit: 500
    column_limit: 50
    row_total: right
    query_timezone: America/Los_Angeles
    map: usa
    map_projection: ''
    show_view_names: true
    quantize_colors: false
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    font_size: '13'
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    interpolation: linear
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    series_types: {}
    row: 12
    col: 0
    width: 9
    height: 6
  - name: Sales_distribution_US_MyStuff
    title: Sales_distribution_US_MyStuff
    model: mystuffs
    explore: orders
    type: looker_geo_choropleth
    fields:
    - orders.percentage_of_total_orders
    - users.state
    sorts:
    - orders.percentage_of_total_orders desc
    limit: 500
    query_timezone: America/Los_Angeles
    map: usa
    map_projection: ''
    show_view_names: true
    quantize_colors: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    point_style: circle
    font_size: '12'
    series_types: {}
    row: 3
    col: 0
    width: 5
    height: 6
  - name: add_a_unique_name_1537175007
    title: Untitled Visualization
    model: mystuffs
    explore: orders
    type: looker_column
    fields: [orders.created_month, orders.count, users.age_tier]
    filters:
      orders.created_month: 3 months
    sorts: [orders.created_month desc]
    limit: 500
    query_timezone: Europe/Dublin
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    y_axes: [{label: '', orientation: right, series: [{id: orders.count, name: Orders
              Count, axisId: orders.count}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
