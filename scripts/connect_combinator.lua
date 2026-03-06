require("__graftorio2-connect-combinator__/scripts/constants")
ConnectRuntime = require("connect_runtime")
ConnectGui = require("connect_gui")

local ConnectCombinator = {}

local selector_filter = {
    filter = "name",
    name = Constants.combinator_name,
}

function ConnectCombinator.on_init()
    ConnectRuntime.init()
end

function ConnectCombinator.on_entity_created(event)
    ConnectRuntime.add_combinator(event)
end

function ConnectCombinator.on_entity_destroyed(event)
    ConnectRuntime.remove_combinator(event.entity.unit_number)
end

function ConnectCombinator.on_destroyed(event)
    ConnectRuntime.remove_combinator(event.unit_number)
end

function ConnectCombinator.on_gui_opened(event)
    local entity = event.entity

    if not entity or not entity.valid or entity.name ~= Constants.combinator_name then
        return
    end

    local player = game.get_player(event.player_index)

    if player then
        ConnectGui.on_gui_added(player, entity)
    end
end

function ConnectCombinator.on_gui_closed(event)
    local element = event.element

    if not element or element.name ~= "connect_gui" then
        return
    end

    local player = game.get_player(event.player_index)

    if player then
        ConnectGui.on_gui_removed(player)
    end
end

function ConnectCombinator.on_tick(event)
    if event.tick % 60 ~= 0 then return end
    gauge_connect_combinators:reset()
    for _, selector in pairs(storage.connect_combinators) do
        local entity = selector.input_entity
        local signals_red = entity.get_signals(defines.wire_connector_id.combinator_input_red) or {}
        local signals_green = entity.get_signals(defines.wire_connector_id.combinator_input_green) or {}

        local function process_signals(signals, color)
            if not signals then return end
            for _, signal in pairs(signals) do
                if signal.signal then
                    gauge_connect_combinators:set(
                        signal.count,
                        { selector.key or "", color or "", signal.signal.type or "", signal.signal.name or "" }
                    )
                end
            end
        end

        process_signals(signals_red, "red")
        process_signals(signals_green, "green")

        helpers.write_file("graftorio2/export.prom", prometheus.collect(), false)
    end
end

ConnectGui.bind_all_events()

return ConnectCombinator