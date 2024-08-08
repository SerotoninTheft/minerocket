local resources = {
    {name = "rocket-silo", result = "rocket-silo", tint = {r = 1, g = 0.5, b = 0.5}},
    {name = "express-belt", result = "express-transport-belt", tint = {r = 0.5, g = 0.5, b = 1}},
    {name = "electric-mining-drill", result = "electric-mining-drill", tint = {r = 0.3, g = 0.7, b = 0.3}},
    {name = "substation", result = "substation", tint = {r = 0.7, g = 0.7, b = 1}},
    {name = "electric-energy-interface", result = "electric-energy-interface", tint = {r = 0.9, g = 0.9, b = 0.9}},
    {name = "rocket-control-unit", result = "rocket-control-unit", tint = {r = 1, g = 0.3, b = 0.3}},
    {name = "rocket-fuel", result = "rocket-fuel", tint = {r = 1, g = 0.6, b = 0}},
    {name = "stack-inserter", result = "stack-inserter", tint = {r = 1, g = 0.9, b = 0.1}},
    {name = "steel-chest", result = "steel-chest", tint = {r = 0.6, g = 0.6, b = 0.6}},
    {name = "express-splitter", result = "express-splitter", tint = {r = 0.5, g = 0.5, b = 1}},
    {name = "low-density-structure", result = "low-density-structure", tint = {r = 1, g = 0.7, b = 0.2}},
    {name = "speed-module-3", result = "speed-module-3", tint = {r = 0.4, g = 0.3, b = 0.1}},
    {name = "productivity-module-3", result = "productivity-module-3", tint = {r = 0.9, g = 0.3, b = 0.2}},
    {name = "beacon", result = "beacon", tint = {r = 5, g = 0.6, b = 0.4}},
}

-- Define autoplace controls and noise layers
for _, resource in pairs(resources) do
    data:extend({
        {
            type = "autoplace-control",
            name = resource.name .. "-resource",
            category = "resource",
            richness = true,
            order = "b-" .. resource.name
        },
        {
            type = "noise-layer",
            name = resource.name .. "-resource"
        }
    })
end

-- Define resources
for _, resource in pairs(resources) do
    local icon = "__base__/graphics/icons/" .. resource.result .. ".png"
    if resource.result == "electric-energy-interface" then
        icon = "__base__/graphics/icons/accumulator.png"
    end

    data:extend({
        {
            type = "resource",
            name = resource.name .. "-resource",
            icon = icon,
            icon_size = 64,
            flags = {"placeable-neutral"},
            order = "a-b-a",
            map_color = resource.tint,
            minable = {
                mining_time = 1,
                result = resource.result
            },
            collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
            selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
            autoplace = {
                control = resource.name .. "-resource",
                sharpness = 0.8,
                richness_multiplier = 1300,
                richness_base = 10,
                size_control_multiplier = 0.06,
                peaks = {
                    {
                        influence = 0.20,
                        starting_area_weight_optimal = 1,
                        starting_area_weight_range = 0.2,
                        starting_area_weight_max_range = 3,
                    },
                    {
                        influence = 0.64,
                        noise_layer = resource.name .. "-resource",
                        noise_octaves_difference = -1.5,
                        noise_persistence = 0.3,
                    },
                    {
                        influence = 0.5,
                        noise_layer = resource.name .. "-resource",
                        noise_octaves_difference = -1.5,
                        noise_persistence = 0.4,
                        water_optimal = 0.1,
                        water_range = 0.05,
                        water_max_range = 0.1,
                    }
                }
            },
            stage_counts = {15000, 7500, 3750, 1875, 938, 469, 234, 117},
            stages = {
                sheet = {
                    filename = "__base__/graphics/entity/stone/stone.png",
                    priority = "extra-high",
                    width = 64,
                    height = 64,
                    frame_count = 8,
                    variation_count = 8,
                    tint = resource.tint -- Apply tint to resource stages
                }
            },
            map_grid = false
        }
    })
end
