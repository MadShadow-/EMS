---GFX-Sets für dem Tag Nacht Zyklus Sommertag changed by Novator12, created by Ghoul
 
 
 
 --normaler Sommer
    Display.GfxSetSetSkyBox(1, 0.0, 1.0, "YSkyBox07")
    Display.GfxSetSetRainEffectStatus(1, 0.0, 1.0, 0)
    Display.GfxSetSetSnowStatus(1, 0, 1.0, 0)
    Display.GfxSetSetSnowEffectStatus(1, 0.0, 0.8, 0)
    Display.GfxSetSetFogParams(1, 0.0, 1.0, 1, 152,172,182, 5000,32000)
    Display.GfxSetSetLightParams(1,  0.0, 1.0, 40, -15, -50,  120,130,110,  205,204,180)


    --Nacht
    Display.GfxSetSetSkyBox(9, 0.0, 1.0, "YSkyBox09")
    Display.GfxSetSetRainEffectStatus(9, 0.0, 1.0, 0)
    Display.GfxSetSetSnowStatus(9, 0, 1.0, 0)
    Display.GfxSetSetSnowEffectStatus(9, 0.0, 0.8, 0)
	Display.GfxSetSetFogParams(9, 0.0, 1.0, 1, 52,82,92, 3500,32000)
	Display.GfxSetSetLightParams(9,  0.0, 1.0, 40, -15, -50,  80,90,80,  1,1,1)
    AddPeriodicNight = function(dauer)
		Logic.AddWeatherElement(1, dauer, 1, 9, 5, 15)
	end
 


    	--Sonnenauf-/-untergang
	 Display.GfxSetSetSkyBox(10, 0.0, 1.0, "YSkyBox08")   
	 Display.GfxSetSetRainEffectStatus(10, 0.0, 1.0, 0)   
	 Display.GfxSetSetSnowStatus(10, 0, 1.0, 0)   
	 Display.GfxSetSetSnowEffectStatus(10, 0.0, 0.8, 0)	
	 Display.GfxSetSetFogParams(10, 0.0, 1.0, 1, 215,70,0, 3500,29000)	
	 Display.GfxSetSetLightParams(10,  0.0, 1.0, 40, 165, -50,  80,90,80,  175,70,0)	
     AddPeriodicSunrise = function(dauer)		
		Logic.AddWeatherElement(1, dauer, 1, 10, 5, 15)		
	 end
   


     	 --Sonnenauf-/-untergangs-Übergang
	 Display.GfxSetSetSkyBox(12, 0.0, 1.0, "YSkyBox07")   
	 Display.GfxSetSetRainEffectStatus(12, 0.0, 1.0, 0)   
	 Display.GfxSetSetSnowStatus(12, 0, 1.0, 0)   
	 Display.GfxSetSetSnowEffectStatus(12, 0.0, 0.8, 0)	
	 Display.GfxSetSetFogParams(12, 0.0, 1.0, 1, 165,70,70, 3500,29000)	
	 Display.GfxSetSetLightParams(12,  0.0, 1.0, 40, 115, -50,  80,90,80,  135,70,60)	
     AddPeriodicTransitionSunrise = function(dauer)		
		Logic.AddWeatherElement(1, dauer, 1, 12, 5, 15)		
	 end
  




 



    