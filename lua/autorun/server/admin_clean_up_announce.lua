local True_CC_AdminCleanup = cleanup.CC_AdminCleanup

module("cleanup", package.seeall)

function CC_AdminCleanup(pl, command, args)
	True_CC_AdminCleanup(pl, command, args)
	if not IsValid(pl) or not pl:IsAdmin() then return end
	PrintMessage(HUD_PRINTTALK, string.format("%s has cleaned up the map.", pl:Name()))
end

concommand.Add("gmod_admin_cleanup", CC_AdminCleanup, nil, "", {FCVAR_DONTRECORD})
