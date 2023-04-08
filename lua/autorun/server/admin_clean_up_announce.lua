local True_CC_AdminCleanup = cleanup.CC_AdminCleanup

module("cleanup", package.seeall)

function CC_AdminCleanup(pl, command, args)
	True_CC_AdminCleanup(pl, command, args)
	if not IsValid(pl) or not pl:IsAdmin() then return end
	PrintMessage(HUD_PRINTTALK, string.format("%s has cleaned up the map.", pl:Name()))
end

concommand.Add("gmod_admin_cleanup", CC_AdminCleanup, nil, "", {FCVAR_DONTRECORD})

local function inject_to_vj_cleanup()
	if not VJBASE_VERSION then return nil end
	local CommandTable = concommand.GetTable()
	local True_vj_cleanup = CommandTable.vj_cleanup
	if not True_vj_cleanup then return false end
	local function New_vj_cleanup(ply, cmd, args)
		True_vj_cleanup(ply, cmd, args)
		if IsValid(ply) and not ply:IsAdmin() then return end
		PrintMessage(HUD_PRINTTALK, string.format("%s has cleaned up the map (VJ Base).", ply:Name()))
	end
	CommandTable.vj_cleanup = New_vj_cleanup
	return true
end

if not inject_to_vj_cleanup() then timer.Simple(0, inject_to_vj_cleanup) end
