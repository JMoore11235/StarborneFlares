#Include, UserConstants.ahk


xMult := screenWidth/2560
yMult := screenHeight/1440


;Various filenames

global flareFilename := "FlareHexes.txt"
global industrialFilename := "FlareIndustrials.txt"
global stationCoordinatesFilename := "StationCoordinates.txt"



;Gives the coordinates for various Screen Positions

global screenLeftX := 0
global screenRightX := 2559 * xMult


global screenTopY := 0
global screenBottomY := 1439 * yMult


global screenCenterX := 1280*xMult
global screenCenterY := 720*yMult


global lastGotoX := 187*xMult
global lastGotoY := 1318*yMult



;How long the program sleeps between actions that require time to "cooldown", such as mouse movements/clicking.
global shortSleep := 100
global defaultSleep := 1000
global longSleep := 2000
global secondSleep := 4000


;Position of the "Station" Tab (near the top right of the screen).
global stationTabX := 2080*xMult
global stationTabY := 215*yMult

;Position of the top station in the stations tab.
global stationX := 2300*xMult
global station1Y := 285*yMult

;How far apart vertically stations are listed
global stationYDiff := 63*yMult




;NOTE: For the next several values (all of which involve the "selection ring" found by right clicking a hex on the map)
;You must have the camera centered on the hex selected for these coordiates to be correct. All variables that start
; with "ring" have this trait.

;All of these variables correspond to their respective function on the wheel; excess commenting is unneeded.
;We start at attack in the top left, and go clockwise.

;Start Ring Variables

global ringAttackX := 1328*xMult
global ringAttackY := 583*yMult

global ringExploreX := 1400*xMult
global ringExploreY := 655*yMult

global ringHexX := 1400*xMult
global ringHexY := 755*yMult

	;Here, after clicking on the "Hex" option, there are 4 *or* 5 more options available.
	;There are 4 that are always there, and coordinates have been selected such that regardless of if there
	;are 4 or 5 options, they will always work. The 5th (Drop Claim) obviously assumes there are 5.
	
	;Start Hex Variables

global ringHexInspectX := 1370*xMult
global ringHexInspectY := 615*yMult

global ringHexMapPinX := 1375*xMult
global ringHexMapPinY := 790*yMult

global ringHexTransferResourcesX := 1218*xMult
global ringHexTransferResourcesY := 820*yMult

global ringHexLinkX := 1200*xMult
global ringHexLinkY := 615*yMult

;Only should be used if using a hex that has 5 options under Hex
global ringHexDropClaimX := 1160*xMult
global ringHexDropClaimY := 745*yMult


	;End Hex Variables


global ringViewProfileX := 1328*xMult
global ringViewProfileY := 825*yMult

global ringBuildOutpostX := 1230*xMult
global ringBuildOutpostY := 825*yMult

global ringStationX := 1160*xMult
global ringStationY := 755*yMult

global ringSpyX := 1160*xMult
global ringSpyY := 655*yMult

global ringDeployX := 1230*xMult
global ringDeployY := 583*yMult

;End Ring Variables


;Color for Solar Flare indicator in BGR (this exact color without variation)
global flareBGR := 0x8CFFFF

;Where to look for Solar flares. These are off-center in case yellow stars would give the same color on accident.
global checkFlareX := 721*xMult
global checkFlareY := 721*yMult

;How far away pixel searches should look
global err := 3

;Maximum color difference for pixel searches
global var := 1


;Where to start and stop searching for Solar Flare Resources
global flareResourceCheckStartX := 1714*xMult
global flareResourceCheckStartY := 690*yMult

global flareResourceCheckEndX := 2000*xMult
global flareResourceCheckEndY := 725*yMult

;Where to start and stop looking for travel time to a solar flare
global flareTimeCheckStartX := 1880*xMult
global flareTimeCheckStartY := 566*yMult

global flareTimeCheckEndX := 1975*xMult
global flareTimeCheckEndY := 591*yMult

global flareConfirmX := 1856*xMult
global flareConfirmY := 815*yMult



;Where the top left fleet is
global fleetSelectX := 769*xMult
global fleetSelectY := 1114*yMult


;Where to check to see if a fleet is selected or not
global fleetCheckSelectX := 864*xMult
global fleetCheckSelectY := 1114*yMult


;color of the border of a selected fleet
global fleetSelectBGR := 0xF3A812


;How far away in the x/y direction fleets are from each other
global fleetSelectGapX := 204*xMult
global fleetSelectGapY := 156*yMult




;Location of the spies icon in the top right. Used to check to see if we're still in game.
global spyX := 2212*xMult
global spyY := 71*yMult


;Color of spy icon
global spyBGR := 0x2457FE

