require("__graftorio2-connect-combinator__/scripts/constants")
prometheus = require("prometheus/prometheus")
ConnectCombinator = require("scripts/connect_combinator")

local event_filter = {
  {
    filter = "name",
    name = Constants.combinator_name,
  },
};

script.on_init(ConnectCombinator.on_init)
script.on_event(defines.events.on_built_entity, ConnectCombinator.on_entity_created, event_filter)
script.on_event(defines.events.on_robot_built_entity, ConnectCombinator.on_entity_created, event_filter)
script.on_event(defines.events.on_player_mined_entity, ConnectCombinator.on_entity_destroyed, event_filter)
script.on_event(defines.events.on_robot_mined_entity, ConnectCombinator.on_entity_destroyed, event_filter)
script.on_event(defines.events.on_entity_died, ConnectCombinator.on_destroyed, event_filter)
script.on_event(defines.events.on_gui_opened, ConnectCombinator.on_gui_opened)
script.on_event(defines.events.on_gui_closed, ConnectCombinator.on_gui_closed)
script.on_event(defines.events.on_tick, ConnectCombinator.on_tick)

gauge_connect_combinators = prometheus.gauge(
    "factorio_connect_combinators",
    "Connect combinators",
    { "combinator_key", "signal_color", "signal_type", "signal_name" }
)