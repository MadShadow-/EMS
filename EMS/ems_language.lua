-- ************************************************************************************************ --
-- *                                                                                              * --
-- *                                                                                              * --
-- *                                              EMS                                             * --
-- *                                           LANGUAGE                                           * --
-- *                                                                                              * --
-- *                                                                                              * --
-- ************************************************************************************************ --
		-- german
EMS.L = {
			
			Peacetime = "Waffenstillstand",
			PeacetimeDescription = "Gibt den Waffenstillstand in Minuten ein.",
			PeacetimeEnded = "Der Waffenstillstand ist vorbei! Lasst die Kämpfe beginnen!",
			
			-- Rulesets
			MapStandard = "Standard",
			Erbe = "Erbe Regeln",
			Std6er = "6er",
			CustomRules = "Angepasst",
			
			HQRush1 = "Das Hauptquartier von",
			HQRush2 = "ist jetzt",
			Vulnerable = "angreifbar",
			Invulnerable = "unverwundbar",
			HQRushProtection = "AntiHQRush",
			HQRushProtectionDescripion = "Wenn der AntiHQRush aktiviert ist, ist das Hauptquartiers eines Spielers unverwundbar, solange er noch Dorfzentren besitzt.",
			
			AntiBug = "Anti-Abreissbug",
			AntiBugDescription = "Wenn diese Option aktiviert ist, ist der Abreissbug nicht möglich. Sollte aktiviert bleiben.",
			
			BlessLimit = "Segnenlimit",
			BlessLimitDescription = "Verhindert das Dauersegnen mit der Kirche.",
			
			WeatherChangeLockTimerDescription = "Nach einer Änderung des Wetters durch den Wetterturm, bleibt die erneute Aktivierung des Wetterturms" .. 
			" für die angegebene Zahl in Minuten gesperrt.",
			
			
			Forbidden = "Verboten",
			Allowed = "Erlaubt",
			Unlimited = "Kein Limit",
			AllPlayers = "Alle Spieler",
			Activated = "Aktiviert",
			Deactivated = "Deaktiviert",
			
			TowerLimit = "Turmlimit",
			TowerLimitDescription = "Setzt die maximale Anzahl Türme die ihr bauen könnt.",
			NoTowerLimit = "Deaktiviert das Turmlimit",
			
			TradeLimit = "Handelslimit",
			TradeLimitDescription = "Bestimmt die maximale Menge an Rohstoffen die ihr bei einem Einkauf erhalten könnt.",
			NoTradeLimit = "Deaktiviert das Handelslimit",
			
			NoMarkets = "Deaktiviert das Marktplatzlimit",
			
			TowerLevel = "Turm Ausbaustufe",
			TowerLevels = {
				"Aussichtstürme",
				"Balistatürme",
				"Kanonentürme",
			},
			TowerLevelDescription = "Legt die maximale Ausbaustufe fest, zu der ihr Türme ausbauen könnt!",
			
			BlessLimitPart1 = "",
			BlessLimitPart2 = "",
			
			ResourceLevel = "Rohstoffmodus",
			ResourceLevels = {
				"Normal",
				"Blitzpartie",
				"Speedgame",
			},
			ResourceLevelDescripion = {
				"Ihr spielt mit der Anzahl an Rohstoffen, die für die Karte vorgesehen sind.",
				"Ihr spielt mit doppelt sovielen Rohstoffen, wie für die Karte vorgesehen.",
				"Ihr spielt mit extrem(!) vielen Ressourcen.",
			},
			
			PredefinedRuleset = "Regeln",
			PredefinedRulesetDescription = "Mögliche Regeln: Standard, Erbe und 6er",
			GameMode = "Spielmodus",
			GameModeDescription = "Je nach Karte lassen sich unterschiedliche Spielmodi einstellen, um zum Beispiel ein 2vs3 zu ermöglichen.",
			
			Standard = "Standard",
			
			Sword = "Schwerkämpfer",
			SwordDescription = "Rekrutierung von Schwertkämpfern",
			Bow = "Bogenschützen",
			BowDescription = "Rekrutierung von Bogenschützen",
			PoleArm = "Speerträger",
			PoleArmDescription = "Rekrutierung von Speerträgern",
			LightCavalry = "Leichte Kavalerie",
			LightCavalryDescription = "Rekrutierung leichter Kavallerie",
			HeavyCavalry = "Schwere Kavallerie",
			HeavyCavalryDescription = "Rekrutierung schwerer Kavallerie",
			Rifle = "Schützen",
			RifleDescription = "Erlaubt rekrutierung von Schützen",
			
			Scout = "Kundschafter",
			ScoutDescription = "Erlaubt oder verbietet die Rekrutierung von Kundschaftern",
			
			Thief = "Diebe",
			ThiefDescription = "Erlaubt oder verbietet die Rekrutierung von Dieben",
			
			Bridge = "Brücken",
			BridgeDescription = "Stellt den Bau von Brücken ein oder aus",
			
			Markets = "Marktplätze",
			MarketsWithLimit = "Martkplätze(Limit)",
			MarketsDescription = "Erlaubt oder verbietet den Bau von Marktplätzen. Das Marktplatzlimit gibt an wieviele Marktplätze ihr gleichzeitig gebaut haben könnt." ..
			" Steht dort ein Minus (-) so ist es deaktiviert.",
			
			MakeSummer = "Sommer",
			MakeRain = "Regen",
			MakeSnow = "Winter",
			MakeDescription1 = "Erlaubt oder verbietet die Wetteroption",
			MakeDescription2 = "im Wetterturm",

			CannonDescription = "Erlaube oder verbiete die ",
			CurrentlyAllowed = "In diesem Spiel maximal erforschbare Stufe:",
			AreCurrently = "in diesem Spiel",
			MU = {
				Sword =
				{
					XGUIEng.GetStringTableText("names/PU_LeaderSword1"),
					XGUIEng.GetStringTableText("names/PU_LeaderSword2"),
					XGUIEng.GetStringTableText("names/PU_LeaderSword3"),
					XGUIEng.GetStringTableText("names/PU_LeaderSword4"),
					
				},
				Bow =
				{
					XGUIEng.GetStringTableText("names/PU_LeaderBow1"),
					XGUIEng.GetStringTableText("names/PU_LeaderBow2"),
					XGUIEng.GetStringTableText("names/PU_LeaderBow3"),
					XGUIEng.GetStringTableText("names/PU_LeaderBow4"),
				},
				PoleArm = 
				{
					XGUIEng.GetStringTableText("names/PU_LeaderPoleArm1"),
					XGUIEng.GetStringTableText("names/PU_LeaderPoleArm2"),
					XGUIEng.GetStringTableText("names/PU_LeaderPoleArm3"),
					XGUIEng.GetStringTableText("names/PU_LeaderPoleArm4"),
				},
				HeavyCavalry =
				{
					XGUIEng.GetStringTableText("names/PU_LeaderHeavyCavalry1"),
					XGUIEng.GetStringTableText("names/PU_LeaderHeavyCavalry2"),
				},
				LightCavalry = 
				{
					XGUIEng.GetStringTableText("names/PU_LeaderCavalry1"),
					XGUIEng.GetStringTableText("names/PU_LeaderCavalry2"),
				},
				Rifle = 
				{
					XGUIEng.GetStringTableText("names/PU_LeaderRifle1"),
					XGUIEng.GetStringTableText("names/PU_LeaderRifle2"),
				},
				Cannon = 
				{
					XGUIEng.GetStringTableText("names/PV_Cannon1"),
					XGUIEng.GetStringTableText("names/PV_Cannon2"),
					XGUIEng.GetStringTableText("names/PV_Cannon3"),
					XGUIEng.GetStringTableText("names/PV_Cannon4"),
					"Alle Kanonen", -- do smth with this?
				},
			},
			
			Heroes = 
			{
				"Dario",
				"Pilgrim",
				"Salim",
				"Erec",
				"Ari",
				"Helias",
				"Drake",
				"Yuki",
				"Kerberos",
				"Varg",
				"Mary de Mortfichet",
				"Kala"
			},
			AllowOrForbidBuyHero = "Erlaubt oder Verbietet den Heldenkauf von ",
			ChangeNrOfBuyableHeroesForPlayer = "Wählt die Anzahl der kaufbaren Helden für ",
			Messages = "Nachrichten",
			Of = "von",
			GameOf = "Spiel vom",
			
			Save = "Speichern",
			Load = "Laden",
			DoYouWantToRestart = "Willst du die Karte neustarten?",
			DoYouReallyWantToQuit = "Willst du das Spiel verlassen?",
			DoYouReallyWantToOverwriteThisSaveGame = "Willst du diesen Spielstand wirklich überschreiben?",
			
			ChangeNrOfBuyableHeroesForAll = "Für alle",
			ChangeNrOfBuyableHeroesForAllDescription = "Setzt mit diesem Feld die Anzahl der Helden für alle Spieler gleichzeitig.",
			
			GoIn = "Start in",
			Seconds = "Sekunden",
			
			Options = {
				Chat = "Chat",
				Sound = "Sound",
				Vision = "Sicht",
				
				OptionChatAll   = "Deaktiviert Chat Nachrichten von allen Spielern!",
				OptionSoundAll  = "Deaktiviert Sound Nachrichten von allen Spielern! (Ich brauchte Lehm, mehr Lehm! etc.)",
				OptionVisionAll = "Deaktiviert die Sicht aller Spieler auf euch!",
				
				OptionChat = "Aktiviert oder Deaktivert Text Nachrichten von diesem Spieler.",
				OptionSound = "Aktiviert oder Deaktiviert Sound-Nachrichten von diesem Spieler. (Ich brauchte Lehm, mehr Lehm! etc.)",
				OptionVision = "Erlaubt oder Verbietet es diesem Spieler eure Siedlung zu sehen.",
			},
			
			VersionsDifferent = "Unterschiedliche Versionen!",
			NoConfigFileFound = "Es wurde kein Konfigurationsskript für diese Karte gefunden! Stelle sicher dass sich im Karten Verzeichnis ../extra2/shr/maps/user ein Ordner mit dem Namen EMSConfigs befindet ist und darin eine Datei mit dem Namen @color:255,255,255 " .. Framework.GetCurrentMapName() .. ".lua @color:255,0,0 enthalten ist.",
			PlayerIsAfkNow = " ist afk!",
			PlayerNotAfkAnymore = " ist nicht mehr afk!",
			NeedsCppLogic = "Der Hook von mcb muss für diese Karte aktiviert sein! Bitte starte den S5Updater und aktiviere den CppLogic hook!",
			Player = "Spieler",
			
			RulePageUp = "Springt zur nächsten Regel-Seite.",
			RulePageDown = "Springt zur vorherigen Regel-Seite.",
		};

function EMS.L.Setup()
end