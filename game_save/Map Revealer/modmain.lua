local function revealer( inst )

	GLOBAL.RunScript("consolecommands")
	
	inst:DoTaskInTime( 0.001, function() 
	
				minimap = TheSim:FindFirstEntityWithTag("minimap")
				minimap.MiniMap:ShowArea(0,0,0,40000)
	end)

end


AddSimPostInit( revealer )