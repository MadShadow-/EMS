-- TODO:
-- add rule Mirror
-- fix EMS:
-- GUIUpdate functions should use GetRepresentative() instead of GetValue()
-- MapRuleToGUIWidget should only contain tables
-- AllowNegativeNumbers should not count the - sign as digit
-- stdbool should return bool instead of number
-- self:SetValue should not sheck if > 0 by defaul
--[[assert(XGUIEng.GetWidgetID("EMSPagesRMG")==0, "EMSPagesRMG already exists")
assert(XGUIEng.GetWidgetID("RMG1")==0, "RMG1 already exists")
assert(XGUIEng.GetWidgetID("RMG1Frame1")==0, "RMG1Frame1 already exists")
assert(XGUIEng.GetWidgetID("RMG1F1Text")==0, "RMG1F1Text already exists")
assert(XGUIEng.GetWidgetID("RMG1F1Value")==0, "RMG1F1Value already exists")
assert(XGUIEng.GetWidgetID("RMG1F1Del")==0, "RMG1F1Del already exists")
assert(XGUIEng.GetWidgetID("RMG1Frame2")==0, "RMG1Frame2 already exists")
assert(XGUIEng.GetWidgetID("RMG1F2Text")==0, "RMG1F2Text already exists")
assert(XGUIEng.GetWidgetID("RMG1F2Value")==0, "RMG1F2Value already exists")
assert(XGUIEng.GetWidgetID("RMG1Frame3")==0, "RMG1Frame3 already exists")
assert(XGUIEng.GetWidgetID("RMG1F3Text")==0, "RMG1F3Text already exists")
assert(XGUIEng.GetWidgetID("RMG1F3Value")==0, "RMG1F3Value already exists")
assert(XGUIEng.GetWidgetID("RMG1Frame4")==0, "RMG1Frame4 already exists")
assert(XGUIEng.GetWidgetID("RMG1F4Text")==0, "RMG1F4Text already exists")
assert(XGUIEng.GetWidgetID("RMG1F4Value")==0, "RMG1F4Value already exists")
assert(XGUIEng.GetWidgetID("RMG1Frame5")==0, "RMG1Frame5 already exists")
assert(XGUIEng.GetWidgetID("RMG1F5Text")==0, "RMG1F5Text already exists")
assert(XGUIEng.GetWidgetID("RMG1F5Value")==0, "RMG1F5Value already exists")
assert(XGUIEng.GetWidgetID("RMG1Frame6")==0, "RMG1Frame6 already exists")
assert(XGUIEng.GetWidgetID("RMG1F6Text")==0, "RMG1F6Text already exists")
assert(XGUIEng.GetWidgetID("RMG1F6Value")==0, "RMG1F6Value already exists")
assert(XGUIEng.GetWidgetID("RMG2")==0, "RMG2 already exists")
assert(XGUIEng.GetWidgetID("RMG2Frame1")==0, "RMG2Frame1 already exists")
assert(XGUIEng.GetWidgetID("RMG2F1Text")==0, "RMG2F1Text already exists")
assert(XGUIEng.GetWidgetID("RMG2F1Value")==0, "RMG2F1Value already exists")
assert(XGUIEng.GetWidgetID("RMG2Frame2")==0, "RMG2Frame2 already exists")
assert(XGUIEng.GetWidgetID("RMG2F2Text")==0, "RMG2F2Text already exists")
assert(XGUIEng.GetWidgetID("RMG2F2Value")==0, "RMG2F2Value already exists")
assert(XGUIEng.GetWidgetID("RMG2Frame3")==0, "RMG2Frame3 already exists")
assert(XGUIEng.GetWidgetID("RMG2F3Text")==0, "RMG2F3Text already exists")
assert(XGUIEng.GetWidgetID("RMG2F3Value")==0, "RMG2F3Value already exists")
assert(XGUIEng.GetWidgetID("RMG2Frame4")==0, "RMG2Frame4 already exists")
assert(XGUIEng.GetWidgetID("RMG2F4Text")==0, "RMG2F4Text already exists")
assert(XGUIEng.GetWidgetID("RMG2F4Value")==0, "RMG2F4Value already exists")
assert(XGUIEng.GetWidgetID("RMG3")==0, "RMG3 already exists")
assert(XGUIEng.GetWidgetID("RMG3Frame1")==0, "RMG3Frame1 already exists")
assert(XGUIEng.GetWidgetID("RMG3F1Text")==0, "RMG3F1Text already exists")
assert(XGUIEng.GetWidgetID("RMG3F1Value")==0, "RMG3F1Value already exists")
assert(XGUIEng.GetWidgetID("RMG3Frame2")==0, "RMG3Frame2 already exists")
assert(XGUIEng.GetWidgetID("RMG3F2Text")==0, "RMG3F2Text already exists")
assert(XGUIEng.GetWidgetID("RMG3F2Value")==0, "RMG3F2Value already exists")
assert(XGUIEng.GetWidgetID("RMG3Frame3")==0, "RMG3Frame3 already exists")
assert(XGUIEng.GetWidgetID("RMG3F3Text")==0, "RMG3F3Text already exists")
assert(XGUIEng.GetWidgetID("RMG3F3Value")==0, "RMG3F3Value already exists")
assert(XGUIEng.GetWidgetID("RMG3Frame4")==0, "RMG3Frame4 already exists")
assert(XGUIEng.GetWidgetID("RMG3F4Text")==0, "RMG3F4Text already exists")
assert(XGUIEng.GetWidgetID("RMG3F4Value")==0, "RMG3F4Value already exists")
assert(XGUIEng.GetWidgetID("RMG3Frame5")==0, "RMG3Frame5 already exists")
assert(XGUIEng.GetWidgetID("RMG3F5Text")==0, "RMG3F5Text already exists")
assert(XGUIEng.GetWidgetID("RMG3F5Value")==0, "RMG3F5Value already exists")
assert(XGUIEng.GetWidgetID("RMG3Frame6")==0, "RMG3Frame6 already exists")
assert(XGUIEng.GetWidgetID("RMG3F6Text")==0, "RMG3F6Text already exists")
assert(XGUIEng.GetWidgetID("RMG3F6Value")==0, "RMG3F6Value already exists")
assert(XGUIEng.GetWidgetID("RMG3Frame7")==0, "RMG3Frame7 already exists")
assert(XGUIEng.GetWidgetID("RMG3F7Text")==0, "RMG3F7Text already exists")
assert(XGUIEng.GetWidgetID("RMG3F7Value1")==0, "RMG3F7Value1 already exists")
assert(XGUIEng.GetWidgetID("RMG3F7Value2")==0, "RMG3F7Value2 already exists")
assert(XGUIEng.GetWidgetID("RMG3Frame8")==0, "RMG3Frame8 already exists")
assert(XGUIEng.GetWidgetID("RMG3F8Text")==0, "RMG3F8Text already exists")
assert(XGUIEng.GetWidgetID("RMG3F8Value1")==0, "RMG3F8Value1 already exists")
assert(XGUIEng.GetWidgetID("RMG3F8Value2")==0, "RMG3F8Value2 already exists")
assert(XGUIEng.GetWidgetID("RMG3Frame9")==0, "RMG3Frame9 already exists")
assert(XGUIEng.GetWidgetID("RMG3F9Text")==0, "RMG3F9Text already exists")
assert(XGUIEng.GetWidgetID("RMG3F9Value1")==0, "RMG3F9Value1 already exists")
assert(XGUIEng.GetWidgetID("RMG3F9Value2")==0, "RMG3F9Value2 already exists")
assert(XGUIEng.GetWidgetID("RMG3Frame12")==0, "RMG3Frame12 already exists")
assert(XGUIEng.GetWidgetID("RMG3F12Text")==0, "RMG3F12Text already exists")
assert(XGUIEng.GetWidgetID("RMG3F12Decrease")==0, "RMG3F12Decrease already exists")
assert(XGUIEng.GetWidgetID("RMG3F12Increase")==0, "RMG3F12Increase already exists")
assert(XGUIEng.GetWidgetID("RMG3Frame13")==0, "RMG3Frame13 already exists")
assert(XGUIEng.GetWidgetID("RMG3F13Text")==0, "RMG3F13Text already exists")
assert(XGUIEng.GetWidgetID("RMG3F13Decrease")==0, "RMG3F13Decrease already exists")
assert(XGUIEng.GetWidgetID("RMG3F13Increase")==0, "RMG3F13Increase already exists")
assert(XGUIEng.GetWidgetID("RMG4")==0, "RMG4 already exists")
assert(XGUIEng.GetWidgetID("RMG4Frame3")==0, "RMG4Frame3 already exists")
assert(XGUIEng.GetWidgetID("RMG4F3Text")==0, "RMG4F3Text already exists")
assert(XGUIEng.GetWidgetID("RMG4F3Value1")==0, "RMG4F3Value1 already exists")
assert(XGUIEng.GetWidgetID("RMG4Frame2")==0, "RMG4Frame2 already exists")
assert(XGUIEng.GetWidgetID("RMG4F2Text")==0, "RMG4F2Text already exists")
assert(XGUIEng.GetWidgetID("RMG4F2Value1")==0, "RMG4F2Value1 already exists")
assert(XGUIEng.GetWidgetID("RMG4Frame1")==0, "RMG4Frame1 already exists")
assert(XGUIEng.GetWidgetID("RMG4F1Text")==0, "RMG4F1Text already exists")
assert(XGUIEng.GetWidgetID("RMG4F1Value1")==0, "RMG4F1Value1 already exists")
assert(XGUIEng.GetWidgetID("RMG3Frame10")==0, "RMG3Frame10 already exists")
assert(XGUIEng.GetWidgetID("RMG3F10Text")==0, "RMG3F10Text already exists")
assert(XGUIEng.GetWidgetID("RMG3F10Value")==0, "RMG3F10Value already exists")
assert(XGUIEng.GetWidgetID("RMG3Frame11")==0, "RMG3Frame11 already exists")
assert(XGUIEng.GetWidgetID("RMG3F11Text")==0, "RMG3F11Text already exists")
assert(XGUIEng.GetWidgetID("RMG3F11Decrease")==0, "RMG3F11Decrease already exists")
assert(XGUIEng.GetWidgetID("RMG3F11Increase")==0, "RMG3F11Increase already exists")
assert(XGUIEng.GetWidgetID("RMG5")==0, "RMG5 already exists")
assert(XGUIEng.GetWidgetID("RMG5Frame1")==0, "RMG5Frame1 already exists")
assert(XGUIEng.GetWidgetID("RMG5F1Text")==0, "RMG5F1Text already exists")
assert(XGUIEng.GetWidgetID("RMG5F1Value1")==0, "RMG5F1Value1 already exists")
assert(XGUIEng.GetWidgetID("RMG5F1Value2")==0, "RMG5F1Value2 already exists")
assert(XGUIEng.GetWidgetID("RMG5Frame2")==0, "RMG5Frame2 already exists")
assert(XGUIEng.GetWidgetID("RMG5F2Text")==0, "RMG5F2Text already exists")
assert(XGUIEng.GetWidgetID("RMG5F2Value1")==0, "RMG5F2Value1 already exists")
assert(XGUIEng.GetWidgetID("RMG5F2Value2")==0, "RMG5F2Value2 already exists")
assert(XGUIEng.GetWidgetID("RMG5Frame3")==0, "RMG5Frame3 already exists")
assert(XGUIEng.GetWidgetID("RMG5F3Text")==0, "RMG5F3Text already exists")
assert(XGUIEng.GetWidgetID("RMG5F3Value1")==0, "RMG5F3Value1 already exists")
assert(XGUIEng.GetWidgetID("RMG5F3Value2")==0, "RMG5F3Value2 already exists")
assert(XGUIEng.GetWidgetID("RMG5Frame4")==0, "RMG5Frame4 already exists")
assert(XGUIEng.GetWidgetID("RMG5F4Text")==0, "RMG5F4Text already exists")
assert(XGUIEng.GetWidgetID("RMG5F4Value1")==0, "RMG5F4Value1 already exists")
assert(XGUIEng.GetWidgetID("RMG5F4Value2")==0, "RMG5F4Value2 already exists")
assert(XGUIEng.GetWidgetID("RMG5Frame5")==0, "RMG5Frame5 already exists")
assert(XGUIEng.GetWidgetID("RMG5F5Text")==0, "RMG5F5Text already exists")
assert(XGUIEng.GetWidgetID("RMG5F5Value1")==0, "RMG5F5Value1 already exists")
assert(XGUIEng.GetWidgetID("RMG5F5Value2")==0, "RMG5F5Value2 already exists")
assert(XGUIEng.GetWidgetID("RMG5Frame6")==0, "RMG5Frame6 already exists")
assert(XGUIEng.GetWidgetID("RMG5F6Text")==0, "RMG5F6Text already exists")
assert(XGUIEng.GetWidgetID("RMG5F6Value1")==0, "RMG5F6Value1 already exists")
assert(XGUIEng.GetWidgetID("RMG5F6Value2")==0, "RMG5F6Value2 already exists")
assert(XGUIEng.GetWidgetID("RMG5Frame7")==0, "RMG5Frame7 already exists")
assert(XGUIEng.GetWidgetID("RMG5F7Text")==0, "RMG5F7Text already exists")
assert(XGUIEng.GetWidgetID("RMG5F7Value1")==0, "RMG5F7Value1 already exists")
assert(XGUIEng.GetWidgetID("RMG5F7Value2")==0, "RMG5F7Value2 already exists")
assert(XGUIEng.GetWidgetID("RMG5Frame8")==0, "RMG5Frame8 already exists")
assert(XGUIEng.GetWidgetID("RMG5F8Text")==0, "RMG5F8Text already exists")
assert(XGUIEng.GetWidgetID("RMG5F8Value1")==0, "RMG5F8Value1 already exists")
assert(XGUIEng.GetWidgetID("RMG5F8Value2")==0, "RMG5F8Value2 already exists")
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("EMSPagesUnits", "EMSPagesRMG", nil)
CppLogic.UI.WidgetSetPositionAndSize("EMSPagesRMG", 0, 0, 824, 500)
XGUIEng.ShowWidget("EMSPagesRMG", 0)
CppLogic.UI.WidgetSetBaseData("EMSPagesRMG", 0, false, false)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("EMSPagesRMG", "RMG1", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG1", 10, 10, 120, 450)
XGUIEng.ShowWidget("RMG1", 1)
CppLogic.UI.WidgetSetBaseData("RMG1", 0, false, false)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG1", "RMG1Frame1", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG1Frame1", 0, 0, 112, 40)
XGUIEng.ShowWidget("RMG1Frame1", 1)
CppLogic.UI.WidgetSetBaseData("RMG1Frame1", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG1Frame1", "RMG1F1Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG1F1Text", 0, 0, 112, 20)
XGUIEng.ShowWidget("RMG1F1Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG1F1Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F1Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG1F1Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG1F1Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG1F1Text", 0)
XGUIEng.SetText("RMG1F1Text", "@center Seed", 1)
XGUIEng.SetTextColor("RMG1F1Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG1F1Text", true)
XGUIEng.SetLinesToPrint("RMG1F1Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG1F1Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG1Frame1", "RMG1F1Value", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG1F1Value", 28, 22, 56, 16)
XGUIEng.ShowWidget("RMG1F1Value", 1)
CppLogic.UI.WidgetSetBaseData("RMG1F1Value", 0, false, false)
XGUIEng.DisableButton("RMG1F1Value", 0)
XGUIEng.HighLightButton("RMG1F1Value", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG1F1Value", function() EMS.GL.ActivateInput("RMG_Seed") end)
CppLogic.UI.ButtonSetShortcutString("RMG1F1Value", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F1Value", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F1Value", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F1Value", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F1Value", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F1Value", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F1Value", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F1Value", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F1Value", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F1Value", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F1Value", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F1Value", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F1Value", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F1Value", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F1Value", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F1Value", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG1F1Value", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG1F1Value", function() EMS.GL.UpdateTooltip("RMG_Seed") end)
CppLogic.UI.WidgetSetTooltipString("RMG1F1Value", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG1F1Value", true)
CppLogic.UI.WidgetSetFont("RMG1F1Value", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG1F1Value", -5)
XGUIEng.SetText("RMG1F1Value", "@center 123456789", 1)
XGUIEng.SetTextColor("RMG1F1Value", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateGFXButtonWidgetChild("RMG1Frame1", "RMG1F1Del", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG1F1Del", 87, 22, 16, 16)
XGUIEng.ShowWidget("RMG1F1Del", 1)
CppLogic.UI.WidgetSetBaseData("RMG1F1Del", 0, false, false)
XGUIEng.DisableButton("RMG1F1Del", 0)
XGUIEng.HighLightButton("RMG1F1Del", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG1F1Del", function() RandomMapGenerator.SetRandomSeed() end)
CppLogic.UI.ButtonSetShortcutString("RMG1F1Del", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F1Del", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F1Del", 0, "graphics\\textures\\gui\\trade_cancel.png")
XGUIEng.SetMaterialColor("RMG1F1Del", 0, 200, 200, 200, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F1Del", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F1Del", 1, "graphics\\textures\\gui\\trade_cancel.png")
XGUIEng.SetMaterialColor("RMG1F1Del", 1, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F1Del", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F1Del", 2, "graphics\\textures\\gui\\trade_cancel.png")
XGUIEng.SetMaterialColor("RMG1F1Del", 2, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F1Del", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG1F1Del", 3, 155, 155, 155, 100)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F1Del", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG1F1Del", 4, 155, 155, 155, 100)
CppLogic.UI.WidgetSetTooltipData("RMG1F1Del", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG1F1Del", function() EMS.GL.UpdateTooltipManually("RMG_RandomSeed") end)
CppLogic.UI.WidgetSetTooltipString("RMG1F1Del", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG1F1Del", true)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG1", "RMG1Frame2", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG1Frame2", 0, 50, 112, 40)
XGUIEng.ShowWidget("RMG1Frame2", 1)
CppLogic.UI.WidgetSetBaseData("RMG1Frame2", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG1Frame2", "RMG1F2Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG1F2Text", 0, 0, 112, 20)
XGUIEng.ShowWidget("RMG1F2Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG1F2Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F2Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG1F2Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG1F2Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG1F2Text", 0)
XGUIEng.SetText("RMG1F2Text", "@center Landschaft", 1)
XGUIEng.SetTextColor("RMG1F2Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG1F2Text", true)
XGUIEng.SetLinesToPrint("RMG1F2Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG1F2Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG1Frame2", "RMG1F2Value", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG1F2Value", 28, 22, 56, 16)
XGUIEng.ShowWidget("RMG1F2Value", 1)
CppLogic.UI.WidgetSetBaseData("RMG1F2Value", 0, false, false)
XGUIEng.DisableButton("RMG1F2Value", 0)
XGUIEng.HighLightButton("RMG1F2Value", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG1F2Value", function() EMS.GL.Toggle("RMG_LandscapeSet") end)
CppLogic.UI.ButtonSetShortcutString("RMG1F2Value", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F2Value", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F2Value", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F2Value", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F2Value", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F2Value", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F2Value", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F2Value", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F2Value", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F2Value", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F2Value", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F2Value", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F2Value", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F2Value", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F2Value", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F2Value", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG1F2Value", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG1F2Value", function() EMS.GL.UpdateTooltip("RMG_LandscapeSet") end)
CppLogic.UI.WidgetSetTooltipString("RMG1F2Value", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG1F2Value", true)
CppLogic.UI.WidgetSetFont("RMG1F2Value", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG1F2Value", -5)
XGUIEng.SetText("RMG1F2Value", "@center Europa", 1)
XGUIEng.SetTextColor("RMG1F2Value", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG1", "RMG1Frame3", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG1Frame3", 0, 100, 112, 40)
XGUIEng.ShowWidget("RMG1Frame3", 1)
CppLogic.UI.WidgetSetBaseData("RMG1Frame3", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG1Frame3", "RMG1F3Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG1F3Text", 0, 0, 116, 20)
XGUIEng.ShowWidget("RMG1F3Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG1F3Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F3Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG1F3Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG1F3Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG1F3Text", 0)
XGUIEng.SetText("RMG1F3Text", "@center Flüsse", 1)
XGUIEng.SetTextColor("RMG1F3Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG1F3Text", true)
XGUIEng.SetLinesToPrint("RMG1F3Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG1F3Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG1Frame3", "RMG1F3Value", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG1F3Value", 28, 22, 56, 16)
XGUIEng.ShowWidget("RMG1F3Value", 1)
CppLogic.UI.WidgetSetBaseData("RMG1F3Value", 0, false, false)
XGUIEng.DisableButton("RMG1F3Value", 0)
XGUIEng.HighLightButton("RMG1F3Value", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG1F3Value", function() EMS.GL.Toggle("RMG_GenerateRivers") end)
CppLogic.UI.ButtonSetShortcutString("RMG1F3Value", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F3Value", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F3Value", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F3Value", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F3Value", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F3Value", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F3Value", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F3Value", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F3Value", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F3Value", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F3Value", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F3Value", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F3Value", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F3Value", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F3Value", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F3Value", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG1F3Value", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG1F3Value", function() EMS.GL.UpdateTooltip("RMG_GenerateRivers") end)
CppLogic.UI.WidgetSetTooltipString("RMG1F3Value", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG1F3Value", true)
CppLogic.UI.WidgetSetFont("RMG1F3Value", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG1F3Value", -5)
XGUIEng.SetText("RMG1F3Value", "@center ein", 1)
XGUIEng.SetTextColor("RMG1F3Value", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG1", "RMG1Frame4", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG1Frame4", 0, 150, 112, 40)
XGUIEng.ShowWidget("RMG1Frame4", 1)
CppLogic.UI.WidgetSetBaseData("RMG1Frame4", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG1Frame4", "RMG1F4Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG1F4Text", 0, 0, 116, 20)
XGUIEng.ShowWidget("RMG1F4Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG1F4Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F4Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG1F4Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG1F4Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG1F4Text", 0)
XGUIEng.SetText("RMG1F4Text", "@center Straßen", 1)
XGUIEng.SetTextColor("RMG1F4Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG1F4Text", true)
XGUIEng.SetLinesToPrint("RMG1F4Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG1F4Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG1Frame4", "RMG1F4Value", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG1F4Value", 28, 22, 56, 16)
XGUIEng.ShowWidget("RMG1F4Value", 1)
CppLogic.UI.WidgetSetBaseData("RMG1F4Value", 0, false, false)
XGUIEng.DisableButton("RMG1F4Value", 0)
XGUIEng.HighLightButton("RMG1F4Value", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG1F4Value", function() EMS.GL.Toggle("RMG_GenerateRoads") end)
CppLogic.UI.ButtonSetShortcutString("RMG1F4Value", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F4Value", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F4Value", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F4Value", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F4Value", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F4Value", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F4Value", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F4Value", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F4Value", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F4Value", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F4Value", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F4Value", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F4Value", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F4Value", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F4Value", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F4Value", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG1F4Value", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG1F4Value", function() EMS.GL.UpdateTooltip("RMG_GenerateRoads") end)
CppLogic.UI.WidgetSetTooltipString("RMG1F4Value", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG1F4Value", true)
CppLogic.UI.WidgetSetFont("RMG1F4Value", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG1F4Value", -5)
XGUIEng.SetText("RMG1F4Value", "@center ein", 1)
XGUIEng.SetTextColor("RMG1F4Value", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG1", "RMG1Frame5", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG1Frame5", 0, 200, 112, 40)
XGUIEng.ShowWidget("RMG1Frame5", 1)
CppLogic.UI.WidgetSetBaseData("RMG1Frame5", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG1Frame5", "RMG1F5Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG1F5Text", 0, 0, 116, 20)
XGUIEng.ShowWidget("RMG1F5Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG1F5Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F5Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG1F5Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG1F5Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG1F5Text", 0)
XGUIEng.SetText("RMG1F5Text", "@center Karte spiegeln", 1)
XGUIEng.SetTextColor("RMG1F5Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG1F5Text", true)
XGUIEng.SetLinesToPrint("RMG1F5Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG1F5Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG1Frame5", "RMG1F5Value", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG1F5Value", 28, 22, 56, 16)
XGUIEng.ShowWidget("RMG1F5Value", 1)
CppLogic.UI.WidgetSetBaseData("RMG1F5Value", 0, false, false)
XGUIEng.DisableButton("RMG1F5Value", 0)
XGUIEng.HighLightButton("RMG1F5Value", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG1F5Value", function() EMS.GL.Toggle("RMG_MirrorMap") end)
CppLogic.UI.ButtonSetShortcutString("RMG1F5Value", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F5Value", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F5Value", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F5Value", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F5Value", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F5Value", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F5Value", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F5Value", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F5Value", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F5Value", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F5Value", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F5Value", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F5Value", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F5Value", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F5Value", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F5Value", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG1F5Value", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG1F5Value", function() EMS.GL.UpdateTooltip("RMG_MirrorMap") end)
CppLogic.UI.WidgetSetTooltipString("RMG1F5Value", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG1F5Value", true)
CppLogic.UI.WidgetSetFont("RMG1F5Value", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG1F5Value", -5)
XGUIEng.SetText("RMG1F5Value", "@center ein", 1)
XGUIEng.SetTextColor("RMG1F5Value", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG1", "RMG1Frame6", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG1Frame6", 0, 350, 112, 40)
XGUIEng.ShowWidget("RMG1Frame6", 1)
CppLogic.UI.WidgetSetBaseData("RMG1Frame6", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG1Frame6", "RMG1F6Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG1F6Text", 0, 0, 116, 20)
XGUIEng.ShowWidget("RMG1F6Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG1F6Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F6Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG1F6Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG1F6Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG1F6Text", 0)
XGUIEng.SetText("RMG1F6Text", "@center Dorfzentren", 1)
XGUIEng.SetTextColor("RMG1F6Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG1F6Text", true)
XGUIEng.SetLinesToPrint("RMG1F6Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG1F6Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG1Frame6", "RMG1F6Value", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG1F6Value", 28, 22, 56, 16)
XGUIEng.ShowWidget("RMG1F6Value", 1)
CppLogic.UI.WidgetSetBaseData("RMG1F6Value", 0, false, false)
XGUIEng.DisableButton("RMG1F6Value", 0)
XGUIEng.HighLightButton("RMG1F6Value", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG1F6Value", function() EMS.GL.ActivateInput("RMG_AmountVC") end)
CppLogic.UI.ButtonSetShortcutString("RMG1F6Value", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F6Value", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F6Value", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F6Value", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F6Value", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F6Value", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F6Value", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F6Value", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F6Value", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F6Value", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F6Value", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F6Value", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F6Value", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG1F6Value", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG1F6Value", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG1F6Value", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG1F6Value", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG1F6Value", function() EMS.GL.UpdateTooltip("RMG_AmountVC") end)
CppLogic.UI.WidgetSetTooltipString("RMG1F6Value", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG1F6Value", true)
CppLogic.UI.WidgetSetFont("RMG1F6Value", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG1F6Value", -5)
XGUIEng.SetText("RMG1F6Value", "@center 3", 1)
XGUIEng.SetTextColor("RMG1F6Value", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("EMSPagesRMG", "RMG2", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG2", 130, 10, 120, 450)
XGUIEng.ShowWidget("RMG2", 1)
CppLogic.UI.WidgetSetBaseData("RMG2", 0, false, false)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG2", "RMG2Frame1", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG2Frame1", 4, 0, 112, 40)
XGUIEng.ShowWidget("RMG2Frame1", 1)
CppLogic.UI.WidgetSetBaseData("RMG2Frame1", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG2Frame1", "RMG2F1Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG2F1Text", 0, 0, 112, 20)
XGUIEng.ShowWidget("RMG2F1Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG2F1Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F1Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG2F1Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG2F1Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG2F1Text", 0)
XGUIEng.SetText("RMG2F1Text", "@center Geländehöhe", 1)
XGUIEng.SetTextColor("RMG2F1Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG2F1Text", true)
XGUIEng.SetLinesToPrint("RMG2F1Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG2F1Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG2Frame1", "RMG2F1Value", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG2F1Value", 28, 22, 56, 16)
XGUIEng.ShowWidget("RMG2F1Value", 1)
CppLogic.UI.WidgetSetBaseData("RMG2F1Value", 0, false, false)
XGUIEng.DisableButton("RMG2F1Value", 0)
XGUIEng.HighLightButton("RMG2F1Value", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG2F1Value", function() EMS.GL.ActivateInput("RMG_TerrainBaseHeight") end)
CppLogic.UI.ButtonSetShortcutString("RMG2F1Value", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F1Value", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG2F1Value", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG2F1Value", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F1Value", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG2F1Value", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG2F1Value", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F1Value", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG2F1Value", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG2F1Value", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F1Value", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG2F1Value", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG2F1Value", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F1Value", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG2F1Value", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG2F1Value", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG2F1Value", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG2F1Value", function() EMS.GL.UpdateTooltip("RMG_TerrainBaseHeight") end)
CppLogic.UI.WidgetSetTooltipString("RMG2F1Value", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG2F1Value", true)
CppLogic.UI.WidgetSetFont("RMG2F1Value", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG2F1Value", -5)
XGUIEng.SetText("RMG2F1Value", "@center 1900", 1)
XGUIEng.SetTextColor("RMG2F1Value", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG2", "RMG2Frame2", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG2Frame2", 4, 50, 112, 40)
XGUIEng.ShowWidget("RMG2Frame2", 1)
CppLogic.UI.WidgetSetBaseData("RMG2Frame2", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG2Frame2", "RMG2F2Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG2F2Text", 0, 0, 112, 20)
XGUIEng.ShowWidget("RMG2F2Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG2F2Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F2Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG2F2Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG2F2Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG2F2Text", 0)
XGUIEng.SetText("RMG2F2Text", "@center Wasserhöhe", 1)
XGUIEng.SetTextColor("RMG2F2Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG2F2Text", true)
XGUIEng.SetLinesToPrint("RMG2F2Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG2F2Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG2Frame2", "RMG2F2Value", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG2F2Value", 28, 22, 56, 16)
XGUIEng.ShowWidget("RMG2F2Value", 1)
CppLogic.UI.WidgetSetBaseData("RMG2F2Value", 0, false, false)
XGUIEng.DisableButton("RMG2F2Value", 0)
XGUIEng.HighLightButton("RMG2F2Value", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG2F2Value", function() EMS.GL.ActivateInput("RMG_WaterBaseHeight") end)
CppLogic.UI.ButtonSetShortcutString("RMG2F2Value", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F2Value", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG2F2Value", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG2F2Value", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F2Value", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG2F2Value", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG2F2Value", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F2Value", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG2F2Value", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG2F2Value", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F2Value", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG2F2Value", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG2F2Value", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F2Value", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG2F2Value", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG2F2Value", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG2F2Value", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG2F2Value", function() EMS.GL.UpdateTooltip("RMG_WaterBaseHeight") end)
CppLogic.UI.WidgetSetTooltipString("RMG2F2Value", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG2F2Value", true)
CppLogic.UI.WidgetSetFont("RMG2F2Value", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG2F2Value", -5)
XGUIEng.SetText("RMG2F2Value", "@center 1500", 1)
XGUIEng.SetTextColor("RMG2F2Value", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG2", "RMG2Frame3", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG2Frame3", 4, 100, 112, 40)
XGUIEng.ShowWidget("RMG2Frame3", 1)
CppLogic.UI.WidgetSetBaseData("RMG2Frame3", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG2Frame3", "RMG2F3Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG2F3Text", 0, 0, 112, 20)
XGUIEng.ShowWidget("RMG2F3Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG2F3Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F3Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG2F3Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG2F3Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG2F3Text", 0)
XGUIEng.SetText("RMG2F3Text", "@center Amplitude", 1)
XGUIEng.SetTextColor("RMG2F3Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG2F3Text", true)
XGUIEng.SetLinesToPrint("RMG2F3Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG2F3Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG2Frame3", "RMG2F3Value", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG2F3Value", 28, 22, 56, 16)
XGUIEng.ShowWidget("RMG2F3Value", 1)
CppLogic.UI.WidgetSetBaseData("RMG2F3Value", 0, false, false)
XGUIEng.DisableButton("RMG2F3Value", 0)
XGUIEng.HighLightButton("RMG2F3Value", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG2F3Value", function() EMS.GL.ActivateInput("RMG_NoiseFactorZ") end)
CppLogic.UI.ButtonSetShortcutString("RMG2F3Value", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F3Value", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG2F3Value", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG2F3Value", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F3Value", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG2F3Value", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG2F3Value", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F3Value", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG2F3Value", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG2F3Value", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F3Value", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG2F3Value", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG2F3Value", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F3Value", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG2F3Value", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG2F3Value", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG2F3Value", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG2F3Value", function() EMS.GL.UpdateTooltip("RMG_NoiseFactorZ") end)
CppLogic.UI.WidgetSetTooltipString("RMG2F3Value", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG2F3Value", true)
CppLogic.UI.WidgetSetFont("RMG2F3Value", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG2F3Value", -5)
XGUIEng.SetText("RMG2F3Value", "@center 100%", 1)
XGUIEng.SetTextColor("RMG2F3Value", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG2", "RMG2Frame4", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG2Frame4", 4, 150, 112, 40)
XGUIEng.ShowWidget("RMG2Frame4", 1)
CppLogic.UI.WidgetSetBaseData("RMG2Frame4", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG2Frame4", "RMG2F4Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG2F4Text", 0, 0, 112, 20)
XGUIEng.ShowWidget("RMG2F4Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG2F4Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F4Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG2F4Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG2F4Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG2F4Text", 0)
XGUIEng.SetText("RMG2F4Text", "@center Maßstab", 1)
XGUIEng.SetTextColor("RMG2F4Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG2F4Text", true)
XGUIEng.SetLinesToPrint("RMG2F4Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG2F4Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG2Frame4", "RMG2F4Value", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG2F4Value", 28, 22, 56, 16)
XGUIEng.ShowWidget("RMG2F4Value", 1)
CppLogic.UI.WidgetSetBaseData("RMG2F4Value", 0, false, false)
XGUIEng.DisableButton("RMG2F4Value", 0)
XGUIEng.HighLightButton("RMG2F4Value", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG2F4Value", function() EMS.GL.ActivateInput("RMG_NoiseFactorXY") end)
CppLogic.UI.ButtonSetShortcutString("RMG2F4Value", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F4Value", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG2F4Value", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG2F4Value", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F4Value", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG2F4Value", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG2F4Value", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F4Value", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG2F4Value", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG2F4Value", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F4Value", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG2F4Value", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG2F4Value", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG2F4Value", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG2F4Value", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG2F4Value", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG2F4Value", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG2F4Value", function() EMS.GL.UpdateTooltip("RMG_NoiseFactorXY") end)
CppLogic.UI.WidgetSetTooltipString("RMG2F4Value", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG2F4Value", true)
CppLogic.UI.WidgetSetFont("RMG2F4Value", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG2F4Value", -5)
XGUIEng.SetText("RMG2F4Value", "@center 100%", 1)
XGUIEng.SetTextColor("RMG2F4Value", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("EMSPagesRMG", "RMG3", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3", 250, 10, 120, 450)
XGUIEng.ShowWidget("RMG3", 1)
CppLogic.UI.WidgetSetBaseData("RMG3", 0, false, false)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG3", "RMG3Frame1", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3Frame1", 4, 0, 56, 40)
XGUIEng.ShowWidget("RMG3Frame1", 1)
CppLogic.UI.WidgetSetBaseData("RMG3Frame1", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG3Frame1", "RMG3F1Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F1Text", 0, 0, 56, 20)
XGUIEng.ShowWidget("RMG3F1Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F1Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F1Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG3F1Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG3F1Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F1Text", 0)
XGUIEng.SetText("RMG3F1Text", "@center Meer", 1)
XGUIEng.SetTextColor("RMG3F1Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F1Text", true)
XGUIEng.SetLinesToPrint("RMG3F1Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG3F1Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG3Frame1", "RMG3F1Value", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F1Value", 4, 22, 48, 16)
XGUIEng.ShowWidget("RMG3F1Value", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F1Value", 0, false, false)
XGUIEng.DisableButton("RMG3F1Value", 0)
XGUIEng.HighLightButton("RMG3F1Value", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG3F1Value", function() EMS.GL.ActivateInput("RMG_ThresholdSea") end)
CppLogic.UI.ButtonSetShortcutString("RMG3F1Value", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F1Value", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F1Value", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F1Value", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F1Value", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F1Value", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F1Value", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F1Value", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F1Value", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F1Value", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F1Value", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F1Value", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F1Value", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F1Value", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F1Value", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F1Value", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG3F1Value", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG3F1Value", function() EMS.GL.UpdateTooltip("RMG_ThresholdSea") end)
CppLogic.UI.WidgetSetTooltipString("RMG3F1Value", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F1Value", true)
CppLogic.UI.WidgetSetFont("RMG3F1Value", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F1Value", -5)
XGUIEng.SetText("RMG3F1Value", "@center -600", 1)
XGUIEng.SetTextColor("RMG3F1Value", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG3", "RMG3Frame2", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3Frame2", 60, 0, 56, 40)
XGUIEng.ShowWidget("RMG3Frame2", 1)
CppLogic.UI.WidgetSetBaseData("RMG3Frame2", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG3Frame2", "RMG3F2Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F2Text", 0, 0, 56, 20)
XGUIEng.ShowWidget("RMG3F2Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F2Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F2Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG3F2Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG3F2Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F2Text", 0)
XGUIEng.SetText("RMG3F2Text", "@center Gipfel", 1)
XGUIEng.SetTextColor("RMG3F2Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F2Text", true)
XGUIEng.SetLinesToPrint("RMG3F2Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG3F2Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG3Frame2", "RMG3F2Value", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F2Value", 4, 22, 48, 16)
XGUIEng.ShowWidget("RMG3F2Value", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F2Value", 0, false, false)
XGUIEng.DisableButton("RMG3F2Value", 0)
XGUIEng.HighLightButton("RMG3F2Value", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG3F2Value", function() EMS.GL.ActivateInput("RMG_ThresholdPike") end)
CppLogic.UI.ButtonSetShortcutString("RMG3F2Value", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F2Value", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F2Value", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F2Value", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F2Value", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F2Value", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F2Value", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F2Value", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F2Value", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F2Value", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F2Value", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F2Value", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F2Value", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F2Value", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F2Value", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F2Value", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG3F2Value", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG3F2Value", function() EMS.GL.UpdateTooltip("RMG_ThresholdPike") end)
CppLogic.UI.WidgetSetTooltipString("RMG3F2Value", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F2Value", true)
CppLogic.UI.WidgetSetFont("RMG3F2Value", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F2Value", -5)
XGUIEng.SetText("RMG3F2Value", "@center 600", 1)
XGUIEng.SetTextColor("RMG3F2Value", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG3", "RMG3Frame3", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3Frame3", 4, 50, 56, 40)
XGUIEng.ShowWidget("RMG3Frame3", 1)
CppLogic.UI.WidgetSetBaseData("RMG3Frame3", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG3Frame3", "RMG3F3Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F3Text", 0, 0, 56, 20)
XGUIEng.ShowWidget("RMG3F3Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F3Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F3Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG3F3Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG3F3Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F3Text", 0)
XGUIEng.SetText("RMG3F3Text", "@center See", 1)
XGUIEng.SetTextColor("RMG3F3Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F3Text", true)
XGUIEng.SetLinesToPrint("RMG3F3Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG3F3Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG3Frame3", "RMG3F3Value", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F3Value", 4, 22, 48, 16)
XGUIEng.ShowWidget("RMG3F3Value", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F3Value", 0, false, false)
XGUIEng.DisableButton("RMG3F3Value", 0)
XGUIEng.HighLightButton("RMG3F3Value", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG3F3Value", function() EMS.GL.ActivateInput("RMG_ThresholdLake") end)
CppLogic.UI.ButtonSetShortcutString("RMG3F3Value", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F3Value", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F3Value", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F3Value", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F3Value", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F3Value", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F3Value", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F3Value", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F3Value", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F3Value", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F3Value", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F3Value", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F3Value", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F3Value", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F3Value", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F3Value", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG3F3Value", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG3F3Value", function() EMS.GL.UpdateTooltip("RMG_ThresholdLake") end)
CppLogic.UI.WidgetSetTooltipString("RMG3F3Value", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F3Value", true)
CppLogic.UI.WidgetSetFont("RMG3F3Value", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F3Value", -5)
XGUIEng.SetText("RMG3F3Value", "@center -500", 1)
XGUIEng.SetTextColor("RMG3F3Value", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG3", "RMG3Frame4", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3Frame4", 60, 50, 56, 40)
XGUIEng.ShowWidget("RMG3Frame4", 1)
CppLogic.UI.WidgetSetBaseData("RMG3Frame4", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG3Frame4", "RMG3F4Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F4Text", 0, 0, 56, 20)
XGUIEng.ShowWidget("RMG3F4Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F4Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F4Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG3F4Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG3F4Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F4Text", 0)
XGUIEng.SetText("RMG3F4Text", "@center Berg", 1)
XGUIEng.SetTextColor("RMG3F4Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F4Text", true)
XGUIEng.SetLinesToPrint("RMG3F4Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG3F4Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG3Frame4", "RMG3F4Value", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F4Value", 4, 22, 48, 16)
XGUIEng.ShowWidget("RMG3F4Value", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F4Value", 0, false, false)
XGUIEng.DisableButton("RMG3F4Value", 0)
XGUIEng.HighLightButton("RMG3F4Value", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG3F4Value", function() EMS.GL.ActivateInput("RMG_ThresholdMountain") end)
CppLogic.UI.ButtonSetShortcutString("RMG3F4Value", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F4Value", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F4Value", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F4Value", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F4Value", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F4Value", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F4Value", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F4Value", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F4Value", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F4Value", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F4Value", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F4Value", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F4Value", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F4Value", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F4Value", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F4Value", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG3F4Value", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG3F4Value", function() EMS.GL.UpdateTooltip("RMG_ThresholdMountain") end)
CppLogic.UI.WidgetSetTooltipString("RMG3F4Value", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F4Value", true)
CppLogic.UI.WidgetSetFont("RMG3F4Value", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F4Value", -5)
XGUIEng.SetText("RMG3F4Value", "@center 500", 1)
XGUIEng.SetTextColor("RMG3F4Value", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG3", "RMG3Frame5", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3Frame5", 4, 100, 56, 40)
XGUIEng.ShowWidget("RMG3Frame5", 1)
CppLogic.UI.WidgetSetBaseData("RMG3Frame5", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG3Frame5", "RMG3F5Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F5Text", 0, 0, 56, 20)
XGUIEng.ShowWidget("RMG3F5Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F5Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F5Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG3F5Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG3F5Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F5Text", 0)
XGUIEng.SetText("RMG3F5Text", "@center Küste", 1)
XGUIEng.SetTextColor("RMG3F5Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F5Text", true)
XGUIEng.SetLinesToPrint("RMG3F5Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG3F5Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG3Frame5", "RMG3F5Value", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F5Value", 4, 22, 48, 16)
XGUIEng.ShowWidget("RMG3F5Value", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F5Value", 0, false, false)
XGUIEng.DisableButton("RMG3F5Value", 0)
XGUIEng.HighLightButton("RMG3F5Value", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG3F5Value", function() EMS.GL.ActivateInput("RMG_ThresholdCoast") end)
CppLogic.UI.ButtonSetShortcutString("RMG3F5Value", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F5Value", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F5Value", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F5Value", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F5Value", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F5Value", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F5Value", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F5Value", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F5Value", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F5Value", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F5Value", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F5Value", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F5Value", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F5Value", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F5Value", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F5Value", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG3F5Value", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG3F5Value", function() EMS.GL.UpdateTooltip("RMG_ThresholdCoast") end)
CppLogic.UI.WidgetSetTooltipString("RMG3F5Value", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F5Value", true)
CppLogic.UI.WidgetSetFont("RMG3F5Value", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F5Value", -5)
XGUIEng.SetText("RMG3F5Value", "@center -450", 1)
XGUIEng.SetTextColor("RMG3F5Value", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG3", "RMG3Frame6", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3Frame6", 60, 100, 56, 40)
XGUIEng.ShowWidget("RMG3Frame6", 1)
CppLogic.UI.WidgetSetBaseData("RMG3Frame6", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG3Frame6", "RMG3F6Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F6Text", 0, 0, 56, 20)
XGUIEng.ShowWidget("RMG3F6Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F6Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F6Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG3F6Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG3F6Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F6Text", 0)
XGUIEng.SetText("RMG3F6Text", "@center Hügel", 1)
XGUIEng.SetTextColor("RMG3F6Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F6Text", true)
XGUIEng.SetLinesToPrint("RMG3F6Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG3F6Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG3Frame6", "RMG3F6Value", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F6Value", 4, 22, 48, 16)
XGUIEng.ShowWidget("RMG3F6Value", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F6Value", 0, false, false)
XGUIEng.DisableButton("RMG3F6Value", 0)
XGUIEng.HighLightButton("RMG3F6Value", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG3F6Value", function() EMS.GL.ActivateInput("RMG_ThresholdHill") end)
CppLogic.UI.ButtonSetShortcutString("RMG3F6Value", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F6Value", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F6Value", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F6Value", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F6Value", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F6Value", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F6Value", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F6Value", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F6Value", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F6Value", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F6Value", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F6Value", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F6Value", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F6Value", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F6Value", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F6Value", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG3F6Value", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG3F6Value", function() EMS.GL.UpdateTooltip("RMG_ThresholdHill") end)
CppLogic.UI.WidgetSetTooltipString("RMG3F6Value", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F6Value", true)
CppLogic.UI.WidgetSetFont("RMG3F6Value", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F6Value", -5)
XGUIEng.SetText("RMG3F6Value", "@center 450", 1)
XGUIEng.SetTextColor("RMG3F6Value", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG3", "RMG3Frame7", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3Frame7", 4, 150, 112, 40)
XGUIEng.ShowWidget("RMG3Frame7", 1)
CppLogic.UI.WidgetSetBaseData("RMG3Frame7", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG3Frame7", "RMG3F7Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F7Text", 0, 0, 112, 20)
XGUIEng.ShowWidget("RMG3F7Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F7Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F7Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG3F7Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG3F7Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F7Text", 0)
XGUIEng.SetText("RMG3F7Text", "@center Wald", 1)
XGUIEng.SetTextColor("RMG3F7Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F7Text", true)
XGUIEng.SetLinesToPrint("RMG3F7Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG3F7Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG3Frame7", "RMG3F7Value1", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F7Value1", 4, 22, 48, 16)
XGUIEng.ShowWidget("RMG3F7Value1", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F7Value1", 0, false, false)
XGUIEng.DisableButton("RMG3F7Value1", 0)
XGUIEng.HighLightButton("RMG3F7Value1", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG3F7Value1", function() EMS.GL.ActivateInput("RMG_ThresholdLowForest") end)
CppLogic.UI.ButtonSetShortcutString("RMG3F7Value1", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F7Value1", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F7Value1", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F7Value1", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F7Value1", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F7Value1", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F7Value1", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F7Value1", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F7Value1", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F7Value1", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F7Value1", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F7Value1", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F7Value1", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F7Value1", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F7Value1", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F7Value1", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG3F7Value1", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG3F7Value1", function() EMS.GL.UpdateTooltip("RMG_ThresholdLowForest") end)
CppLogic.UI.WidgetSetTooltipString("RMG3F7Value1", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F7Value1", true)
CppLogic.UI.WidgetSetFont("RMG3F7Value1", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F7Value1", -5)
XGUIEng.SetText("RMG3F7Value1", "@center -275", 1)
XGUIEng.SetTextColor("RMG3F7Value1", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG3Frame7", "RMG3F7Value2", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F7Value2", 60, 22, 48, 16)
XGUIEng.ShowWidget("RMG3F7Value2", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F7Value2", 0, false, false)
XGUIEng.DisableButton("RMG3F7Value2", 0)
XGUIEng.HighLightButton("RMG3F7Value2", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG3F7Value2", function() EMS.GL.ActivateInput("RMG_ThresholdForest") end)
CppLogic.UI.ButtonSetShortcutString("RMG3F7Value2", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F7Value2", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F7Value2", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F7Value2", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F7Value2", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F7Value2", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F7Value2", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F7Value2", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F7Value2", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F7Value2", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F7Value2", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F7Value2", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F7Value2", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F7Value2", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F7Value2", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F7Value2", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG3F7Value2", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG3F7Value2", function() EMS.GL.UpdateTooltip("RMG_ThresholdForest") end)
CppLogic.UI.WidgetSetTooltipString("RMG3F7Value2", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F7Value2", true)
CppLogic.UI.WidgetSetFont("RMG3F7Value2", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F7Value2", -5)
XGUIEng.SetText("RMG3F7Value2", "@center 275", 1)
XGUIEng.SetTextColor("RMG3F7Value2", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG3", "RMG3Frame8", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3Frame8", 4, 200, 112, 40)
XGUIEng.ShowWidget("RMG3Frame8", 1)
CppLogic.UI.WidgetSetBaseData("RMG3Frame8", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG3Frame8", "RMG3F8Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F8Text", 0, 0, 112, 20)
XGUIEng.ShowWidget("RMG3F8Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F8Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F8Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG3F8Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG3F8Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F8Text", 0)
XGUIEng.SetText("RMG3F8Text", "@center Wiese", 1)
XGUIEng.SetTextColor("RMG3F8Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F8Text", true)
XGUIEng.SetLinesToPrint("RMG3F8Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG3F8Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG3Frame8", "RMG3F8Value1", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F8Value1", 4, 22, 48, 16)
XGUIEng.ShowWidget("RMG3F8Value1", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F8Value1", 0, false, false)
XGUIEng.DisableButton("RMG3F8Value1", 0)
XGUIEng.HighLightButton("RMG3F8Value1", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG3F8Value1", function() EMS.GL.ActivateInput("RMG_ThresholdLowMeadow") end)
CppLogic.UI.ButtonSetShortcutString("RMG3F8Value1", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F8Value1", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F8Value1", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F8Value1", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F8Value1", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F8Value1", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F8Value1", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F8Value1", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F8Value1", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F8Value1", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F8Value1", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F8Value1", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F8Value1", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F8Value1", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F8Value1", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F8Value1", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG3F8Value1", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG3F8Value1", function() EMS.GL.UpdateTooltip("RMG_ThresholdLowMeadow") end)
CppLogic.UI.WidgetSetTooltipString("RMG3F8Value1", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F8Value1", true)
CppLogic.UI.WidgetSetFont("RMG3F8Value1", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F8Value1", -5)
XGUIEng.SetText("RMG3F8Value1", "@center -225", 1)
XGUIEng.SetTextColor("RMG3F8Value1", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG3Frame8", "RMG3F8Value2", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F8Value2", 60, 22, 48, 16)
XGUIEng.ShowWidget("RMG3F8Value2", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F8Value2", 0, false, false)
XGUIEng.DisableButton("RMG3F8Value2", 0)
XGUIEng.HighLightButton("RMG3F8Value2", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG3F8Value2", function() EMS.GL.ActivateInput("RMG_ThresholdMeadow") end)
CppLogic.UI.ButtonSetShortcutString("RMG3F8Value2", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F8Value2", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F8Value2", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F8Value2", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F8Value2", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F8Value2", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F8Value2", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F8Value2", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F8Value2", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F8Value2", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F8Value2", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F8Value2", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F8Value2", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F8Value2", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F8Value2", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F8Value2", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG3F8Value2", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG3F8Value2", function() EMS.GL.UpdateTooltip("RMG_ThresholdMeadow") end)
CppLogic.UI.WidgetSetTooltipString("RMG3F8Value2", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F8Value2", true)
CppLogic.UI.WidgetSetFont("RMG3F8Value2", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F8Value2", -5)
XGUIEng.SetText("RMG3F8Value2", "@center 225", 1)
XGUIEng.SetTextColor("RMG3F8Value2", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG3", "RMG3Frame9", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3Frame9", 4, 250, 112, 40)
XGUIEng.ShowWidget("RMG3Frame9", 1)
CppLogic.UI.WidgetSetBaseData("RMG3Frame9", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG3Frame9", "RMG3F9Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F9Text", 0, 0, 112, 20)
XGUIEng.ShowWidget("RMG3F9Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F9Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F9Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG3F9Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG3F9Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F9Text", 0)
XGUIEng.SetText("RMG3F9Text", "@center Flachland", 1)
XGUIEng.SetTextColor("RMG3F9Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F9Text", true)
XGUIEng.SetLinesToPrint("RMG3F9Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG3F9Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG3Frame9", "RMG3F9Value1", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F9Value1", 4, 22, 48, 16)
XGUIEng.ShowWidget("RMG3F9Value1", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F9Value1", 0, false, false)
XGUIEng.DisableButton("RMG3F9Value1", 0)
XGUIEng.HighLightButton("RMG3F9Value1", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG3F9Value1", function() EMS.GL.ActivateInput("RMG_ThresholdLowFlatland") end)
CppLogic.UI.ButtonSetShortcutString("RMG3F9Value1", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F9Value1", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F9Value1", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F9Value1", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F9Value1", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F9Value1", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F9Value1", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F9Value1", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F9Value1", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F9Value1", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F9Value1", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F9Value1", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F9Value1", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F9Value1", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F9Value1", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F9Value1", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG3F9Value1", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG3F9Value1", function() EMS.GL.UpdateTooltip("RMG_ThresholdLowFlatland") end)
CppLogic.UI.WidgetSetTooltipString("RMG3F9Value1", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F9Value1", true)
CppLogic.UI.WidgetSetFont("RMG3F9Value1", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F9Value1", -5)
XGUIEng.SetText("RMG3F9Value1", "@center -420", 1)
XGUIEng.SetTextColor("RMG3F9Value1", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG3Frame9", "RMG3F9Value2", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F9Value2", 60, 22, 48, 16)
XGUIEng.ShowWidget("RMG3F9Value2", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F9Value2", 0, false, false)
XGUIEng.DisableButton("RMG3F9Value2", 0)
XGUIEng.HighLightButton("RMG3F9Value2", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG3F9Value2", function() EMS.GL.ActivateInput("RMG_ThresholdFlatland") end)
CppLogic.UI.ButtonSetShortcutString("RMG3F9Value2", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F9Value2", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F9Value2", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F9Value2", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F9Value2", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F9Value2", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F9Value2", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F9Value2", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F9Value2", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F9Value2", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F9Value2", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F9Value2", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F9Value2", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F9Value2", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F9Value2", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F9Value2", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG3F9Value2", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG3F9Value2", function() EMS.GL.UpdateTooltip("RMG_ThresholdFlatland") end)
CppLogic.UI.WidgetSetTooltipString("RMG3F9Value2", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F9Value2", true)
CppLogic.UI.WidgetSetFont("RMG3F9Value2", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F9Value2", -5)
XGUIEng.SetText("RMG3F9Value2", "@center 420", 1)
XGUIEng.SetTextColor("RMG3F9Value2", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG3", "RMG3Frame12", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3Frame12", 4, 350, 56, 46)
XGUIEng.ShowWidget("RMG3Frame12", 1)
CppLogic.UI.WidgetSetBaseData("RMG3Frame12", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG3Frame12", "RMG3F12Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F12Text", 0, 0, 56, 20)
XGUIEng.ShowWidget("RMG3F12Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F12Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F12Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG3F12Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG3F12Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F12Text", 0)
XGUIEng.SetText("RMG3F12Text", "@center Tiefen", 1)
XGUIEng.SetTextColor("RMG3F12Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F12Text", true)
XGUIEng.SetLinesToPrint("RMG3F12Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG3F12Text", 0)
CppLogic.UI.ContainerWidgetCreateGFXButtonWidgetChild("RMG3Frame12", "RMG3F12Decrease", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F12Decrease", 0, 18, 26, 26)
XGUIEng.ShowWidget("RMG3F12Decrease", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F12Decrease", 0, false, false)
XGUIEng.DisableButton("RMG3F12Decrease", 0)
XGUIEng.HighLightButton("RMG3F12Decrease", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG3F12Decrease", function() RandomMapGenerator.AddToLowThreshold(-10) end)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F12Decrease", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F12Decrease", 0, "data\\graphics\\textures\\gui\\trade_minus.png")
XGUIEng.SetMaterialColor("RMG3F12Decrease", 0, 200, 200, 200, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F12Decrease", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F12Decrease", 1, "data\\graphics\\textures\\gui\\trade_minus.png")
XGUIEng.SetMaterialColor("RMG3F12Decrease", 1, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F12Decrease", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F12Decrease", 2, "data\\graphics\\textures\\gui\\trade_minus.png")
XGUIEng.SetMaterialColor("RMG3F12Decrease", 2, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F12Decrease", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F12Decrease", 3, "data\\graphics\\textures\\gui\\trade_minus.png")
XGUIEng.SetMaterialColor("RMG3F12Decrease", 3, 128, 128, 128, 128)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F12Decrease", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F12Decrease", 4, "data\\graphics\\textures\\gui\\trade_minus.png")
XGUIEng.SetMaterialColor("RMG3F12Decrease", 4, 255, 255, 255, 255)
CppLogic.UI.WidgetSetTooltipData("RMG3F12Decrease", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG3F12Decrease", function() EMS.GL.UpdateTooltipManually("RMG_DecreaseThreshold") end)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F12Decrease", true)
CppLogic.UI.ContainerWidgetCreateGFXButtonWidgetChild("RMG3Frame12", "RMG3F12Increase", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F12Increase", 30, 18, 26, 26)
XGUIEng.ShowWidget("RMG3F12Increase", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F12Increase", 0, false, false)
XGUIEng.DisableButton("RMG3F12Increase", 0)
XGUIEng.HighLightButton("RMG3F12Increase", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG3F12Increase", function() RandomMapGenerator.AddToLowThreshold(10) end)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F12Increase", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F12Increase", 0, "data\\graphics\\textures\\gui\\trade_plus.png")
XGUIEng.SetMaterialColor("RMG3F12Increase", 0, 200, 200, 200, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F12Increase", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F12Increase", 1, "data\\graphics\\textures\\gui\\trade_plus.png")
XGUIEng.SetMaterialColor("RMG3F12Increase", 1, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F12Increase", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F12Increase", 2, "data\\graphics\\textures\\gui\\trade_plus.png")
XGUIEng.SetMaterialColor("RMG3F12Increase", 2, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F12Increase", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F12Increase", 3, "data\\graphics\\textures\\gui\\trade_plus.png")
XGUIEng.SetMaterialColor("RMG3F12Increase", 3, 128, 128, 128, 128)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F12Increase", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F12Increase", 4, "data\\graphics\\textures\\gui\\trade_plus.png")
XGUIEng.SetMaterialColor("RMG3F12Increase", 4, 255, 255, 255, 255)
CppLogic.UI.WidgetSetTooltipData("RMG3F12Increase", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG3F12Increase", function() EMS.GL.UpdateTooltipManually("RMG_IncreaseThreshold") end)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F12Increase", true)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG3", "RMG3Frame13", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3Frame13", 60, 350, 56, 46)
XGUIEng.ShowWidget("RMG3Frame13", 1)
CppLogic.UI.WidgetSetBaseData("RMG3Frame13", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG3Frame13", "RMG3F13Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F13Text", 0, 0, 56, 20)
XGUIEng.ShowWidget("RMG3F13Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F13Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F13Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG3F13Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG3F13Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F13Text", 0)
XGUIEng.SetText("RMG3F13Text", "@center Höhen", 1)
XGUIEng.SetTextColor("RMG3F13Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F13Text", true)
XGUIEng.SetLinesToPrint("RMG3F13Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG3F13Text", 0)
CppLogic.UI.ContainerWidgetCreateGFXButtonWidgetChild("RMG3Frame13", "RMG3F13Decrease", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F13Decrease", 0, 18, 26, 26)
XGUIEng.ShowWidget("RMG3F13Decrease", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F13Decrease", 0, false, false)
XGUIEng.DisableButton("RMG3F13Decrease", 0)
XGUIEng.HighLightButton("RMG3F13Decrease", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG3F13Decrease", function() RandomMapGenerator.AddToHighThreshold(-10) end)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F13Decrease", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F13Decrease", 0, "data\\graphics\\textures\\gui\\trade_minus.png")
XGUIEng.SetMaterialColor("RMG3F13Decrease", 0, 200, 200, 200, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F13Decrease", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F13Decrease", 1, "data\\graphics\\textures\\gui\\trade_minus.png")
XGUIEng.SetMaterialColor("RMG3F13Decrease", 1, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F13Decrease", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F13Decrease", 2, "data\\graphics\\textures\\gui\\trade_minus.png")
XGUIEng.SetMaterialColor("RMG3F13Decrease", 2, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F13Decrease", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F13Decrease", 3, "data\\graphics\\textures\\gui\\trade_minus.png")
XGUIEng.SetMaterialColor("RMG3F13Decrease", 3, 128, 128, 128, 128)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F13Decrease", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F13Decrease", 4, "data\\graphics\\textures\\gui\\trade_minus.png")
XGUIEng.SetMaterialColor("RMG3F13Decrease", 4, 255, 255, 255, 255)
CppLogic.UI.WidgetSetTooltipData("RMG3F13Decrease", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG3F13Decrease", function() EMS.GL.UpdateTooltipManually("RMG_DecreaseThreshold") end)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F13Decrease", true)
CppLogic.UI.ContainerWidgetCreateGFXButtonWidgetChild("RMG3Frame13", "RMG3F13Increase", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F13Increase", 30, 18, 26, 26)
XGUIEng.ShowWidget("RMG3F13Increase", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F13Increase", 0, false, false)
XGUIEng.DisableButton("RMG3F13Increase", 0)
XGUIEng.HighLightButton("RMG3F13Increase", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG3F13Increase", function() RandomMapGenerator.AddToHighThreshold(10) end)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F13Increase", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F13Increase", 0, "data\\graphics\\textures\\gui\\trade_plus.png")
XGUIEng.SetMaterialColor("RMG3F13Increase", 0, 200, 200, 200, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F13Increase", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F13Increase", 1, "data\\graphics\\textures\\gui\\trade_plus.png")
XGUIEng.SetMaterialColor("RMG3F13Increase", 1, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F13Increase", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F13Increase", 2, "data\\graphics\\textures\\gui\\trade_plus.png")
XGUIEng.SetMaterialColor("RMG3F13Increase", 2, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F13Increase", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F13Increase", 3, "data\\graphics\\textures\\gui\\trade_plus.png")
XGUIEng.SetMaterialColor("RMG3F13Increase", 3, 128, 128, 128, 128)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F13Increase", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F13Increase", 4, "data\\graphics\\textures\\gui\\trade_plus.png")
XGUIEng.SetMaterialColor("RMG3F13Increase", 4, 255, 255, 255, 255)
CppLogic.UI.WidgetSetTooltipData("RMG3F13Increase", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG3F13Increase", function() EMS.GL.UpdateTooltipManually("RMG_IncreaseThreshold") end)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F13Increase", true)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("EMSPagesRMG", "RMG4", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG4", 370, 10, 120, 450)
XGUIEng.ShowWidget("RMG4", 1)
CppLogic.UI.WidgetSetBaseData("RMG4", 0, false, false)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG4", "RMG4Frame3", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG4Frame3", 60, 150, 56, 40)
XGUIEng.ShowWidget("RMG4Frame3", 1)
CppLogic.UI.WidgetSetBaseData("RMG4Frame3", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG4Frame3", "RMG4F3Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG4F3Text", 0, 0, 56, 20)
XGUIEng.ShowWidget("RMG4F3Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG4F3Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG4F3Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG4F3Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG4F3Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG4F3Text", 0)
XGUIEng.SetText("RMG4F3Text", "@center Hochwald", 1)
XGUIEng.SetTextColor("RMG4F3Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG4F3Text", true)
XGUIEng.SetLinesToPrint("RMG4F3Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG4F3Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG4Frame3", "RMG4F3Value1", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG4F3Value1", 4, 22, 48, 16)
XGUIEng.ShowWidget("RMG4F3Value1", 1)
CppLogic.UI.WidgetSetBaseData("RMG4F3Value1", 0, false, false)
XGUIEng.DisableButton("RMG4F3Value1", 0)
XGUIEng.HighLightButton("RMG4F3Value1", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG4F3Value1", function() EMS.GL.ActivateInput("RMG_ThresholdHighForest") end)
CppLogic.UI.ButtonSetShortcutString("RMG4F3Value1", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG4F3Value1", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG4F3Value1", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG4F3Value1", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG4F3Value1", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG4F3Value1", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG4F3Value1", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG4F3Value1", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG4F3Value1", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG4F3Value1", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG4F3Value1", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG4F3Value1", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG4F3Value1", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG4F3Value1", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG4F3Value1", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG4F3Value1", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG4F3Value1", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG4F3Value1", function() EMS.GL.UpdateTooltip("RMG_ThresholdHighForest") end)
CppLogic.UI.WidgetSetTooltipString("RMG4F3Value1", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG4F3Value1", true)
CppLogic.UI.WidgetSetFont("RMG4F3Value1", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG4F3Value1", -5)
XGUIEng.SetText("RMG4F3Value1", "@center 1000", 1)
XGUIEng.SetTextColor("RMG4F3Value1", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG4", "RMG4Frame2", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG4Frame2", 60, 200, 56, 40)
XGUIEng.ShowWidget("RMG4Frame2", 1)
CppLogic.UI.WidgetSetBaseData("RMG4Frame2", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG4Frame2", "RMG4F2Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG4F2Text", 0, 0, 56, 20)
XGUIEng.ShowWidget("RMG4F2Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG4F2Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG4F2Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG4F2Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG4F2Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG4F2Text", 0)
XGUIEng.SetText("RMG4F2Text", "@center Hochwiese", 1)
XGUIEng.SetTextColor("RMG4F2Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG4F2Text", true)
XGUIEng.SetLinesToPrint("RMG4F2Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG4F2Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG4Frame2", "RMG4F2Value1", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG4F2Value1", 4, 22, 48, 16)
XGUIEng.ShowWidget("RMG4F2Value1", 1)
CppLogic.UI.WidgetSetBaseData("RMG4F2Value1", 0, false, false)
XGUIEng.DisableButton("RMG4F2Value1", 0)
XGUIEng.HighLightButton("RMG4F2Value1", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG4F2Value1", function() EMS.GL.ActivateInput("RMG_ThresholdHighMeadow") end)
CppLogic.UI.ButtonSetShortcutString("RMG4F2Value1", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG4F2Value1", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG4F2Value1", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG4F2Value1", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG4F2Value1", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG4F2Value1", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG4F2Value1", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG4F2Value1", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG4F2Value1", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG4F2Value1", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG4F2Value1", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG4F2Value1", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG4F2Value1", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG4F2Value1", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG4F2Value1", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG4F2Value1", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG4F2Value1", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG4F2Value1", function() EMS.GL.UpdateTooltip("RMG_ThresholdHighMeadow") end)
CppLogic.UI.WidgetSetTooltipString("RMG4F2Value1", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG4F2Value1", true)
CppLogic.UI.WidgetSetFont("RMG4F2Value1", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG4F2Value1", -5)
XGUIEng.SetText("RMG4F2Value1", "@center 1000", 1)
XGUIEng.SetTextColor("RMG4F2Value1", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG4", "RMG4Frame1", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG4Frame1", 60, 250, 56, 40)
XGUIEng.ShowWidget("RMG4Frame1", 1)
CppLogic.UI.WidgetSetBaseData("RMG4Frame1", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG4Frame1", "RMG4F1Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG4F1Text", 0, 0, 56, 20)
XGUIEng.ShowWidget("RMG4F1Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG4F1Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG4F1Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG4F1Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG4F1Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG4F1Text", 0)
XGUIEng.SetText("RMG4F1Text", "@center Plateau", 1)
XGUIEng.SetTextColor("RMG4F1Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG4F1Text", true)
XGUIEng.SetLinesToPrint("RMG4F1Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG4F1Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG4Frame1", "RMG4F1Value1", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG4F1Value1", 4, 22, 48, 16)
XGUIEng.ShowWidget("RMG4F1Value1", 1)
CppLogic.UI.WidgetSetBaseData("RMG4F1Value1", 0, false, false)
XGUIEng.DisableButton("RMG4F1Value1", 0)
XGUIEng.HighLightButton("RMG4F1Value1", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG4F1Value1", function() EMS.GL.ActivateInput("RMG_ThresholdPlateau") end)
CppLogic.UI.ButtonSetShortcutString("RMG4F1Value1", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG4F1Value1", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG4F1Value1", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG4F1Value1", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG4F1Value1", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG4F1Value1", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG4F1Value1", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG4F1Value1", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG4F1Value1", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG4F1Value1", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG4F1Value1", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG4F1Value1", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG4F1Value1", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG4F1Value1", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG4F1Value1", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG4F1Value1", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG4F1Value1", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG4F1Value1", function() EMS.GL.UpdateTooltip("RMG_ThresholdPlateau") end)
CppLogic.UI.WidgetSetTooltipString("RMG4F1Value1", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG4F1Value1", true)
CppLogic.UI.WidgetSetFont("RMG4F1Value1", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG4F1Value1", -5)
XGUIEng.SetText("RMG4F1Value1", "@center 1000", 1)
XGUIEng.SetTextColor("RMG4F1Value1", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG4", "RMG3Frame10", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3Frame10", 60, 300, 56, 40)
XGUIEng.ShowWidget("RMG3Frame10", 1)
CppLogic.UI.WidgetSetBaseData("RMG3Frame10", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG3Frame10", "RMG3F10Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F10Text", 0, 0, 56, 20)
XGUIEng.ShowWidget("RMG3F10Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F10Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F10Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG3F10Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG3F10Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F10Text", 0)
XGUIEng.SetText("RMG3F10Text", "@center Straße", 1)
XGUIEng.SetTextColor("RMG3F10Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F10Text", true)
XGUIEng.SetLinesToPrint("RMG3F10Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG3F10Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG3Frame10", "RMG3F10Value", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F10Value", 4, 22, 48, 16)
XGUIEng.ShowWidget("RMG3F10Value", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F10Value", 0, false, false)
XGUIEng.DisableButton("RMG3F10Value", 0)
XGUIEng.HighLightButton("RMG3F10Value", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG3F10Value", function() EMS.GL.ActivateInput("RMG_ThresholdRoad") end)
CppLogic.UI.ButtonSetShortcutString("RMG3F10Value", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F10Value", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F10Value", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F10Value", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F10Value", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F10Value", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F10Value", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F10Value", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F10Value", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F10Value", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F10Value", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F10Value", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F10Value", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F10Value", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F10Value", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG3F10Value", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG3F10Value", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG3F10Value", function() EMS.GL.UpdateTooltip("RMG_ThresholdRoad") end)
CppLogic.UI.WidgetSetTooltipString("RMG3F10Value", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F10Value", true)
CppLogic.UI.WidgetSetFont("RMG3F10Value", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F10Value", -5)
XGUIEng.SetText("RMG3F10Value", "@center 0", 1)
XGUIEng.SetTextColor("RMG3F10Value", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG4", "RMG3Frame11", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3Frame11", 60, 350, 56, 46)
XGUIEng.ShowWidget("RMG3Frame11", 1)
CppLogic.UI.WidgetSetBaseData("RMG3Frame11", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG3Frame11", "RMG3F11Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F11Text", 0, 0, 56, 20)
XGUIEng.ShowWidget("RMG3F11Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F11Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F11Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG3F11Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG3F11Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG3F11Text", 0)
XGUIEng.SetText("RMG3F11Text", "@center Alle", 1)
XGUIEng.SetTextColor("RMG3F11Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F11Text", true)
XGUIEng.SetLinesToPrint("RMG3F11Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG3F11Text", 0)
CppLogic.UI.ContainerWidgetCreateGFXButtonWidgetChild("RMG3Frame11", "RMG3F11Decrease", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F11Decrease", 0, 18, 26, 26)
XGUIEng.ShowWidget("RMG3F11Decrease", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F11Decrease", 0, false, false)
XGUIEng.DisableButton("RMG3F11Decrease", 0)
XGUIEng.HighLightButton("RMG3F11Decrease", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG3F11Decrease", function() RandomMapGenerator.AddToThreshold(-10) end)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F11Decrease", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F11Decrease", 0, "data\\graphics\\textures\\gui\\trade_minus.png")
XGUIEng.SetMaterialColor("RMG3F11Decrease", 0, 200, 200, 200, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F11Decrease", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F11Decrease", 1, "data\\graphics\\textures\\gui\\trade_minus.png")
XGUIEng.SetMaterialColor("RMG3F11Decrease", 1, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F11Decrease", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F11Decrease", 2, "data\\graphics\\textures\\gui\\trade_minus.png")
XGUIEng.SetMaterialColor("RMG3F11Decrease", 2, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F11Decrease", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F11Decrease", 3, "data\\graphics\\textures\\gui\\trade_minus.png")
XGUIEng.SetMaterialColor("RMG3F11Decrease", 3, 128, 128, 128, 128)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F11Decrease", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F11Decrease", 4, "data\\graphics\\textures\\gui\\trade_minus.png")
XGUIEng.SetMaterialColor("RMG3F11Decrease", 4, 255, 255, 255, 255)
CppLogic.UI.WidgetSetTooltipData("RMG3F11Decrease", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG3F11Decrease", function() EMS.GL.UpdateTooltipManually("RMG_DecreaseThreshold") end)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F11Decrease", true)
CppLogic.UI.ContainerWidgetCreateGFXButtonWidgetChild("RMG3Frame11", "RMG3F11Increase", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG3F11Increase", 30, 18, 26, 26)
XGUIEng.ShowWidget("RMG3F11Increase", 1)
CppLogic.UI.WidgetSetBaseData("RMG3F11Increase", 0, false, false)
XGUIEng.DisableButton("RMG3F11Increase", 0)
XGUIEng.HighLightButton("RMG3F11Increase", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG3F11Increase", function() RandomMapGenerator.AddToThreshold(10) end)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F11Increase", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F11Increase", 0, "data\\graphics\\textures\\gui\\trade_plus.png")
XGUIEng.SetMaterialColor("RMG3F11Increase", 0, 200, 200, 200, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F11Increase", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F11Increase", 1, "data\\graphics\\textures\\gui\\trade_plus.png")
XGUIEng.SetMaterialColor("RMG3F11Increase", 1, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F11Increase", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F11Increase", 2, "data\\graphics\\textures\\gui\\trade_plus.png")
XGUIEng.SetMaterialColor("RMG3F11Increase", 2, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F11Increase", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F11Increase", 3, "data\\graphics\\textures\\gui\\trade_plus.png")
XGUIEng.SetMaterialColor("RMG3F11Increase", 3, 128, 128, 128, 128)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG3F11Increase", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG3F11Increase", 4, "data\\graphics\\textures\\gui\\trade_plus.png")
XGUIEng.SetMaterialColor("RMG3F11Increase", 4, 255, 255, 255, 255)
CppLogic.UI.WidgetSetTooltipData("RMG3F11Increase", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG3F11Increase", function() EMS.GL.UpdateTooltipManually("RMG_IncreaseThreshold") end)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG3F11Increase", true)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("EMSPagesRMG", "RMG5", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5", 490, 10, 120, 450)
XGUIEng.ShowWidget("RMG5", 1)
CppLogic.UI.WidgetSetBaseData("RMG5", 0, false, false)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG5", "RMG5Frame1", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5Frame1", 4, 0, 112, 40)
XGUIEng.ShowWidget("RMG5Frame1", 1)
CppLogic.UI.WidgetSetBaseData("RMG5Frame1", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG5Frame1", "RMG5F1Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F1Text", 0, 0, 112, 20)
XGUIEng.ShowWidget("RMG5F1Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F1Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F1Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG5F1Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG5F1Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F1Text", 0)
XGUIEng.SetText("RMG5F1Text", "@center Lehmschächte", 1)
XGUIEng.SetTextColor("RMG5F1Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F1Text", true)
XGUIEng.SetLinesToPrint("RMG5F1Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG5F1Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG5Frame1", "RMG5F1Value1", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F1Value1", 4, 22, 24, 16)
XGUIEng.ShowWidget("RMG5F1Value1", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F1Value1", 0, false, false)
XGUIEng.DisableButton("RMG5F1Value1", 0)
XGUIEng.HighLightButton("RMG5F1Value1", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG5F1Value1", function() EMS.GL.ActivateInput("RMG_AmountClayPit") end)
CppLogic.UI.ButtonSetShortcutString("RMG5F1Value1", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F1Value1", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F1Value1", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F1Value1", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F1Value1", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F1Value1", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F1Value1", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F1Value1", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F1Value1", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F1Value1", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F1Value1", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F1Value1", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F1Value1", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F1Value1", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F1Value1", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F1Value1", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG5F1Value1", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG5F1Value1", function() EMS.GL.UpdateTooltip("RMG_AmountClayPit") end)
CppLogic.UI.WidgetSetTooltipString("RMG5F1Value1", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F1Value1", true)
CppLogic.UI.WidgetSetFont("RMG5F1Value1", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F1Value1", -5)
XGUIEng.SetText("RMG5F1Value1", "@center 1", 1)
XGUIEng.SetTextColor("RMG5F1Value1", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG5Frame1", "RMG5F1Value2", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F1Value2", 36, 22, 72, 16)
XGUIEng.ShowWidget("RMG5F1Value2", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F1Value2", 0, false, false)
XGUIEng.DisableButton("RMG5F1Value2", 0)
XGUIEng.HighLightButton("RMG5F1Value2", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG5F1Value2", function() EMS.GL.ActivateInput("RMG_ContentClayPit") end)
CppLogic.UI.ButtonSetShortcutString("RMG5F1Value2", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F1Value2", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F1Value2", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F1Value2", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F1Value2", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F1Value2", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F1Value2", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F1Value2", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F1Value2", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F1Value2", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F1Value2", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F1Value2", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F1Value2", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F1Value2", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F1Value2", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F1Value2", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG5F1Value2", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG5F1Value2", function() EMS.GL.UpdateTooltip("RMG_ContentClayPit") end)
CppLogic.UI.WidgetSetTooltipString("RMG5F1Value2", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F1Value2", true)
CppLogic.UI.WidgetSetFont("RMG5F1Value2", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F1Value2", -5)
XGUIEng.SetText("RMG5F1Value2", "@center 50000", 1)
XGUIEng.SetTextColor("RMG5F1Value2", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG5", "RMG5Frame2", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5Frame2", 4, 50, 112, 40)
XGUIEng.ShowWidget("RMG5Frame2", 1)
CppLogic.UI.WidgetSetBaseData("RMG5Frame2", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG5Frame2", "RMG5F2Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F2Text", 0, 0, 112, 20)
XGUIEng.ShowWidget("RMG5F2Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F2Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F2Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG5F2Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG5F2Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F2Text", 0)
XGUIEng.SetText("RMG5F2Text", "@center Lehmhaufen", 1)
XGUIEng.SetTextColor("RMG5F2Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F2Text", true)
XGUIEng.SetLinesToPrint("RMG5F2Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG5F2Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG5Frame2", "RMG5F2Value1", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F2Value1", 4, 22, 24, 16)
XGUIEng.ShowWidget("RMG5F2Value1", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F2Value1", 0, false, false)
XGUIEng.DisableButton("RMG5F2Value1", 0)
XGUIEng.HighLightButton("RMG5F2Value1", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG5F2Value1", function() EMS.GL.ActivateInput("RMG_AmountClayPile") end)
CppLogic.UI.ButtonSetShortcutString("RMG5F2Value1", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F2Value1", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F2Value1", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F2Value1", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F2Value1", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F2Value1", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F2Value1", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F2Value1", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F2Value1", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F2Value1", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F2Value1", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F2Value1", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F2Value1", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F2Value1", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F2Value1", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F2Value1", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG5F2Value1", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG5F2Value1", function() EMS.GL.UpdateTooltip("RMG_AmountClayPile") end)
CppLogic.UI.WidgetSetTooltipString("RMG5F2Value1", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F2Value1", true)
CppLogic.UI.WidgetSetFont("RMG5F2Value1", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F2Value1", -5)
XGUIEng.SetText("RMG5F2Value1", "@center 4", 1)
XGUIEng.SetTextColor("RMG5F2Value1", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG5Frame2", "RMG5F2Value2", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F2Value2", 36, 22, 72, 16)
XGUIEng.ShowWidget("RMG5F2Value2", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F2Value2", 0, false, false)
XGUIEng.DisableButton("RMG5F2Value2", 0)
XGUIEng.HighLightButton("RMG5F2Value2", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG5F2Value2", function() EMS.GL.ActivateInput("RMG_ContentClayPile") end)
CppLogic.UI.ButtonSetShortcutString("RMG5F2Value2", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F2Value2", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F2Value2", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F2Value2", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F2Value2", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F2Value2", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F2Value2", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F2Value2", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F2Value2", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F2Value2", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F2Value2", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F2Value2", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F2Value2", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F2Value2", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F2Value2", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F2Value2", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG5F2Value2", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG5F2Value2", function() EMS.GL.UpdateTooltip("RMG_ContentClayPile") end)
CppLogic.UI.WidgetSetTooltipString("RMG5F2Value2", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F2Value2", true)
CppLogic.UI.WidgetSetFont("RMG5F2Value2", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F2Value2", -5)
XGUIEng.SetText("RMG5F2Value2", "@center 4000", 1)
XGUIEng.SetTextColor("RMG5F2Value2", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG5", "RMG5Frame3", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5Frame3", 4, 100, 112, 40)
XGUIEng.ShowWidget("RMG5Frame3", 1)
CppLogic.UI.WidgetSetBaseData("RMG5Frame3", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG5Frame3", "RMG5F3Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F3Text", 0, 0, 112, 20)
XGUIEng.ShowWidget("RMG5F3Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F3Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F3Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG5F3Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG5F3Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F3Text", 0)
XGUIEng.SetText("RMG5F3Text", "@center Steinbrüche", 1)
XGUIEng.SetTextColor("RMG5F3Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F3Text", true)
XGUIEng.SetLinesToPrint("RMG5F3Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG5F3Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG5Frame3", "RMG5F3Value1", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F3Value1", 4, 22, 24, 16)
XGUIEng.ShowWidget("RMG5F3Value1", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F3Value1", 0, false, false)
XGUIEng.DisableButton("RMG5F3Value1", 0)
XGUIEng.HighLightButton("RMG5F3Value1", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG5F3Value1", function() EMS.GL.ActivateInput("RMG_AmountStonePit") end)
CppLogic.UI.ButtonSetShortcutString("RMG5F3Value1", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F3Value1", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F3Value1", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F3Value1", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F3Value1", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F3Value1", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F3Value1", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F3Value1", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F3Value1", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F3Value1", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F3Value1", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F3Value1", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F3Value1", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F3Value1", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F3Value1", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F3Value1", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG5F3Value1", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG5F3Value1", function() EMS.GL.UpdateTooltip("RMG_AmountStonePit") end)
CppLogic.UI.WidgetSetTooltipString("RMG5F3Value1", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F3Value1", true)
CppLogic.UI.WidgetSetFont("RMG5F3Value1", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F3Value1", -5)
XGUIEng.SetText("RMG5F3Value1", "@center 1", 1)
XGUIEng.SetTextColor("RMG5F3Value1", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG5Frame3", "RMG5F3Value2", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F3Value2", 36, 22, 72, 16)
XGUIEng.ShowWidget("RMG5F3Value2", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F3Value2", 0, false, false)
XGUIEng.DisableButton("RMG5F3Value2", 0)
XGUIEng.HighLightButton("RMG5F3Value2", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG5F3Value2", function() EMS.GL.ActivateInput("RMG_ContentStonePit") end)
CppLogic.UI.ButtonSetShortcutString("RMG5F3Value2", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F3Value2", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F3Value2", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F3Value2", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F3Value2", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F3Value2", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F3Value2", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F3Value2", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F3Value2", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F3Value2", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F3Value2", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F3Value2", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F3Value2", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F3Value2", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F3Value2", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F3Value2", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG5F3Value2", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG5F3Value2", function() EMS.GL.UpdateTooltip("RMG_ContentStonePit") end)
CppLogic.UI.WidgetSetTooltipString("RMG5F3Value2", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F3Value2", true)
CppLogic.UI.WidgetSetFont("RMG5F3Value2", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F3Value2", -5)
XGUIEng.SetText("RMG5F3Value2", "@center 50000", 1)
XGUIEng.SetTextColor("RMG5F3Value2", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG5", "RMG5Frame4", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5Frame4", 4, 150, 112, 40)
XGUIEng.ShowWidget("RMG5Frame4", 1)
CppLogic.UI.WidgetSetBaseData("RMG5Frame4", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG5Frame4", "RMG5F4Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F4Text", 0, 0, 112, 20)
XGUIEng.ShowWidget("RMG5F4Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F4Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F4Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG5F4Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG5F4Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F4Text", 0)
XGUIEng.SetText("RMG5F4Text", "@center Steinhaufen", 1)
XGUIEng.SetTextColor("RMG5F4Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F4Text", true)
XGUIEng.SetLinesToPrint("RMG5F4Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG5F4Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG5Frame4", "RMG5F4Value1", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F4Value1", 4, 22, 24, 16)
XGUIEng.ShowWidget("RMG5F4Value1", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F4Value1", 0, false, false)
XGUIEng.DisableButton("RMG5F4Value1", 0)
XGUIEng.HighLightButton("RMG5F4Value1", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG5F4Value1", function() EMS.GL.ActivateInput("RMG_AmountStonePile") end)
CppLogic.UI.ButtonSetShortcutString("RMG5F4Value1", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F4Value1", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F4Value1", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F4Value1", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F4Value1", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F4Value1", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F4Value1", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F4Value1", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F4Value1", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F4Value1", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F4Value1", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F4Value1", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F4Value1", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F4Value1", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F4Value1", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F4Value1", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG5F4Value1", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG5F4Value1", function() EMS.GL.UpdateTooltip("RMG_AmountStonePile") end)
CppLogic.UI.WidgetSetTooltipString("RMG5F4Value1", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F4Value1", true)
CppLogic.UI.WidgetSetFont("RMG5F4Value1", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F4Value1", -5)
XGUIEng.SetText("RMG5F4Value1", "@center 4", 1)
XGUIEng.SetTextColor("RMG5F4Value1", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG5Frame4", "RMG5F4Value2", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F4Value2", 36, 22, 72, 16)
XGUIEng.ShowWidget("RMG5F4Value2", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F4Value2", 0, false, false)
XGUIEng.DisableButton("RMG5F4Value2", 0)
XGUIEng.HighLightButton("RMG5F4Value2", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG5F4Value2", function() EMS.GL.ActivateInput("RMG_ContentStonePile") end)
CppLogic.UI.ButtonSetShortcutString("RMG5F4Value2", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F4Value2", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F4Value2", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F4Value2", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F4Value2", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F4Value2", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F4Value2", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F4Value2", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F4Value2", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F4Value2", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F4Value2", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F4Value2", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F4Value2", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F4Value2", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F4Value2", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F4Value2", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG5F4Value2", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG5F4Value2", function() EMS.GL.UpdateTooltip("RMG_ContentStonePile") end)
CppLogic.UI.WidgetSetTooltipString("RMG5F4Value2", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F4Value2", true)
CppLogic.UI.WidgetSetFont("RMG5F4Value2", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F4Value2", -5)
XGUIEng.SetText("RMG5F4Value2", "@center 4000", 1)
XGUIEng.SetTextColor("RMG5F4Value2", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG5", "RMG5Frame5", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5Frame5", 4, 200, 112, 40)
XGUIEng.ShowWidget("RMG5Frame5", 1)
CppLogic.UI.WidgetSetBaseData("RMG5Frame5", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG5Frame5", "RMG5F5Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F5Text", 0, 0, 112, 20)
XGUIEng.ShowWidget("RMG5F5Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F5Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F5Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG5F5Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG5F5Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F5Text", 0)
XGUIEng.SetText("RMG5F5Text", "@center Eisenschächte", 1)
XGUIEng.SetTextColor("RMG5F5Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F5Text", true)
XGUIEng.SetLinesToPrint("RMG5F5Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG5F5Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG5Frame5", "RMG5F5Value1", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F5Value1", 4, 22, 24, 16)
XGUIEng.ShowWidget("RMG5F5Value1", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F5Value1", 0, false, false)
XGUIEng.DisableButton("RMG5F5Value1", 0)
XGUIEng.HighLightButton("RMG5F5Value1", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG5F5Value1", function() EMS.GL.ActivateInput("RMG_AmountIronPit") end)
CppLogic.UI.ButtonSetShortcutString("RMG5F5Value1", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F5Value1", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F5Value1", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F5Value1", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F5Value1", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F5Value1", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F5Value1", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F5Value1", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F5Value1", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F5Value1", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F5Value1", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F5Value1", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F5Value1", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F5Value1", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F5Value1", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F5Value1", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG5F5Value1", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG5F5Value1", function() EMS.GL.UpdateTooltip("RMG_AmountIronPit") end)
CppLogic.UI.WidgetSetTooltipString("RMG5F5Value1", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F5Value1", true)
CppLogic.UI.WidgetSetFont("RMG5F5Value1", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F5Value1", -5)
XGUIEng.SetText("RMG5F5Value1", "@center 2", 1)
XGUIEng.SetTextColor("RMG5F5Value1", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG5Frame5", "RMG5F5Value2", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F5Value2", 36, 22, 72, 16)
XGUIEng.ShowWidget("RMG5F5Value2", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F5Value2", 0, false, false)
XGUIEng.DisableButton("RMG5F5Value2", 0)
XGUIEng.HighLightButton("RMG5F5Value2", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG5F5Value2", function() EMS.GL.ActivateInput("RMG_ContentIronPit") end)
CppLogic.UI.ButtonSetShortcutString("RMG5F5Value2", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F5Value2", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F5Value2", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F5Value2", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F5Value2", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F5Value2", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F5Value2", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F5Value2", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F5Value2", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F5Value2", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F5Value2", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F5Value2", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F5Value2", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F5Value2", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F5Value2", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F5Value2", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG5F5Value2", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG5F5Value2", function() EMS.GL.UpdateTooltip("RMG_ContentIronPit") end)
CppLogic.UI.WidgetSetTooltipString("RMG5F5Value2", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F5Value2", true)
CppLogic.UI.WidgetSetFont("RMG5F5Value2", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F5Value2", -5)
XGUIEng.SetText("RMG5F5Value2", "@center 50000", 1)
XGUIEng.SetTextColor("RMG5F5Value2", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG5", "RMG5Frame6", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5Frame6", 4, 250, 112, 40)
XGUIEng.ShowWidget("RMG5Frame6", 1)
CppLogic.UI.WidgetSetBaseData("RMG5Frame6", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG5Frame6", "RMG5F6Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F6Text", 0, 0, 112, 20)
XGUIEng.ShowWidget("RMG5F6Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F6Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F6Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG5F6Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG5F6Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F6Text", 0)
XGUIEng.SetText("RMG5F6Text", "@center Eisenhaufen", 1)
XGUIEng.SetTextColor("RMG5F6Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F6Text", true)
XGUIEng.SetLinesToPrint("RMG5F6Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG5F6Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG5Frame6", "RMG5F6Value1", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F6Value1", 4, 22, 24, 16)
XGUIEng.ShowWidget("RMG5F6Value1", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F6Value1", 0, false, false)
XGUIEng.DisableButton("RMG5F6Value1", 0)
XGUIEng.HighLightButton("RMG5F6Value1", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG5F6Value1", function() EMS.GL.ActivateInput("RMG_AmountIronPile") end)
CppLogic.UI.ButtonSetShortcutString("RMG5F6Value1", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F6Value1", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F6Value1", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F6Value1", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F6Value1", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F6Value1", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F6Value1", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F6Value1", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F6Value1", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F6Value1", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F6Value1", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F6Value1", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F6Value1", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F6Value1", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F6Value1", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F6Value1", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG5F6Value1", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG5F6Value1", function() EMS.GL.UpdateTooltip("RMG_AmountIronPile") end)
CppLogic.UI.WidgetSetTooltipString("RMG5F6Value1", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F6Value1", true)
CppLogic.UI.WidgetSetFont("RMG5F6Value1", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F6Value1", -5)
XGUIEng.SetText("RMG5F6Value1", "@center 4", 1)
XGUIEng.SetTextColor("RMG5F6Value1", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG5Frame6", "RMG5F6Value2", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F6Value2", 36, 22, 72, 16)
XGUIEng.ShowWidget("RMG5F6Value2", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F6Value2", 0, false, false)
XGUIEng.DisableButton("RMG5F6Value2", 0)
XGUIEng.HighLightButton("RMG5F6Value2", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG5F6Value2", function() EMS.GL.ActivateInput("RMG_ContentIronPile") end)
CppLogic.UI.ButtonSetShortcutString("RMG5F6Value2", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F6Value2", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F6Value2", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F6Value2", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F6Value2", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F6Value2", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F6Value2", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F6Value2", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F6Value2", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F6Value2", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F6Value2", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F6Value2", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F6Value2", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F6Value2", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F6Value2", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F6Value2", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG5F6Value2", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG5F6Value2", function() EMS.GL.UpdateTooltip("RMG_ContentIronPile") end)
CppLogic.UI.WidgetSetTooltipString("RMG5F6Value2", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F6Value2", true)
CppLogic.UI.WidgetSetFont("RMG5F6Value2", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F6Value2", -5)
XGUIEng.SetText("RMG5F6Value2", "@center 4000", 1)
XGUIEng.SetTextColor("RMG5F6Value2", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG5", "RMG5Frame7", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5Frame7", 4, 300, 112, 40)
XGUIEng.ShowWidget("RMG5Frame7", 1)
CppLogic.UI.WidgetSetBaseData("RMG5Frame7", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG5Frame7", "RMG5F7Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F7Text", 0, 0, 112, 20)
XGUIEng.ShowWidget("RMG5F7Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F7Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F7Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG5F7Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG5F7Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F7Text", 0)
XGUIEng.SetText("RMG5F7Text", "@center Schwefelschächte", 1)
XGUIEng.SetTextColor("RMG5F7Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F7Text", true)
XGUIEng.SetLinesToPrint("RMG5F7Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG5F7Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG5Frame7", "RMG5F7Value1", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F7Value1", 4, 22, 24, 16)
XGUIEng.ShowWidget("RMG5F7Value1", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F7Value1", 0, false, false)
XGUIEng.DisableButton("RMG5F7Value1", 0)
XGUIEng.HighLightButton("RMG5F7Value1", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG5F7Value1", function() EMS.GL.ActivateInput("RMG_AmountSulfurPit") end)
CppLogic.UI.ButtonSetShortcutString("RMG5F7Value1", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F7Value1", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F7Value1", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F7Value1", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F7Value1", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F7Value1", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F7Value1", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F7Value1", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F7Value1", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F7Value1", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F7Value1", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F7Value1", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F7Value1", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F7Value1", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F7Value1", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F7Value1", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG5F7Value1", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG5F7Value1", function() EMS.GL.UpdateTooltip("RMG_AmountSulfurPit") end)
CppLogic.UI.WidgetSetTooltipString("RMG5F7Value1", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F7Value1", true)
CppLogic.UI.WidgetSetFont("RMG5F7Value1", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F7Value1", -5)
XGUIEng.SetText("RMG5F7Value1", "@center 2", 1)
XGUIEng.SetTextColor("RMG5F7Value1", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG5Frame7", "RMG5F7Value2", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F7Value2", 36, 22, 72, 16)
XGUIEng.ShowWidget("RMG5F7Value2", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F7Value2", 0, false, false)
XGUIEng.DisableButton("RMG5F7Value2", 0)
XGUIEng.HighLightButton("RMG5F7Value2", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG5F7Value2", function() EMS.GL.ActivateInput("RMG_ContentSulfurPit") end)
CppLogic.UI.ButtonSetShortcutString("RMG5F7Value2", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F7Value2", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F7Value2", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F7Value2", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F7Value2", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F7Value2", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F7Value2", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F7Value2", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F7Value2", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F7Value2", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F7Value2", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F7Value2", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F7Value2", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F7Value2", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F7Value2", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F7Value2", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG5F7Value2", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG5F7Value2", function() EMS.GL.UpdateTooltip("RMG_ContentSulfurPit") end)
CppLogic.UI.WidgetSetTooltipString("RMG5F7Value2", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F7Value2", true)
CppLogic.UI.WidgetSetFont("RMG5F7Value2", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F7Value2", -5)
XGUIEng.SetText("RMG5F7Value2", "@center 50000", 1)
XGUIEng.SetTextColor("RMG5F7Value2", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateContainerWidgetChild("RMG5", "RMG5Frame8", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5Frame8", 4, 350, 112, 40)
XGUIEng.ShowWidget("RMG5Frame8", 1)
CppLogic.UI.WidgetSetBaseData("RMG5Frame8", 0, false, false)
CppLogic.UI.ContainerWidgetCreateStaticTextWidgetChild("RMG5Frame8", "RMG5F8Text", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F8Text", 0, 0, 112, 20)
XGUIEng.ShowWidget("RMG5F8Text", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F8Text", 0, false, false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F8Text", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialColor("RMG5F8Text", 0, 255, 255, 255, 0)
CppLogic.UI.WidgetSetFont("RMG5F8Text", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F8Text", 0)
XGUIEng.SetText("RMG5F8Text", "@center Schwefelhaufen", 1)
XGUIEng.SetTextColor("RMG5F8Text", 255, 255, 255, 255)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F8Text", true)
XGUIEng.SetLinesToPrint("RMG5F8Text", 0, 0)
CppLogic.UI.StaticTextWidgetSetLineDistanceFactor("RMG5F8Text", 0)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG5Frame8", "RMG5F8Value1", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F8Value1", 4, 22, 24, 16)
XGUIEng.ShowWidget("RMG5F8Value1", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F8Value1", 0, false, false)
XGUIEng.DisableButton("RMG5F8Value1", 0)
XGUIEng.HighLightButton("RMG5F8Value1", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG5F8Value1", function() EMS.GL.ActivateInput("RMG_AmountSulfurPile") end)
CppLogic.UI.ButtonSetShortcutString("RMG5F8Value1", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F8Value1", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F8Value1", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F8Value1", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F8Value1", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F8Value1", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F8Value1", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F8Value1", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F8Value1", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F8Value1", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F8Value1", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F8Value1", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F8Value1", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F8Value1", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F8Value1", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F8Value1", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG5F8Value1", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG5F8Value1", function() EMS.GL.UpdateTooltip("RMG_AmountSulfurPile") end)
CppLogic.UI.WidgetSetTooltipString("RMG5F8Value1", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F8Value1", true)
CppLogic.UI.WidgetSetFont("RMG5F8Value1", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F8Value1", -5)
XGUIEng.SetText("RMG5F8Value1", "@center 4", 1)
XGUIEng.SetTextColor("RMG5F8Value1", 255, 255, 255, 255)
CppLogic.UI.ContainerWidgetCreateTextButtonWidgetChild("RMG5Frame8", "RMG5F8Value2", nil)
CppLogic.UI.WidgetSetPositionAndSize("RMG5F8Value2", 36, 22, 72, 16)
XGUIEng.ShowWidget("RMG5F8Value2", 1)
CppLogic.UI.WidgetSetBaseData("RMG5F8Value2", 0, false, false)
XGUIEng.DisableButton("RMG5F8Value2", 0)
XGUIEng.HighLightButton("RMG5F8Value2", 0)
CppLogic.UI.ButtonOverrideActionFunc("RMG5F8Value2", function() EMS.GL.ActivateInput("RMG_ContentSulfurPile") end)
CppLogic.UI.ButtonSetShortcutString("RMG5F8Value2", "New Button", false)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F8Value2", 0, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F8Value2", 0, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F8Value2", 0, 255, 255, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F8Value2", 1, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F8Value2", 1, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F8Value2", 1, 5, 228, 255, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F8Value2", 2, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F8Value2", 2, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F8Value2", 2, 252, 255, 7, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F8Value2", 3, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F8Value2", 3, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F8Value2", 3, 55, 55, 55, 255)
CppLogic.UI.WidgetMaterialSetTextureCoordinates("RMG5F8Value2", 4, 0, 0, 1, 1)
XGUIEng.SetMaterialTexture("RMG5F8Value2", 4, "graphics\\textures\\gui\\window_bg112x32.png")
XGUIEng.SetMaterialColor("RMG5F8Value2", 4, 255, 254, 190, 255)
CppLogic.UI.WidgetSetTooltipData("RMG5F8Value2", "EMSTooltip", true, true)
CppLogic.UI.WidgetOverrideTooltipFunc("RMG5F8Value2", function() EMS.GL.UpdateTooltip("RMG_ContentSulfurPile") end)
CppLogic.UI.WidgetSetTooltipString("RMG5F8Value2", "New Button", false)
CppLogic.UI.WidgetSetUpdateManualFlag("RMG5F8Value2", true)
CppLogic.UI.WidgetSetFont("RMG5F8Value2", "data\\menu\\fonts\\standard12.met")
CppLogic.UI.WidgetSetStringFrameDistance("RMG5F8Value2", -5)
XGUIEng.SetText("RMG5F8Value2", "@center 4000", 1)
XGUIEng.SetTextColor("RMG5F8Value2", 255, 255, 255, 255)]]

-- ************************************************************************************************ --
-- *	Seed
-- *

EMS.RD.Rules.RMG_Seed = EMS.T.CopyTable(EMS.RD.Templates.StdRule);

function EMS.RD.Rules.RMG_Seed:SetValue(_value)
	EMS.RD.Rules.PredefinedRuleset:SoftCustomize()
	if _value < 0 or _value >= 1000000000 then
		--self.value = 0
		return
	end
	self.value = _value
end

function EMS.RD.Rules.RMG_Seed:GetTitle()
	return "Seed"--EMS.L.RMG_Seed
end

function EMS.RD.Rules.RMG_Seed:GetDescription()
	return "Legt den Seed zur Generierung der Karte fest. @cr @cr @color:51,204,255,255 HINWEIS: @color:255,255,255,255 Der Seed wirkt sich nur auf das Gelände aus. Entities können variieren, da der Server einen eigenen Seed für Zufallszahlen setzt."
end

-- ************************************************************************************************ --
-- *	GenerateRivers ( TeamBorders )
-- *

EMS.RD.Rules.RMG_GenerateRivers = EMS.T.CopyTable(EMS.RD.Templates.StdRule);

function EMS.RD.Rules.RMG_GenerateRivers:GetTitle()
	return "Team Abgrenzung"
end

function EMS.RD.Rules.RMG_GenerateRivers:GetDescription()
	return "Legt fest, wie rivalisierende Teams räumlich von einander getrennt werden sollen. @cr @cr Zäune - Tore können zusätzlich konfiguriert werden. Diese Öffnen sich zum Ende des Waffenstillstands. @cr Flüsse - Straßen sollten in diesem Fall auch aktiviert sein, da die Flüsse sonst nur im Winter zu überqueren sind. Bis zum Ende des Waffenstillstands ist der Bau von Brücken verboten. @cr keine - Die Karte ist für jeden Spieler gleichermaßen zugänglich."
end

function EMS.RD.Rules.RMG_GenerateRivers:SetValue(_value)
	EMS.RD.Rules.PredefinedRuleset:SoftCustomize()
	-- incompatible with random player location
	if EMS.RD.Rules.RMG_RandomPlayerPosition.value == 1 then
		return
	end

	if _value < 1 then
		_value = table.getn(RandomMapGenerator.TeamBorderTypes)
	elseif _value > table.getn(RandomMapGenerator.TeamBorderTypes) then
		_value = 1
	end
	self.value = _value
	
	XGUIEng.ShowWidget("RMG1Frame3a", RandomMapGenerator.TeamBorderTypes[self.value].gate)
	XGUIEng.ShowWidget("RMG1Frame3b", RandomMapGenerator.TeamBorderTypes[self.value].gate)
end

function EMS.RD.Rules.RMG_GenerateRivers:GetRepresentative()
	return RandomMapGenerator.TeamBorderTypes[self.value].representative or RandomMapGenerator.TeamBorderTypes[self.value].id
end

-- ************************************************************************************************ --
-- *	GateLayout
-- *

EMS.RD.Rules.RMG_GateLayout = EMS.T.CopyTable(EMS.RD.Templates.StdRule);

function EMS.RD.Rules.RMG_GateLayout:GetTitle()
	return "Tor Position"
end

function EMS.RD.Rules.RMG_GateLayout:GetDescription()
	return "Legt die Position fest, an der Tore erstellt werden sollen. @cr Ihr habt folgende Optionen: @cr - je Spieler:  Ein kleineres Tor für jeden Spieler @cr - je Team: Ein größeres Tor je Team @cr @cr @color:51,204,255,255 HINWEIS: @color:255,255,255,255 In der Kartenmitte befindet sich ein Kreis aus Zäunen, in dem die Tore generieret werden. Das Areal im Kreis ist neutraler Boden und bis zum Ende des Waffenstillstands nicht erreichbar."
end

function EMS.RD.Rules.RMG_GateLayout:SetValue(_value)
	EMS.RD.Rules.PredefinedRuleset:SoftCustomize()
	if _value < 1 then
		_value = table.getn(RandomMapGenerator.GateLayouts)
	elseif _value > table.getn(RandomMapGenerator.GateLayouts) then
		_value = 1
	end
	self.value = _value
end

function EMS.RD.Rules.RMG_GateLayout:GetRepresentative()
	return RandomMapGenerator.GateLayouts[self.value].representative or RandomMapGenerator.GateLayouts[self.value].id
end

-- ************************************************************************************************ --
-- *	GateSize
-- *

EMS.RD.Rules.RMG_GateSize = EMS.T.CopyTable(EMS.RD.Templates.StdRule);

function EMS.RD.Rules.RMG_GateSize:GetTitle()
	return "Tor Größe"
end

function EMS.RD.Rules.RMG_GateSize:GetDescription()
	return "Legt die Größe der Tore fest. @cr @cr @color:51,204,255,255 HINWEIS: @color:255,255,255,255 In der Kartenmitte befindet sich ein Kreis aus Zäunen, in dem die Tore generieret werden. Das Areal im Kreis ist neutraler Boden und bis zum Ende des Waffenstillstands nicht erreichbar."
end

function EMS.RD.Rules.RMG_GateSize:SetValue(_value)
	EMS.RD.Rules.PredefinedRuleset:SoftCustomize()
	if _value < 1 then
		_value = table.getn(RandomMapGenerator.GateSizes)
	elseif _value > table.getn(RandomMapGenerator.GateSizes) then
		_value = 1
	end
	self.value = _value
end

function EMS.RD.Rules.RMG_GateSize:GetRepresentative()
	return RandomMapGenerator.GateSizes[self.value].representative or RandomMapGenerator.GateSizes[self.value].id
end

-- ************************************************************************************************ --
-- *	GenerateRoads
-- *

EMS.RD.Rules.RMG_GenerateRoads = EMS.T.CopyTable(EMS.RD.Templates.StdBool);
EMS.RD.Rules.RMG_GenerateRoads.Representatives = {[0] = "@center aus", [1] = "@center ein",};

function EMS.RD.Rules.RMG_GenerateRoads:GetTitle()
	return "Straßen"
end

function EMS.RD.Rules.RMG_GenerateRoads:GetDescription()
	return "Legt fest, ob Straßen zu nahegelegenen Spielern generiert werden sollen. @cr @cr @color:51,204,255,255 TIPP: @color:255,255,255,255 Wenn ihr bei Teambegrenzung die Option Flüsse wählt, werden Brücken an den Stellen generiert, an denen sich Starßen und Flüsse kreuzen."
end

-- ************************************************************************************************ --
-- *	LandscapeSet
-- *

EMS.RD.Rules.RMG_LandscapeSet = EMS.T.CopyTable(EMS.RD.Templates.StdRule);

function EMS.RD.Rules.RMG_LandscapeSet:GetTitle()
	return "Landschaftsset"
end

function EMS.RD.Rules.RMG_LandscapeSet:GetDescription()
	return "Legt das Landschaftsset fest."
end

function EMS.RD.Rules.RMG_LandscapeSet:SetValue(_value)
	EMS.RD.Rules.PredefinedRuleset:SoftCustomize()
	if _value < 1 then
		_value = table.getn(RandomMapGenerator.LandscapeSetKeys)
	elseif _value > table.getn(RandomMapGenerator.LandscapeSetKeys) then
		_value = 1
	end
	self.value = _value
	
	RandomMapGenerator.SetupThresholdsNormal()
	if RandomMapGenerator.LandscapeSetKeys[self.value].func then
		RandomMapGenerator.LandscapeSetKeys[self.value].func()
	end
end

function EMS.RD.Rules.RMG_LandscapeSet:Evaluate()
	if RandomMapGenerator.LandscapeSetKeys[self.value].eval then
		RandomMapGenerator.LandscapeSetKeys[self.value].eval()
	end
end
	
function EMS.RD.Rules.RMG_LandscapeSet:GetRepresentative()
	return RandomMapGenerator.LandscapeSetKeys[self.value].representative or RandomMapGenerator.LandscapeSetKeys[self.value].id
end

-- ************************************************************************************************ --
-- *	MirrorMap
-- *

EMS.RD.Rules.RMG_MirrorMap = EMS.T.CopyTable(EMS.RD.Templates.StdBool);
EMS.RD.Rules.RMG_MirrorMap.Representatives = {[0] = "@center aus", [1] = "@center ein",};

function EMS.RD.Rules.RMG_MirrorMap:SetValue(_value)
	EMS.RD.Rules.PredefinedRuleset:SoftCustomize()
	-- incompatible with random player location
	if EMS.RD.Rules.RMG_RandomPlayerPosition.value == 1 then
		return
	end
	self.value = _value
end

function EMS.RD.Rules.RMG_MirrorMap:GetTitle()
	return "Kartenspiegelung"
end

function EMS.RD.Rules.RMG_MirrorMap:GetDescription()
	return "Die Kartenspiegelung erfolgt punktsymetrisch und funktioniert für jede Anzahl von Spielern und Teams. Jedes Zweite Segment wird in der Mitte noch einmal achsengespiegelt, so dass die Kanten aneinander passen."
end

-- ************************************************************************************************ --
-- *	PlayerPosition
-- *

EMS.RD.Rules.RMG_RandomPlayerPosition = EMS.T.CopyTable(EMS.RD.Templates.StdBool);
EMS.RD.Rules.RMG_RandomPlayerPosition.Representatives = {[0] = "@center Kreis", [1] = "@center zufällig",};

function EMS.RD.Rules.RMG_RandomPlayerPosition:SetValue(_value)
	EMS.RD.Rules.PredefinedRuleset:SoftCustomize()
	if _value == 1 then
		EMS.GL.SetValueSynced("RMG_GenerateRivers", 1)
		EMS.GL.SetValueSynced("RMG_MirrorMap", 0)
	end
	self.value = _value
end

function EMS.RD.Rules.RMG_RandomPlayerPosition:GetTitle()
	return "Startposition"
end

function EMS.RD.Rules.RMG_RandomPlayerPosition:GetDescription()
	return "Legt fest ob die Startpositionen der Spieler einen Kreis bilden, oder alle zufällig auf der Karte verteilt werden. @cr @cr @color:255,204,51,255 VORSICHT: @color:255,255,255,255 Bei zufälliger Verteilung sind Karte spiegeln und Team Abgrenzung nicht verfügbar. @cr @cr @color:255,102,51,255 WARNUNG: @color:255,255,255,255 Bei zufälliger Verteilung kann es Vorkommen, dass nicht genug Platz für alle Stukturen wie Rohstoffschächte vorhanden ist. Der Generator wird euch dies mitteilen. @cr Außerdem kann es in seltenen Fällen Vorkommen, dass eure Burgen ineinander stehen. @cr Bei Problemen könnt ihr es mit einem anderen Seed versuchen."
end

-- ************************************************************************************************ --
-- *	TerrainBaseHeight
-- *

EMS.RD.Rules.RMG_TerrainBaseHeight = EMS.T.CopyTable(EMS.RD.Templates.StdRule);

function EMS.RD.Rules.RMG_TerrainBaseHeight:GetTitle()
	return "Gelände-Basishöhe"
end

function EMS.RD.Rules.RMG_TerrainBaseHeight:GetDescription()
	return "Legt die Höhe der ebenen Flächen fest. @cr @cr @color:51,204,255,255 TIPP: @color:255,255,255,255 Dieser Wert hat allein keinen Einfluss auf die Karte. @cr Höhere Werte ermöglichen tiefe Schluchten in Kombination mit einer hohen Amplitude."
end

-- ************************************************************************************************ --
-- *	WaterBaseHeight
-- *

EMS.RD.Rules.RMG_WaterBaseHeight = EMS.T.CopyTable(EMS.RD.Templates.StdRule);

function EMS.RD.Rules.RMG_WaterBaseHeight:GetTitle()
	return "Wasser-Basishöhe"
end

function EMS.RD.Rules.RMG_WaterBaseHeight:GetDescription()
	return "Legt die Höhe von natürlichen Gewässern fest. @cr @cr @color:255,204,51,255 VORSICHT: @color:255,255,255,255 Die Wasser-Basishöhe sollte nicht über der Gelände-Basishöhe liegen, da die ebenen Flächen sonst Unterwasser liegen."
end

-- ************************************************************************************************ --
-- *	NoiseFactorZ
-- *

EMS.RD.Rules.RMG_NoiseFactorZ = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_NoiseFactorZ:GetTitle()
	return "Amplitude"
end

function EMS.RD.Rules.RMG_NoiseFactorZ:GetDescription()
	return "Dieser Wert gibt die Stärke von Erhebungen und Vertifungen an. Er wirkt sich nur auf die Z Achse aus."
end

function EMS.RD.Rules.RMG_NoiseFactorZ:SetValue(_value)
	self.value = _value
end

function EMS.RD.Rules.RMG_NoiseFactorZ:GetRepresentative()
	return self.value .."%"
end

-- ************************************************************************************************ --
-- *	NoiseFactorXY
-- *

EMS.RD.Rules.RMG_NoiseFactorXY = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_NoiseFactorXY:GetTitle()
	return "Maßstab"
end

function EMS.RD.Rules.RMG_NoiseFactorXY:GetDescription()
	return "Dieser Wert wirkt wie ein Zoom. Er wirkt sich nur auf die X und Y Achse aus. @cr @cr @color:51,204,255,255 TIPP: @color:255,255,255,255 @cr Kleinere Werte zoomen heran: Berge, Seen und Ebenen nehmen mehr Fläche ein. Abstände werden größer. @cr Größere Werte zoomer heraus: Berge, Seen und Ebenen nehmen weniger Fläche ein. Abstände werden kleiner. @cr @cr @color:255,204,51,255 VORSICHT: @color:255,255,255,255 Dieser Parameter hat sehr großen Einfluss auf die Karte!"
end

function EMS.RD.Rules.RMG_NoiseFactorXY:SetValue(_value)
	self.value = _value
end

function EMS.RD.Rules.RMG_NoiseFactorXY:GetRepresentative()
	return self.value .. "%"
end

-- ************************************************************************************************ --
-- *	ThresholdPike
-- *

EMS.RD.Rules.RMG_ThresholdPike = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ThresholdPike:SetValue(_value)
	if _value > 1000 or _value < -1000 then
		return
	end
	self.value = _value
end

function EMS.RD.Rules.RMG_ThresholdPike:GetTitle()
	return "Gipfel"
end

function EMS.RD.Rules.RMG_ThresholdPike:GetDescription()
	return EMS.GL.GetThresholdDescription("Berggipfel")
end

-- ************************************************************************************************ --
-- *	ThresholdMountain
-- *

EMS.RD.Rules.RMG_ThresholdMountain = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ThresholdMountain:SetValue(_value)
	if _value > 1000 or _value < -1000 then
		return
	end
	self.value = _value
end

function EMS.RD.Rules.RMG_ThresholdMountain:GetTitle()
	return "Berg"
end

function EMS.RD.Rules.RMG_ThresholdMountain:GetDescription()
	return EMS.GL.GetThresholdDescription("Berge")
end

-- ************************************************************************************************ --
-- *	ThresholdHill
-- *

EMS.RD.Rules.RMG_ThresholdHill = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ThresholdHill:SetValue(_value)
	if _value > 1000 or _value < -1000 then
		return
	end
	self.value = _value
end

function EMS.RD.Rules.RMG_ThresholdHill:GetTitle()
	return "Hügel"
end

function EMS.RD.Rules.RMG_ThresholdHill:GetDescription()
	return EMS.GL.GetThresholdDescription("Hügel")
end

-- ************************************************************************************************ --
-- *	ThresholdSea
-- *

EMS.RD.Rules.RMG_ThresholdSea = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ThresholdSea:SetValue(_value)
	if _value > 1000 or _value < -1000 then
		return
	end
	self.value = _value
end

function EMS.RD.Rules.RMG_ThresholdSea:GetTitle()
	return "Meer"
end

function EMS.RD.Rules.RMG_ThresholdSea:GetDescription()
	return EMS.GL.GetThresholdDescription("Meere")
end

-- ************************************************************************************************ --
-- *	ThresholdLake
-- *

EMS.RD.Rules.RMG_ThresholdLake = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ThresholdLake:SetValue(_value)
	if _value > 1000 or _value < -1000 then
		return
	end
	self.value = _value
end

function EMS.RD.Rules.RMG_ThresholdLake:GetTitle()
	return "See"
end

function EMS.RD.Rules.RMG_ThresholdLake:GetDescription()
	return EMS.GL.GetThresholdDescription("Seen")
end

-- ************************************************************************************************ --
-- *	ThresholdCoast
-- *

EMS.RD.Rules.RMG_ThresholdCoast = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ThresholdCoast:SetValue(_value)
	if _value > 1000 or _value < -1000 then
		return
	end
	self.value = _value
end

function EMS.RD.Rules.RMG_ThresholdCoast:GetTitle()
	return "Küste"
end

function EMS.RD.Rules.RMG_ThresholdCoast:GetDescription()
	return EMS.GL.GetThresholdDescription("Küsten")
end

-- ************************************************************************************************ --
-- *	ThresholdForest
-- *

EMS.RD.Rules.RMG_ThresholdForest = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ThresholdForest:SetValue(_value)
	if _value > 1000 or _value < -1000 then
		return
	end
	self.value = _value
end

function EMS.RD.Rules.RMG_ThresholdForest:GetTitle()
	return "Wald"
end

function EMS.RD.Rules.RMG_ThresholdForest:GetDescription()
	return EMS.GL.GetThresholdDescription("Wälder")
end

-- ************************************************************************************************ --
-- *	ThresholdMeadow
-- *

EMS.RD.Rules.RMG_ThresholdMeadow = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ThresholdMeadow:SetValue(_value)
	if _value > 1000 or _value < -1000 then
		return
	end
	self.value = _value
end

function EMS.RD.Rules.RMG_ThresholdMeadow:GetTitle()
	return "Wiese"
end

function EMS.RD.Rules.RMG_ThresholdMeadow:GetDescription()
	return EMS.GL.GetThresholdDescription("Wiesen")
end

-- ************************************************************************************************ --
-- *	ThresholdFlatland
-- *

EMS.RD.Rules.RMG_ThresholdFlatland = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ThresholdFlatland:SetValue(_value)
	if _value > 1000 or _value < 0 then
		return
	end
	self.value = _value
end

function EMS.RD.Rules.RMG_ThresholdFlatland:GetTitle()
	return "Flachland"
end

function EMS.RD.Rules.RMG_ThresholdFlatland:GetDescription()
	return "Legt fest, zwischen welchen Werten die Geländehöhe geglättet werden soll. @cr @cr @color:51,204,255,255 HINWEIS: @color:255,255,255,255 Der linke Wert muss negativ sein, der rechte positiv."
end

-- ************************************************************************************************ --
-- *	ThresholdLowForest
-- *

EMS.RD.Rules.RMG_ThresholdLowForest = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ThresholdLowForest:SetValue(_value)
	if _value > 1000 or _value < -1000 then
		return
	end
	self.value = _value
end

function EMS.RD.Rules.RMG_ThresholdLowForest:GetTitle()
	return "Wald"
end

function EMS.RD.Rules.RMG_ThresholdLowForest:GetDescription()
	return EMS.GL.GetThresholdDescription("Wälder")
end

-- ************************************************************************************************ --
-- *	ThresholdLowMeadow
-- *

EMS.RD.Rules.RMG_ThresholdLowMeadow = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ThresholdLowMeadow:SetValue(_value)
	if _value > 1000 or _value < -1000 then
		return
	end
	self.value = _value
end

function EMS.RD.Rules.RMG_ThresholdLowMeadow:GetTitle()
	return "Wiese"
end

function EMS.RD.Rules.RMG_ThresholdLowMeadow:GetDescription()
	return EMS.GL.GetThresholdDescription("Wiesen")
end

-- ************************************************************************************************ --
-- *	ThresholdLowFlatland
-- *

EMS.RD.Rules.RMG_ThresholdLowFlatland = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ThresholdLowFlatland:SetValue(_value)
	if _value > 0 or _value < -1000 then
		return
	end
	self.value = _value
end

function EMS.RD.Rules.RMG_ThresholdLowFlatland:GetTitle()
	return "Flachland"
end

function EMS.RD.Rules.RMG_ThresholdLowFlatland:GetDescription()
	return "Legt fest, zwischen welchen Werten die Geländehöhe geglättet werden soll. @cr @cr @color:51,204,255,255 HINWEIS: @color:255,255,255,255 Der linke Wert muss negativ sein, der rechte positiv."
end

-- ************************************************************************************************ --
-- *	ThresholdRoad
-- *

EMS.RD.Rules.RMG_ThresholdRoad = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ThresholdRoad:SetValue(_value)
	if _value > 1000 or _value < -1000 then
		return
	end
	self.value = _value
end

function EMS.RD.Rules.RMG_ThresholdRoad:GetTitle()
	return "Straße"
end

function EMS.RD.Rules.RMG_ThresholdRoad:GetDescription()
	return "Legt fest, auf welchem Wert Straßen generiert werden sollen. @cr @cr @color:51,204,255,255 TIPP: @color:255,255,255,255 Wenn ihr wollt, dass die Straßen durch Wälder führen, müsst ihr einen Wert zwischen Wald und Hügel oder zwischen Wald und Küste wählen. @cr Die Option Straßen muss aktiviert sein."
end

-- ************************************************************************************************ --
-- *	ThresholdHighForest
-- *

EMS.RD.Rules.RMG_ThresholdHighForest = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ThresholdHighForest:SetValue(_value)
	if _value > 1000 or _value < -1000 then
		return
	end
	self.value = _value
end

function EMS.RD.Rules.RMG_ThresholdHighForest:GetTitle()
	return "Hochwald"
end

function EMS.RD.Rules.RMG_ThresholdHighForest:GetDescription()
	return EMS.GL.GetThresholdDescription("Hochwälder")
end

-- ************************************************************************************************ --
-- *	ThresholdHighMeadow
-- *

EMS.RD.Rules.RMG_ThresholdHighMeadow = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ThresholdHighMeadow:SetValue(_value)
	if _value > 1000 or _value < -1000 then
		return
	end
	self.value = _value
end

function EMS.RD.Rules.RMG_ThresholdHighMeadow:GetTitle()
	return "Hochwiese"
end

function EMS.RD.Rules.RMG_ThresholdHighMeadow:GetDescription()
	return EMS.GL.GetThresholdDescription("Hochwiesen")
end

-- ************************************************************************************************ --
-- *	ThresholdPlateau
-- *

EMS.RD.Rules.RMG_ThresholdPlateau = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ThresholdPlateau:SetValue(_value)
	if _value > 1000 or _value < -1000 then
		return
	end
	self.value = _value
end

function EMS.RD.Rules.RMG_ThresholdPlateau:GetTitle()
	return "Hochebene"
end

function EMS.RD.Rules.RMG_ThresholdPlateau:GetDescription()
	return "Dieser Wert verhält sich ähnlich wie die Option Flachland, nur dass die Geländehöhe oberhalb dieses Werts geglättet wird. @cr @cr @color:51,204,255,255 TIPP: @color:255,255,255,255 Setzt diesen Wert auf 1000 um Hochebenen zu deaktivieren."
end

-- ************************************************************************************************ --
-- *	Amount Clay Pit
-- *

EMS.RD.Rules.RMG_AmountClayPit = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_AmountClayPit:GetTitle()
	return "Anzahl"
end

function EMS.RD.Rules.RMG_AmountClayPit:GetDescription()
	return EMS.GL.GetAmountDescription("Lehmschächten")
end

-- ************************************************************************************************ --
-- *	Content Clay Pit
-- *

EMS.RD.Rules.RMG_ContentClayPit = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ContentClayPit:GetTitle()
	return "Rohstoffmenge"
end

function EMS.RD.Rules.RMG_ContentClayPit:GetDescription()
	return EMS.GL.GetContentDescription("Lehmschächten")
end

-- ************************************************************************************************ --
-- *	Amount Clay Pile
-- *

EMS.RD.Rules.RMG_AmountClayPile = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_AmountClayPile:GetTitle()
	return "Anzahl"
end

function EMS.RD.Rules.RMG_AmountClayPile:GetDescription()
	return EMS.GL.GetAmountDescription("Lehmhaufen")
end

-- ************************************************************************************************ --
-- *	Content Clay Pile
-- *

EMS.RD.Rules.RMG_ContentClayPile = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ContentClayPile:GetTitle()
	return "Rohstoffmenge"
end

function EMS.RD.Rules.RMG_ContentClayPile:GetDescription()
	return EMS.GL.GetContentDescription("Lehmhaufen")
end

-- ************************************************************************************************ --
-- *	Amount Stone Pit
-- *

EMS.RD.Rules.RMG_AmountStonePit = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_AmountStonePit:GetTitle()
	return "Anzahl"
end

function EMS.RD.Rules.RMG_AmountStonePit:GetDescription()
	return EMS.GL.GetAmountDescription("Steinbrüchen")
end

-- ************************************************************************************************ --
-- *	Content Stone Pit
-- *

EMS.RD.Rules.RMG_ContentStonePit = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ContentStonePit:GetTitle()
	return "Rohstoffmenge"
end

function EMS.RD.Rules.RMG_ContentStonePit:GetDescription()
	return EMS.GL.GetContentDescription("Steinbrüchen")
end

-- ************************************************************************************************ --
-- *	Amount Stone Pile
-- *

EMS.RD.Rules.RMG_AmountStonePile = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_AmountStonePile:GetTitle()
	return "Anzahl"
end

function EMS.RD.Rules.RMG_AmountStonePile:GetDescription()
	return EMS.GL.GetAmountDescription("Steinhaufen")
end

-- ************************************************************************************************ --
-- *	Content Stone Pile
-- *

EMS.RD.Rules.RMG_ContentStonePile = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ContentStonePile:GetTitle()
	return "Rohstoffmenge"
end

function EMS.RD.Rules.RMG_ContentStonePile:GetDescription()
	return EMS.GL.GetContentDescription("Steinhaufen")
end

-- ************************************************************************************************ --
-- *	Amount Iron Pit
-- *

EMS.RD.Rules.RMG_AmountIronPit = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_AmountIronPit:GetTitle()
	return "Anzahl"
end

function EMS.RD.Rules.RMG_AmountIronPit:GetDescription()
	return EMS.GL.GetAmountDescription("Eisenschächten")
end

-- ************************************************************************************************ --
-- *	Content Iron Pit
-- *

EMS.RD.Rules.RMG_ContentIronPit = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ContentIronPit:GetTitle()
	return "Rohstoffmenge"
end

function EMS.RD.Rules.RMG_ContentIronPit:GetDescription()
	return EMS.GL.GetContentDescription("Eisenschächten")
end

-- ************************************************************************************************ --
-- *	Amount Iron Pile
-- *

EMS.RD.Rules.RMG_AmountIronPile = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_AmountIronPile:GetTitle()
	return "Anzahl"
end

function EMS.RD.Rules.RMG_AmountIronPile:GetDescription()
	return EMS.GL.GetAmountDescription("Eisenhaufen")
end

-- ************************************************************************************************ --
-- *	Content Iron Pile
-- *

EMS.RD.Rules.RMG_ContentIronPile = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ContentIronPile:GetTitle()
	return "Rohstoffmenge"
end

function EMS.RD.Rules.RMG_ContentIronPile:GetDescription()
	return EMS.GL.GetContentDescription("Eisenhaufen")
end

-- ************************************************************************************************ --
-- *	Amount Sulfur Pit
-- *

EMS.RD.Rules.RMG_AmountSulfurPit = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_AmountSulfurPit:GetTitle()
	return "Anzahl"
end

function EMS.RD.Rules.RMG_AmountSulfurPit:GetDescription()
	return EMS.GL.GetAmountDescription("Schwefelschächten")
end

-- ************************************************************************************************ --
-- *	Content Sulfur Pit
-- *

EMS.RD.Rules.RMG_ContentSulfurPit = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ContentSulfurPit:GetTitle()
	return "Rohstoffmenge"
end

function EMS.RD.Rules.RMG_ContentSulfurPit:GetDescription()
	return EMS.GL.GetContentDescription("Schwefelschächten")
end

-- ************************************************************************************************ --
-- *	Amount Sulfur Pile
-- *

EMS.RD.Rules.RMG_AmountSulfurPile = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_AmountSulfurPile:GetTitle()
	return "Anzahl"
end

function EMS.RD.Rules.RMG_AmountSulfurPile:GetDescription()
	return EMS.GL.GetAmountDescription("Schwefelhaufen")
end

-- ************************************************************************************************ --
-- *	Content Sulfur Pile
-- *

EMS.RD.Rules.RMG_ContentSulfurPile = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_ContentSulfurPile:GetTitle()
	return "Rohstoffmenge"
end

function EMS.RD.Rules.RMG_ContentSulfurPile:GetDescription()
	return EMS.GL.GetContentDescription("Schwefelhaufen")
end

-- ************************************************************************************************ --
-- *	Amount Village Center
-- *

EMS.RD.Rules.RMG_AmountVC = EMS.T.CopyTable(EMS.RD.Templates.StdRule);
	
function EMS.RD.Rules.RMG_AmountVC:GetTitle()
	return "Anzahl"
end

function EMS.RD.Rules.RMG_AmountVC:GetDescription()
	return "Legt die Anzahl an Siedlungsplätzen je Spieler fest."
end

function EMS.RD.Rules.RMG_AmountVC:SetValue(_value)
	if _value > 0 then
		self.value = _value
	end
end

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function EMS.GL.GetThresholdDescription(_string)
	return "Legt fest, ab welchem Noise Wert ".._string.." generiert werden. @cr @cr @color:51,204,255,255 TIPP: @color:255,255,255,255 Werte zwischen -1000 und 1000 sind möglich. Je größer der Abstand zum Wert darüber, desto mehr Fläche wird dieses Biom einnehmen. @cr Die Werte auf der linken Seite der Tabelle sollten nach unten hin größer werden, auf der rechten Seite kleiner. Ansonsten werden entsprechende Biome nicht generiert. @cr Die Optionen Flachland und Hochebenen gehören nicht dazu. Diesen Werten glätten die Terrainhöhe. @cr @cr @color:255,204,51,255 VORSICHT: @color:255,255,255,255 Wahlloses verstellen dieser Werte kann die Karte unspielbar machen."
end

function EMS.GL.GetAmountDescription(_string)
	return "Legt die Anzahl an ".._string.." je Spieler fest. @cr @cr @color:51,204,255,255 TIPP: @color:255,255,255,255 Rohstoffhaufen werden gleichmäßig in der Nähe von Schächten des gleichen Rohstofftyps verteilt."
end

function EMS.GL.GetContentDescription(_string)
	return "Legt die Anzahl an Rohstoffeinheiten in ".._string.." fest."
end

function EMS.GL.GUIUpdate_Threshold(_rule)
	local widget = EMS.GL.MapRuleToGUIWidget[_rule];
	local value = EMS.GL.GetRule(_rule):GetRepresentative();
	if math.abs(value) >= 1000 then
		value = "-";
	end
	XGUIEng.SetText(widget[1], "@center "..value);
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
	-- custom text input
	EMS.GL.CustomTextInputs["RMG_Seed"]					= CTI.New({Widget="RMG1F1Value", Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=9, Callback=EMS.GL.CustomTextInputCallback});
	
	EMS.GL.CustomTextInputs["RMG_TerrainBaseHeight"]	= CTI.New({Widget="RMG2F1Value", Before = "@center ", NumbersOnly=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_WaterBaseHeight"]		= CTI.New({Widget="RMG2F2Value", Before = "@center ", NumbersOnly=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_NoiseFactorZ"]			= CTI.New({Widget="RMG2F3Value", Before = "@center ", NumbersOnly=true, MaxLength=3, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_NoiseFactorXY"]		= CTI.New({Widget="RMG2F4Value", Before = "@center ", NumbersOnly=true, MaxLength=3, Callback=EMS.GL.CustomTextInputCallback});
	
	EMS.GL.CustomTextInputs["RMG_ThresholdPike"]		= CTI.New({Widget="RMG3F2Value",  Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdMountain"]	= CTI.New({Widget="RMG3F4Value",  Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdHill"]		= CTI.New({Widget="RMG3F6Value",  Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdForest"]		= CTI.New({Widget="RMG3F7Value2", Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdMeadow"]		= CTI.New({Widget="RMG3F8Value2", Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdFlatland"]	= CTI.New({Widget="RMG3F9Value2", Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=false, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdSea"]			= CTI.New({Widget="RMG3F1Value",  Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdLake"]		= CTI.New({Widget="RMG3F3Value",  Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdCoast"]		= CTI.New({Widget="RMG3F5Value",  Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdLowForest"]	= CTI.New({Widget="RMG3F7Value1", Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdLowMeadow"]	= CTI.New({Widget="RMG3F8Value1", Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdLowFlatland"]	= CTI.New({Widget="RMG3F9Value1", Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdRoad"]		= CTI.New({Widget="RMG3F10Value", Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	
	EMS.GL.CustomTextInputs["RMG_ThresholdHighMeadow"]	= CTI.New({Widget="RMG4F2Value1", Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdHighForest"]	= CTI.New({Widget="RMG4F3Value1", Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdPlateau"]		= CTI.New({Widget="RMG4F1Value1", Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	
	EMS.GL.CustomTextInputs["RMG_AmountClayPit"]		= CTI.New({Widget="RMG5F1Value1", Before = "@center ", NumbersOnly=true, MaxLength=1, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ContentClayPit"]		= CTI.New({Widget="RMG5F1Value2", Before = "@center ", NumbersOnly=true, MaxLength=6, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_AmountClayPile"]		= CTI.New({Widget="RMG5F2Value1", Before = "@center ", NumbersOnly=true, MaxLength=2, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ContentClayPile"]		= CTI.New({Widget="RMG5F2Value2", Before = "@center ", NumbersOnly=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_AmountStonePit"]		= CTI.New({Widget="RMG5F3Value1", Before = "@center ", NumbersOnly=true, MaxLength=1, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ContentStonePit"]		= CTI.New({Widget="RMG5F3Value2", Before = "@center ", NumbersOnly=true, MaxLength=6, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_AmountStonePile"]		= CTI.New({Widget="RMG5F4Value1", Before = "@center ", NumbersOnly=true, MaxLength=2, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ContentStonePile"]		= CTI.New({Widget="RMG5F4Value2", Before = "@center ", NumbersOnly=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_AmountIronPit"]		= CTI.New({Widget="RMG5F5Value1", Before = "@center ", NumbersOnly=true, MaxLength=1, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ContentIronPit"]		= CTI.New({Widget="RMG5F5Value2", Before = "@center ", NumbersOnly=true, MaxLength=6, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_AmountIronPile"]		= CTI.New({Widget="RMG5F6Value1", Before = "@center ", NumbersOnly=true, MaxLength=2, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ContentIronPile"]		= CTI.New({Widget="RMG5F6Value2", Before = "@center ", NumbersOnly=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_AmountSulfurPit"]		= CTI.New({Widget="RMG5F7Value1", Before = "@center ", NumbersOnly=true, MaxLength=1, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ContentSulfurPit"]		= CTI.New({Widget="RMG5F7Value2", Before = "@center ", NumbersOnly=true, MaxLength=6, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_AmountSulfurPile"]		= CTI.New({Widget="RMG5F8Value1", Before = "@center ", NumbersOnly=true, MaxLength=2, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ContentSulfurPile"]	= CTI.New({Widget="RMG5F8Value2", Before = "@center ", NumbersOnly=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	
	EMS.GL.CustomTextInputs["RMG_AmountVC"]				= CTI.New({Widget="RMG2F7Value", Before = "@center ", NumbersOnly=true, MaxLength=1, Callback=EMS.GL.CustomTextInputCallback});
	
	-- gui update
	EMS.GL.GUIUpdate["RMG_Seed"]					= EMS.GL.GUIUpdate_Number
	EMS.GL.GUIUpdate["RMG_LandscapeSet"]			= EMS.GL.GUIUpdate_Number
	EMS.GL.GUIUpdate["RMG_GenerateRivers"]			= EMS.GL.GUIUpdate_Number
	EMS.GL.GUIUpdate["RMG_GateLayout"]				= EMS.GL.GUIUpdate_Number
	EMS.GL.GUIUpdate["RMG_GateSize"]				= EMS.GL.GUIUpdate_Number
	EMS.GL.GUIUpdate["RMG_GenerateRoads"]			= EMS.GL.GUIUpdate_TextToggleButton
	EMS.GL.GUIUpdate["RMG_MirrorMap"]				= EMS.GL.GUIUpdate_TextToggleButton
	EMS.GL.GUIUpdate["RMG_RandomPlayerPosition"]			= EMS.GL.GUIUpdate_TextToggleButton
	
	EMS.GL.GUIUpdate["RMG_TerrainBaseHeight"]		= EMS.GL.GUIUpdate_Number
	EMS.GL.GUIUpdate["RMG_WaterBaseHeight"]			= EMS.GL.GUIUpdate_Number
	EMS.GL.GUIUpdate["RMG_NoiseFactorZ"]			= EMS.GL.GUIUpdate_Number
	EMS.GL.GUIUpdate["RMG_NoiseFactorXY"]			= EMS.GL.GUIUpdate_Number
	
	EMS.GL.GUIUpdate["RMG_ThresholdPike"]			= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdMountain"]		= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdHill"]			= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdForest"]			= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdMeadow"]			= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdFlatland"]		= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdSea"]			= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdLake"]			= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdCoast"]			= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdLowForest"]		= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdLowMeadow"]		= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdLowFlatland"]	= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdRoad"]			= EMS.GL.GUIUpdate_Threshold
	
	EMS.GL.GUIUpdate["RMG_ThresholdHighMeadow"]		= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdHighForest"]		= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdPlateau"]		= EMS.GL.GUIUpdate_Threshold

	EMS.GL.GUIUpdate["RMG_AmountClayPit"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_ContentClayPit"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_AmountClayPile"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_ContentClayPile"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_AmountStonePit"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_ContentStonePit"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_AmountStonePile"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_ContentStonePile"]		= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_AmountIronPit"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_ContentIronPit"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_AmountIronPile"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_ContentIronPile"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_AmountSulfurPit"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_ContentSulfurPit"]		= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_AmountSulfurPile"]		= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_ContentSulfurPile"]		= EMS.GL.GUIUpdate_Text

	EMS.GL.GUIUpdate["RMG_AmountVC"]				= EMS.GL.GUIUpdate_Text
	
	-- map rule to gui widget
	EMS.GL.MapRuleToGUIWidget["RMG_Seed"]					= {"RMG1F1Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_LandscapeSet"]			= {"RMG1F2Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_GenerateRivers"]			= {"RMG1F3Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_GateLayout"]				= {"RMG1F3aValue"}
	EMS.GL.MapRuleToGUIWidget["RMG_GateSize"]				= {"RMG1F3bValue"}
	EMS.GL.MapRuleToGUIWidget["RMG_GenerateRoads"]			= "RMG1F4Value"
	EMS.GL.MapRuleToGUIWidget["RMG_MirrorMap"]				= "RMG1F5Value"
	EMS.GL.MapRuleToGUIWidget["RMG_RandomPlayerPosition"]			= "RMG1F6Value"
	
	EMS.GL.MapRuleToGUIWidget["RMG_TerrainBaseHeight"]		= {"RMG2F1Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_WaterBaseHeight"]		= {"RMG2F2Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_NoiseFactorZ"]			= {"RMG2F3Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_NoiseFactorXY"]			= {"RMG2F4Value"}
	
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdPike"]			= {"RMG3F2Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdMountain"]		= {"RMG3F4Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdHill"]			= {"RMG3F6Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdForest"]		= {"RMG3F7Value2"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdMeadow"]		= {"RMG3F8Value2"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdFlatland"]		= {"RMG3F9Value2"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdSea"]			= {"RMG3F1Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdLake"]			= {"RMG3F3Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdCoast"]			= {"RMG3F5Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdLowForest"]		= {"RMG3F7Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdLowMeadow"]		= {"RMG3F8Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdLowFlatland"]	= {"RMG3F9Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdRoad"]			= {"RMG3F10Value"}

	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdHighMeadow"]	= {"RMG4F2Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdHighForest"]	= {"RMG4F3Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdPlateau"]		= {"RMG4F1Value1"}

	EMS.GL.MapRuleToGUIWidget["RMG_AmountClayPit"]			= {"RMG5F1Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ContentClayPit"]			= {"RMG5F1Value2"}
	EMS.GL.MapRuleToGUIWidget["RMG_AmountClayPile"]			= {"RMG5F2Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ContentClayPile"]		= {"RMG5F2Value2"}
	EMS.GL.MapRuleToGUIWidget["RMG_AmountStonePit"]			= {"RMG5F3Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ContentStonePit"]		= {"RMG5F3Value2"}
	EMS.GL.MapRuleToGUIWidget["RMG_AmountStonePile"]		= {"RMG5F4Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ContentStonePile"]		= {"RMG5F4Value2"}
	EMS.GL.MapRuleToGUIWidget["RMG_AmountIronPit"]			= {"RMG5F5Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ContentIronPit"]			= {"RMG5F5Value2"}
	EMS.GL.MapRuleToGUIWidget["RMG_AmountIronPile"]			= {"RMG5F6Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ContentIronPile"]		= {"RMG5F6Value2"}
	EMS.GL.MapRuleToGUIWidget["RMG_AmountSulfurPit"]		= {"RMG5F7Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ContentSulfurPit"]		= {"RMG5F7Value2"}
	EMS.GL.MapRuleToGUIWidget["RMG_AmountSulfurPile"]		= {"RMG5F8Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ContentSulfurPile"]		= {"RMG5F8Value2"}

	EMS.GL.MapRuleToGUIWidget["RMG_AmountVC"]				= {"RMG2F7Value"}
	
	-- map widget to rule
	EMS.GL.MapWidgetToRule["RMG1F1Value"]	= "RMG_Seed"
	EMS.GL.MapWidgetToRule["RMG1F2Value"]	= "RMG_LandscapeSet"
	EMS.GL.MapWidgetToRule["RMG1F3Value"]	= "RMG_GenerateRivers"
	EMS.GL.MapWidgetToRule["RMG1F3aValue"]	= "RMG_GateLayout"
	EMS.GL.MapWidgetToRule["RMG1F3bValue"]	= "RMG_GateSize"
	EMS.GL.MapWidgetToRule["RMG1F4Value"]	= "RMG_GenerateRoads"
	EMS.GL.MapWidgetToRule["RMG1F5Value"]	= "RMG_MirrorMap"
	EMS.GL.MapWidgetToRule["RMG1F6Value"]	= "RMG_RandomPlayerPosition"
	
	EMS.GL.MapWidgetToRule["RMG2F1Value"]	= "RMG_TerrainBaseHeight"
	EMS.GL.MapWidgetToRule["RMG2F2Value"]	= "RMG_WaterBaseHeight"
	EMS.GL.MapWidgetToRule["RMG2F3Value"]	= "RMG_NoiseFactorZ"
	EMS.GL.MapWidgetToRule["RMG2F4Value"]	= "RMG_NoiseFactorXY"
	
	EMS.GL.MapWidgetToRule["RMG3F1Value"]	= "RMG_ThresholdSea"
	EMS.GL.MapWidgetToRule["RMG3F2Value"]	= "RMG_ThresholdPike"
	EMS.GL.MapWidgetToRule["RMG3F3Value"]	= "RMG_ThresholdLake"
	EMS.GL.MapWidgetToRule["RMG3F4Value"]	= "RMG_ThresholdMountain"
	EMS.GL.MapWidgetToRule["RMG3F5Value"]	= "RMG_ThresholdCoast"
	EMS.GL.MapWidgetToRule["RMG3F6Value"]	= "RMG_ThresholdHill"
	EMS.GL.MapWidgetToRule["RMG3F7Value1"]	= "RMG_ThresholdLowForest"
	EMS.GL.MapWidgetToRule["RMG3F7Value2"]	= "RMG_ThresholdForest"
	EMS.GL.MapWidgetToRule["RMG3F8Value1"]	= "RMG_ThresholdLowMeadow"
	EMS.GL.MapWidgetToRule["RMG3F8Value2"]	= "RMG_ThresholdMeadow"
	EMS.GL.MapWidgetToRule["RMG3F9Value1"]	= "RMG_ThresholdLowFlatland"
	EMS.GL.MapWidgetToRule["RMG3F9Value2"]	= "RMG_ThresholdFlatland"
	EMS.GL.MapWidgetToRule["RMG3F10Value"]	= "RMG_ThresholdRoad"
	
	EMS.GL.MapWidgetToRule["RMG4F2Value1"]	= "RMG_ThresholdHighMeadow"
	EMS.GL.MapWidgetToRule["RMG4F3Value1"]	= "RMG_ThresholdHighForest"
	EMS.GL.MapWidgetToRule["RMG4F1Value1"]	= "RMG_ThresholdPlateau"

	EMS.GL.MapWidgetToRule["RMG5F1Value1"]	= "RMG_AmountClayPit"
	EMS.GL.MapWidgetToRule["RMG5F1Value2"]	= "RMG_ContentClayPit"
	EMS.GL.MapWidgetToRule["RMG5F2Value1"]	= "RMG_AmountClayPile"
	EMS.GL.MapWidgetToRule["RMG5F2Value2"]	= "RMG_ContentClayPile"
	EMS.GL.MapWidgetToRule["RMG5F3Value1"]	= "RMG_AmountStonePit"
	EMS.GL.MapWidgetToRule["RMG5F3Value2"]	= "RMG_ContentStonePit"
	EMS.GL.MapWidgetToRule["RMG5F4Value1"]	= "RMG_AmountStonePile"
	EMS.GL.MapWidgetToRule["RMG5F4Value2"]	= "RMG_ContentStonePile"
	EMS.GL.MapWidgetToRule["RMG5F5Value1"]	= "RMG_AmountIronPit"
	EMS.GL.MapWidgetToRule["RMG5F5Value2"]	= "RMG_ContentIronPit"
	EMS.GL.MapWidgetToRule["RMG5F6Value1"]	= "RMG_AmountIronPile"
	EMS.GL.MapWidgetToRule["RMG5F6Value2"]	= "RMG_ContentIronPile"
	EMS.GL.MapWidgetToRule["RMG5F7Value1"]	= "RMG_AmountSulfurPit"
	EMS.GL.MapWidgetToRule["RMG5F7Value2"]	= "RMG_ContentSulfurPit"
	EMS.GL.MapWidgetToRule["RMG5F8Value1"]	= "RMG_AmountSulfurPile"
	EMS.GL.MapWidgetToRule["RMG5F8Value2"]	= "RMG_ContentSulfurPile"
	
	EMS.GL.MapWidgetToRule["RMG2F7Value"]	= "RMG_AmountVC"
		
	-- tooltip text
	EMS.L.RMG_RandomSeed = "Setzt einen zufälligen Seed."
	EMS.L.RMG_IncreaseThreshold = "Erhöht alle Gelände-Parameter. @cr @cr @color:51,204,255,255 TIPP: @color:255,255,255,255 Bei höheren Parametern wird es mehr Gewässer und weniger Berge geben."
	EMS.L.RMG_DecreaseThreshold = "Verringert alle Gelände-Parameter. @cr @cr @color:51,204,255,255 TIPP: @color:255,255,255,255 Bei niedrigeren Parametern wird es mehr Berge und weniger Gewässer geben."
	
	table.insert(EMS.GV.Pages, "EMSPagesRMG")
	
function RandomMapGenerator.SetRulesToDefault()
	
	RandomMapGenerator.SetRandomSeed()
	--EMS.GL.SetValue("RMG_Seed",			123456789)
	EMS.GL.SetValueSynced("RMG_GenerateRivers",	2)
	EMS.GL.SetValueSynced("RMG_GateLayout",		1)
	EMS.GL.SetValueSynced("RMG_GateSize",		3)
	EMS.GL.SetValueSynced("RMG_GenerateRoads",	Bool2Num(true))
	EMS.GL.SetValueSynced("RMG_LandscapeSet",	1)
	EMS.GL.SetValueSynced("RMG_MirrorMap",		Bool2Num(true))
	
	EMS.GL.SetValueSynced("RMG_AmountClayPit", 1)
	EMS.GL.SetValueSynced("RMG_ContentClayPit", 30000)
	EMS.GL.SetValueSynced("RMG_AmountClayPile", 4)
	EMS.GL.SetValueSynced("RMG_ContentClayPile", 4000)
	EMS.GL.SetValueSynced("RMG_AmountStonePit", 1)
	EMS.GL.SetValueSynced("RMG_ContentStonePit", 30000)
	EMS.GL.SetValueSynced("RMG_AmountStonePile", 4)
	EMS.GL.SetValueSynced("RMG_ContentStonePile", 4000)
	EMS.GL.SetValueSynced("RMG_AmountIronPit", 2)
	EMS.GL.SetValueSynced("RMG_ContentIronPit", 30000)
	EMS.GL.SetValueSynced("RMG_AmountIronPile", 4)
	EMS.GL.SetValueSynced("RMG_ContentIronPile", 4000)
	EMS.GL.SetValueSynced("RMG_AmountSulfurPit", 2)
	EMS.GL.SetValueSynced("RMG_ContentSulfurPit", 30000)
	EMS.GL.SetValueSynced("RMG_AmountSulfurPile", 4)
	EMS.GL.SetValueSynced("RMG_ContentSulfurPile", 4000)
	EMS.GL.SetValueSynced("RMG_AmountVC", 3)
	
	RandomMapGenerator.SetupThresholdsNormal()
end
RandomMapGenerator.SetRulesToDefault()
XGUIEng.ShowWidget("EMSPUSCUp", 1)
XGUIEng.ShowWidget("EMSPUSCDown", 1)