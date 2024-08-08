-- Disable vanilla resources by removing autoplace controls
local resources_to_disable = {
    "coal",
    "iron-ore",
    "copper-ore",
    "uranium-ore",
    "stone",
    "crude-oil"
}

for _, resource in pairs(resources_to_disable) do
    -- Remove autoplace from resources
    if data.raw.resource[resource] then
        data.raw.resource[resource].autoplace = nil
    end

    -- Remove autoplace control settings
    if data.raw["autoplace-control"][resource] then
        data.raw["autoplace-control"][resource] = nil
    end

    -- Remove from map generation presets
    for _, preset in pairs(data.raw["map-gen-presets"].default) do
        if preset.basic_settings and preset.basic_settings.autoplace_controls then
            preset.basic_settings.autoplace_controls[resource] = nil
        end
    end
end
