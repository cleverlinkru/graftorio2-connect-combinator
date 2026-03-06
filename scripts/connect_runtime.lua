require("__graftorio2-connect-combinator__/scripts/constants")

local ConnectRuntime = {}

function ConnectRuntime.init()
    storage.connect_combinators = {}
end

function ConnectRuntime.add_combinator(event)
    if event.entity.name ~= Constants.combinator_name then
        return
    end

    local entity = event.entity

    local output_entity = assert(
        entity.surface.create_entity {
            name = Constants.combinator_output_name,
            position = entity.position,
            force = entity.force,
            fast_replace = false,
            raise_built = false,
            create_build_effect_smoke = false,
        },
        "Failed to create output entity"
    )

    local control_behavior = assert(
        output_entity.get_or_create_control_behavior(),
        "Failed to get/create control behavior"
    )

    local source_connector_red = entity.get_wire_connector(defines.wire_connector_id.combinator_output_red)
    local source_connector_green = entity.get_wire_connector(defines.wire_connector_id.combinator_output_green)
    local target_connector_red = output_entity.get_wire_connector(defines.wire_connector_id.circuit_red)
    local target_connector_green = output_entity.get_wire_connector(defines.wire_connector_id.circuit_green)
    source_connector_red.connect_to(target_connector_red)
    source_connector_green.connect_to(target_connector_green)

    local selector = {
        input_entity = entity,
        output_entity = output_entity,
        control_behavior = control_behavior,
        key = "",
    }

    storage.connect_combinators[entity.unit_number] = selector
end

function ConnectRuntime.remove_combinator(unit_number)
    local selector = storage.connect_combinators[unit_number]

    if not selector then
        return
    end

    storage.connect_combinators[unit_number] = nil

    if selector and selector.output_entity then
        selector.output_entity.destroy()
    end
end



return ConnectRuntime