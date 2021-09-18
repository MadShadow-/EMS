 ---GFX-Sets für dem Tag Nacht Zyklus Sommertag changed by Novator12, created by Ghoul
 
 
 
	--normaler Winter
  Display.GfxSetSetSkyBox(3, 0.0, 1.0, "YSkyBox01")
  Display.GfxSetSetRainEffectStatus(3, 0.0, 1.0, 0)
  Display.GfxSetSetSnowStatus(3, 0, 1.0, 1)
  Display.GfxSetSetSnowEffectStatus(3, 0.0, 0.8, 1)
  Display.GfxSetSetFogParams(3, 0.0, 1.0, 1, 108,128,138, 3000,29500)
  Display.GfxSetSetLightParams(3,  0.0, 1.0, 40, -15, -50,  116,164,164, 255,234,202)


    --Nacht mit Schnee
    Display.GfxSetSetSkyBox(16, 0.0, 1.0, "YSkyBox09")
    Display.GfxSetSetRainEffectStatus(16, 0.0, 1.0, 0)
    Display.GfxSetSetSnowStatus(16, 0, 1.0, 1)
    Display.GfxSetSetSnowEffectStatus(16, 0.0, 0.8, 1)
	Display.GfxSetSetFogParams(16, 0.0, 1.0, 1, 52,82,92, 3500,32000)
	Display.GfxSetSetLightParams(16,  0.0, 1.0, 40, -15, -50,  80,90,80,  1,1,1)
    AddPeriodicNightSnow = function(dauer)
		Logic.AddWeatherElement(3, dauer, 1, 16, 5, 15)
	end
 


    	--Sonnenauf-/-untergang mit Schnee
	 Display.GfxSetSetSkyBox(17, 0.0, 1.0, "YSkyBox08")   
	 Display.GfxSetSetRainEffectStatus(17, 0.0, 1.0, 0)   
	 Display.GfxSetSetSnowStatus(17, 0, 1.0, 1)   
	 Display.GfxSetSetSnowEffectStatus(17, 0.0, 0.8, 1)	
	 Display.GfxSetSetFogParams(17, 0.0, 1.0, 1, 215,70,0, 3500,29000)	
	 Display.GfxSetSetLightParams(17,  0.0, 1.0, 40, 165, -50,  80,90,80,  175,70,0)	
     AddPeriodicSunriseSnow = function(dauer)		
		Logic.AddWeatherElement(3, dauer, 1, 17, 5, 15)		
	 end
   


     	 --Sonnenauf-/-untergangs-Übergang mit Schnee
	 Display.GfxSetSetSkyBox(18, 0.0, 1.0, "YSkyBox07")   
	 Display.GfxSetSetRainEffectStatus(18, 0.0, 1.0, 0)   
	 Display.GfxSetSetSnowStatus(18, 0, 1.0, 1)   
	 Display.GfxSetSetSnowEffectStatus(18, 0.0, 0.8, 1)	
	 Display.GfxSetSetFogParams(18, 0.0, 1.0, 1, 165,70,70, 3500,29000)	
	 Display.GfxSetSetLightParams(18,  0.0, 1.0, 40, 115, -50,  80,90,80,  135,70,60)	
     AddPeriodicTransitionSunriseSnow = function(dauer)		
		Logic.AddWeatherElement(3, dauer, 1, 18, 5, 15)		
	 end
  




 



    