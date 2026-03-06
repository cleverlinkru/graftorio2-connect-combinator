local connect_combinator_recipe = table.deepcopy(data.raw["recipe"]["arithmetic-combinator"])
connect_combinator_recipe.enabled = false
connect_combinator_recipe.name = Constants.combinator_name
connect_combinator_recipe.results = {
    { type="item", name=Constants.combinator_name, amount=1 },
};
data:extend{connect_combinator_recipe}