local COMBINATOR_SPRITE = "__graftorio2-connect-combinator__/graphics/entity/connect-combinator/connect-combinator.png"
local COMBINATOR_HR_SPRITE = "__graftorio2-connect-combinator__/graphics/entity/connect-combinator/hr-connect-combinator.png"


local connect_combinator_entity = table.deepcopy(data.raw["arithmetic-combinator"]["arithmetic-combinator"])
connect_combinator_entity.name = Constants.combinator_name
connect_combinator_entity.localised_name = "Connect combinator"
connect_combinator_entity.localised_description = "Connect combinator"
connect_combinator_entity.minable.result = Constants.combinator_name
connect_combinator_entity.icon = "__graftorio2-connect-combinator__/graphics/icons/connect-combinator-icon.png"

local function get_new_layers(x, y)
    return {
        layers = {
            {
                filename = COMBINATOR_HR_SPRITE,
                width = 144,
                height = 102,
                x = x,
                y = y,
                frame_count = 1,
                shift = util.by_pixel(0, 2),
                scale = 0.5,
                priority = "extra-high"
            }
        }
    }
end
connect_combinator_entity.sprites = {
    north = get_new_layers(0, 0),
    east = get_new_layers(144, 0),
    south = get_new_layers(288, 0),
    west = get_new_layers(432, 0)
}
local empty_sprite = {
    filename = "__core__/graphics/empty.png",
    priority = "extra-high",
    width = 1,
    height = 1,
    frame_count = 1,
    shift = {0, 0}
}
local symbol_fields = {
    "plus_symbol_sprites",
    "minus_symbol_sprites",
    "multiply_symbol_sprites",
    "divide_symbol_sprites",
    "modulo_symbol_sprites",
    "power_symbol_sprites",
    "left_shift_symbol_sprites",
    "right_shift_symbol_sprites",
    "and_symbol_sprites",
    "or_symbol_sprites",
    "xor_symbol_sprites"
}
for _, field in ipairs(symbol_fields) do
    connect_combinator_entity[field] = {
        north = { layers = { empty_sprite } },
        east  = { layers = { empty_sprite } },
        south = { layers = { empty_sprite } },
        west  = { layers = { empty_sprite } }
    }
end

connect_combinator_entity.energy_source = {
    type = "void"
}


local connect_combinator_out_entity = table.deepcopy(data.raw["constant-combinator"]["constant-combinator"])
connect_combinator_out_entity.name = Constants.combinator_output_name
connect_combinator_out_entity.icon = nil
connect_combinator_out_entity.icon_size = nil
connect_combinator_out_entity.icon_mipmaps = nil
connect_combinator_out_entity.next_upgrade = nil
connect_combinator_out_entity.minable = nil
connect_combinator_out_entity.selection_box = nil
connect_combinator_out_entity.collision_box = nil
connect_combinator_out_entity.collision_mask = nil
connect_combinator_out_entity.item_slot_count = 500
connect_combinator_out_entity.circuit_wire_max_distance = 3
connect_combinator_out_entity.flags = { "not-blueprintable", "not-deconstructable", "placeable-off-grid" }

local origin = { 0, 0 }

local origin_wire = {
    red = origin,
    green = origin,
}

local connection_point = {
    wire = origin_wire,
    shadow = origin_wire,
}

connect_combinator_out_entity.circuit_wire_connection_points = {
    connection_point,
    connection_point,
    connection_point,
    connection_point,
}

local invisible_sprite = {
    filename = "__core__/graphics/empty.png",
    width = 1,
    height = 1,
}

connect_combinator_out_entity.sprites = invisible_sprite
connect_combinator_out_entity.activity_led_sprites = invisible_sprite

connect_combinator_out_entity.activity_led_light_offsets = {
    origin,
    origin,
    origin,
    origin,
}

connect_combinator_out_entity.draw_circuit_wires = false


data:extend{
    connect_combinator_entity,
    connect_combinator_out_entity
}