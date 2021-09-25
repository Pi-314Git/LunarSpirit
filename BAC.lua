getgenv().LunarSpiritAB = {
    AntiSlow = false,
    MCE = false
}

local BanArgs = {
	"CHECKER_1",
	"TeleportDetect",
	"OneMoreTime"
}

local MovementArgs = {
	WalkSpeed = 16,
	JumpPower = 50
}

local __namecall = nil
__namecall = hookmetamethod(game, "__namecall", function(self, ...)
	local args = {...}
	local method = getnamecallmethod()

	if tostring(method) == "Kick" then
		return print("no kick")
	end

	if tostring(self) == "MainEvent" and tostring(method) == "FireServer" then
		if table.find(BanArgs, args[1]) then
			return print("no ban")
		end
	end

	if not checkcaller() and getfenv(2).crash then
		hookfunction(getfenv(2).crash, function()
			return print("no crash")
		end)
	end

	return __namecall(self, ...)
end)

local __index = nil
__index = hookmetamethod(game, "__index", function(t, k)
	if not checkcaller() and t:IsA("Humanoid") and (k == "WalkSpeed" or k == "JumpPower") and (LunarSpiritAB.MCE or LunarSpiritAB.AntiSlow) then
		return MovementArgs[k]
	end

	return __index(t, k)
end)

local __newindex
__newindex = hookmetamethod(game, "__newindex", function(t, k, v)
	if not checkcaller() and t:IsA("Humanoid") and (k == "WalkSpeed" or k == "JumpPower") and (LunarSpiritAB.MCE or LunarSpiritAB.AntiSlow) then
		MovementArgs[k] = v
		return
	end
	return __newindex(t, k, v)
end)
