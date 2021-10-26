-- ************************************************************************************************ --
-- *                                                                                              * --
-- *                                                                                              * --
-- *                                              EMS                                             * --
-- *                                         GLOBAL VALUES                                        * --
-- *                                                                                              * --
-- *                                                                                              * --
-- ************************************************************************************************ --
EMS.GV = {};
EMS.GV.ForbiddenColor         = " @color:255,0,0 ";
EMS.GV.AllowedColor           = " @color:0,255,0 ";
EMS.GV.TooltipHighlightColor1 = " @color:155,155,255 ";
EMS.GV.TooltipNormalColor1    = " @color:255,255,255 ";
EMS.GV.RuleOverviewColor1     = " @color:220,205,39 ";
EMS.GV.RuleOverviewColor2     = " @color:0,233,255 ";
EMS.GV.AttentionColor         = " @color:255,165,0 ";

EMS.GV.PlayerColors = {
	"@color:15,64,255",
	"@color:226,0,0",
	"@color:235,255,53",
	"@color:0,235,209",
	"@color:252,164,39",
	"@color:178,2,255",
	"@color:255,79,200",
	"@color:115,209,65",
	"@color:0,140,2",
	"@color:184,184,184",
	"@color:184,182,90",
	"@color:136,136,136",
	"@color:230,230,230",
	"@color:57,57,57",
	"@color:139,232,255",
	"@color:255,150,214",
	Blau = "@color:15,64,255",
	Rot =		"@color:226,0,0",
	Gelb =		"@color:235,255,53",
	Tuerkis =	"@color:0,235,209",
	Orange =	"@color:252,164,39",
	Lila =		"@color:178,2,255",
	Pink =		"@color:255,79,200",
	Hellgruen =	"@color:115,209,65",
	Dunkelgruen =	"@color:0,140,2",
	Hellgrau =	"@color:184,184,184",
	Beige	 =	"@color:184,182,90",
	Dunkelgrau =	"@color:136,136,136",
	Weiss =		"@color:230,230,230",
	Schwarz =	"@color:57,57,57",
	Himmelblau =	"@color:139,232,255",
	Hellrosa =	"@color:255,150,214"
};

EMS.GV.PlayerColorsRGB = {
	{15,64,255},
	{226,0,0},
	{235,255,53},
	{0,235,209},
	{252,164,39},
	{178,2,255},
	{255,79,200},
	{115,209,65},
	{0,140,2},
	{184,184,184},
	{184,182,90},
	{136,136,136},
	{230,230,230},
	{57,57,57},
	{139,232,255},
	{255,150,214},
};

function EMS.GV.Setup()
	-- general
	EMS.GV.GameStarted = false;
	EMS.GV.HostId = 1;
	EMS.GV.PlayerId = GUI.GetPlayerID();
	if EMS.T.IsMultiplayer() then
		if CNetwork then
			for playerId, data in pairs(EMS.PlayerList) do
				if UserTool_GetPlayerName(playerId)
				== EMS.CN.GetHost() then
					EMS.GV.HostId = playerId;
					break;
				end
			end
		else
			for playerId, data in pairs(EMS.PlayerList) do
				if XNetwork.GameInformation_GetNetworkAddressByPlayerID(playerId)
				== XNetwork.Host_UserInSession_GetHostNetworkAddress() then
					EMS.GV.HostId = playerId;
					break;
				end
			end
		end
	end
	EMS.GV.IsHost = (EMS.GV.HostId == GUI.GetPlayerID());
	if EMS.T.IsMultiplayer() then
		EMS.GV.MaxPlayers = XNetwork.GameInformation_GetMapMaximumNumberOfHumanPlayer();
	else
		EMS.GV.MaxPlayers = 1;
	end
end