local cayoIpl = {"xn_h4_islandx_terrain_01_slod", "xn_h4_islandx_terrain_02_slod", "xn_h4_islandx_terrain_04_slod", "xn_h4_islandx_terrain_05_slod", "xn_h4_islandx_terrain_06_slod"}
local LosSantosIpl = {"xn_ap1_lod", "xn_apa_ch2_lod", "xn_apa_ch2_lod2", "xn_apa_ch2_lod3", "xn_apa_ch2_lod4", "xn_apa_ss1_lod", "xn_bh1_lod", "xn_bkr_id1_lod", "xn_ch1_lod", "xn_ch2_lod",
"xn_ch2_lod2", "xn_ch2_lod3", "xn_ch2_lod4", "xn_ch3_lod", "xn_cs1_lod", "xn_cs1_lod2", "xn_cs1_lod3", "xn_cs2_lod", "xn_cs2_lod2", "xn_cs3_lod", "xn_cs4_lod", "xn_cs5_lod",
"xn_cs6_lod", "xn_dt1_lod", "xn_hei_ap1_lod", "xn_hei_bh1_lod", "xn_hei_ch1_lod", "xn_hei_ch2_lod", "xn_hei_ch2_lod2", "xn_hei_ch2_lod3", "xn_hei_ch2_lod4", "xn_hei_ch3_lod",
"xn_hei_cs1_lod", "xn_hei_cs1_lod2", "xn_hei_cs1_lod3", "xn_hei_cs2_lod", "xn_hei_cs2_lod2", "xn_hei_cs3_lod", "xn_hei_cs4_lod", "xn_hei_cs6_lod", "xn_hei_dt1_lod", "xn_hei_hw1_lod",
"xn_hei_id1_lod", "xn_hei_id2_lod", "xn_hei_kt1_lod", "xn_hei_po1_lod", "xn_hei_sc1_lod", "xn_hei_sm_lod", "xn_hei_ss1_lod", "xn_hei_vb_lod", "xn_hw1_lod", "xn_id1_lod", "xn_id2_lod",
"xn_kt1_lod", "xn_lr_cs4_lod", "xn_lr_cs6_lod", "xn_lr_id1_lod", "xn_lr_sc1_lod", "xn_po1_lod", "xn_sc1_lod", "xn_sm_lod", "xn_sp1_lod", "xn_ss1_lod", "xn_vb_lod"}

local islandVec = vector3(4840.571, -5174.425, 2.0)
CreateThread(function()
    local isLoaded = false
    while true do
        local pCoords = GetEntityCoords(PlayerPedId())        
        local distance1 = #(pCoords - islandVec)
        if distance1 < 2000.0 then
            if not isLoaded then
                isLoaded = true
                Citizen.InvokeNative("0x9A9D1BA639675CF1", "HeistIsland", true)  -- load the map and removes the city

                Citizen.InvokeNative("0x5E1460624D194A38", true) -- load the minimap/pause map and removes the city minimap/pause map
                Citizen.InvokeNative("0xF74B1FFA4A15FBEA", true)
                Citizen.InvokeNative("0x53797676AD34A9AA", false)
                SetAudioFlag('PlayerOnDLCHeist4Island', 1)

                for i, data in ipairs(LosSantosIpl) do
                    RequestIpl(data)
                end
            
                for i, data in ipairs(cayoIpl) do
                    RemoveIpl(data)
                end
            end
        else
            if isLoaded then
                isLoaded = false
                Citizen.InvokeNative("0x9A9D1BA639675CF1", "HeistIsland", false)

                Citizen.InvokeNative("0x5E1460624D194A38", false)
                Citizen.InvokeNative("0xF74B1FFA4A15FBEA", false)
                Citizen.InvokeNative("0x53797676AD34A9AA", true)
                SetAudioFlag('PlayerOnDLCHeist4Island', 0)

                for i, data in ipairs(cayoIpl) do
                    RequestIpl(data)
                end

                for i, data in ipairs(LosSantosIpl) do
                    RemoveIpl(data)
                end
            end
        end
        Citizen.Wait(5000)
    end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		Citizen.InvokeNative(0xC54A08C85AE4D410, 0.5)
	end
end)
