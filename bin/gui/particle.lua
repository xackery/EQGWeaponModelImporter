local eqg = require "luaeqg"
local point = require "gui/particle_points"
local entry = require "gui/particle_entries"

local button = iup.button{title = "View Particle Settings", padding = "10x0"}
local dlg = iup.dialog{iup.hbox{point, entry.dialog; -- Use entry.dialog
    nmargin = "20x10", gap = 10, alignment = "ACENTER"}; title = "Particle Settings", size = "x200",
    k_any = function(self,key) if key == iup.K_ESC then self:hide() end end}

local pcall = pcall

function button:action()
    local sel = selection
    if not sel then return end

    if sel.pts then
        local s, data = pcall(eqg.OpenEntry, sel.pts)
        if s then
            s, data = pcall(pts.Read, sel.pts)
            if s then
                UpdateParticlePoints(data, model)
                ClearPointFields()
                entry.ClearParticleEntries() -- Use entry.ClearParticleEntries
                iup.Popup(dlg)
                return
            end
        end
        error_popup(data)
    else
        UpdateParticlePoints(nil, model)
        ClearPointFields()
        entry.ClearParticleEntries() -- Use entry.ClearParticleEntries
        iup.Popup(dlg)
    end
end

return button