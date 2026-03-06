local connect_combinator_item = table.deepcopy(data.raw["item"]["arithmetic-combinator"])
connect_combinator_item.name = Constants.combinator_name
connect_combinator_item.place_result = Constants.combinator_name
connect_combinator_item.icon = "__graftorio2-connect-combinator__/graphics/icons/connect-combinator-icon.png"
data:extend{connect_combinator_item}