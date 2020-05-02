#Include, Constants_DO_NOT_MODIFY.ahk

CoordMode, Mouse, Screen





;Selects (left clicks on) a station.

SelectStation(stationNumber) {
;Make sure we are on the Station tab (as opposed to Pin tab)

	MouseMove, stationTabX, stationTabY
	Sleep, %defaultSleep%
	Send, {LButton}
	Sleep, %longSleep%

	
	;Move the mouse on the station requested

	yMove := station1Y + ((stationNumber - 1) * stationYDiff)
	MouseMove, stationX, yMove
	Sleep, %longSleep%

	;Scroll up to make sure we're at the top
	Loop, 30
	{
		Send, {WheelUp}
		Sleep, %shortSleep%
	}
	Sleep, %defaultSleep%

	Send {LButton}
	Sleep, %defaultSleep%

	;Make sure we're still zoomed properly after scrolling
	MouseMove, screenCenterX, screenCenterY
	Sleep, %defaultSleep%
	AdjustZoom()
}


;Centers the screen on a station. The number given is the number down the list (e.g. a "2" will the the second station from the top).
;Also selects the station.
;Counting starts at 1.

CenterScreenOnStation(stationNumber)
{
	;Make sure we are on the Station tab (as opposed to Pin tab)

	MouseMove, stationTabX, stationTabY
	Sleep, %defaultSleep%
	Send, {LButton}
	Sleep, %longSleep%

	
	;Move the mouse on the station requested

	yMove := station1Y + ((stationNumber - 1) * stationYDiff)
	MouseMove, stationX, yMove
	Sleep, %defaultSleep%


	;Scroll up to make sure we're at the top
	Loop, 30
	{
		Send, {WheelUp}
		Sleep, %shortSleep%
	}
	Sleep, %defaultSleep%


	Send {RButton}
	Sleep, %defaultSleep%
	Send {LButton}
	Sleep, %defaultSleep%

	;After right clicking, zoom gets messed up.
	MouseMove, screenCenterX, screenCenterY
	Sleep, %defaultSleep%
	AdjustZoom()
}




;Sends a "/goto xHex yHex" message in Starborne chat, sending the camera to this spot.
;needLink will link a hex first to ensure that chat functionallity is working.

Goto(xHex, yHex, needLink)
{
	;Make sure we're still in game and not inside a solar flare or something.
	CheckInGame()

	if (needLink == true) {
		CenterScreenOnStation(1)
		AdjustZoom()
		MouseMove, screenCenterX, screenCenterY
		Sleep, %longSleep%
		Send, {RButton}
		MouseMove, ringHexX, ringHexY
		Sleep, %longSleep%
		Send, {LButton}
		Sleep, %longSleep%
		MouseMove, ringHexLinkX, ringHexLinkY
		Sleep, %longSleep%
		Send, {LButton}

		;At this point, we are in chat with the link highlighted.

		Send {Backspace}
		Sleep, %defaultSleep%

	}
	else {
		;We need to make sure we're not currently in the chat window, which is why we click.
		;We move the mouse to the center so that we don't accidentally click on something else.
		MouseMove, screenCenterX, screenCenterY
		Sleep, %longSleep%
		Send, {LButton}
		Sleep, %defaultSleep%
		Send, {Enter}
		Sleep, %defaultSleep%

		;Just in case there was a junk message before
		Send {Backspace}
		Sleep, %defaultSleep%
	}

	;At this point, we should be in chat, with an empty message

	Send, /goto %xHex% %yHex%
	Sleep, %defaultSleep%
	Send,{Enter}
	Sleep, %defaultSleep%
}



;Takes a screenshot of an area, and copies the text content into the clipboard (Acessible with %clipboard%).

Screenshot(topLeftX, topLeftY, bottomRightX, bottomRightY)
{
	;Take the screenshot:	

	Send, {LWin Down}{LShift Down}s{LShift Up}{LWin Up}
	Sleep, %longSleep%
	MouseMove, topLeftX, topLeftY
	Sleep, %longSleep%
	Send, {LButton Down}
	Sleep, %defaultSleep%	
	MouseMove, bottomRightX, bottomRightY, 10
	Sleep, %defaultSleep%
	Send, {LButton Up}


	;Save it as an image:

		;Open and activate Paint
	Run, Paint
	WinWait, Untitled - Paint
	WinActivate, Untitled - Paint
	Sleep, %defaultSleep%


		;Paste and crop the image
	Send, ^v
	Sleep %defaultSleep%
	Send, ^+x
	Sleep, %defaultSleep%


		;Save the image
	Send, ^s
	Sleep, %longSleep%
	Send, InputPicture
	Sleep, %defaultSleep%
	Send, {Enter}
	Sleep, %longSleep%

		;Confirm Overwrite
	Send, {Left}
	Sleep, %defaultSleep%
	Send, {Enter}
	Sleep, %longSleep%

		;Close Paint
	Send, !{F4}


		;Open PDF_Compressor
	Run, PDF_Compressor
	Sleep, %secondSleep%
	Send, ^n
	checkFileExists := FileExist("Output.pdf") 
	
		;Wait for PDF_Compressor to perform OCR, then close it

	while (checkFileExists == "") {
		Sleep, %longSleep%
		checkFileExists := FileExist("Output.pdf")
	}
	Send, !{F4}


		;Open the output pdf, copy the contents into the clipboard, then delete the file
	Run, Output.pdf
	Sleep, %longSleep%
	Send, {LButton}
	Sleep, %longSleep%
	Send, {LCtrl Down}a{LCtrl Up}
	Sleep, %defaultSleep%
	Send, {LButton}
	Sleep, %defaultSleep%
	Send, {LCtrl Down}a{LCtrl Up}
	Sleep, %defaultSleep%
	Send, {LCtrl Down}c{LCtrl Up}
	Sleep, %defaultSleep%
	Send, !{F4}
	Sleep, %defaultSleep%
	FileDelete, Output.pdf 
}


;Changes Zoom to work with the progam

AdjustZoom(){

	MouseMove, screenCenterX, screenCenterY
	Sleep, %defaultSleep%
	
	;Zoom all the way in
	Loop, 50
	{
		Send, {WheelUp}
		Sleep, %shortSleep%
	}

	Sleep, %defaultSleep%

	;Zoom 3 ticks out
	Loop, 3
	{
		Send, {WheelDown}
		Sleep, %shortSleep%
	}
	


	;Try to get angle to work?
	;Send, {LButton down}
	;Sleep, %defaultSleep%
	;MouseMove, screenCenterX, screenBottomY, 50
	;Sleep, %defaultSleep%
	;Send, {LButton up}
	;Sleep, %secondSleep%
	;MouseMove, screenCenterX, screenCenterY
	;Sleep, %defaultSleep%
}



;This is based off of my wack numbering system for fleets- bottom row without scrolling is 1st row, top row (if there are 2+ rows) is 2nd row, then normal ordering
;This is because if there is only one row, it's the bottom row.
;Counting starts at 1.

SelectFleet(position) {

	position--
	;I lied counting starts at 0 but it needs to be user friendly so shhh. I'll fix it in here :)

	;6 because that is the number of fleets that a row can hold.
	rowNum := position//6


	;Because the modulus operator isn't in AHK for some reason
	;Now position epresents the x coord of the fleet's position instead of absolute position
	position := position - (rowNum * 6)

	;We need to switch 0 and 1 so that we get a consistant pixel modifier (Look at me planning for the future)
	if (rowNum == 1) {
		rowNum := 0
	}
	else if (rowNum == 0) {
		rowNum := 1
	}
	else {
		;I haven't implemented 3rd or higher rows yet, sorry. Message me on Discord if this is an issue for you.
		return -1
	}

	

	xPos := fleetSelectX + (position * fleetSelectGapX)
	yPos := fleetSelectY + (rowNum * fleetSelectGapY)


	MouseMove, xPos, yPos
	Sleep, %defaultSleep%
	Send, {LButton}
	Sleep, %defaultSleep%
	return 0
}



;Checks to see if a fleet is selected or not given position. Returns true if it is, false if it isn't.
;Very similar to selecting a fleet
;position is the same numbering as SelectFleet().

;Most of this code *definitely* wasn't copy pasted.

IsFleetSelected(position)
{

	position--
	
	;6 because that is the number of fleets that a row can hold.
	rowNum := position//6


	;Because the modulus operator isn't in AHK for some reason
	;Now position epresents the x coord of the fleet's position instead of absolute position
	position := position - (rowNum * 6)

	;We need to switch 0 and 1 so that we get a consistant pixel modifier (Look at me planning for the future)
	if (rowNum == 1) {
		rowNum := 0
	}
	else if (rowNum == 0) {
		rowNum := 1
	}
	else {
		;I haven't implemented 3rd or higher rows yet, sorry. Message me on Discord if this is an issue for you.
		return -1
	}

	

	xPos := fleetCheckSelectX + (position * fleetSelectGapX)
	yPos := fleetCheckSelectY + (rowNum * fleetSelectGapY)
	
	;MouseMove, xPos, yPos


	;If it finds the correctColor, ErrorLevel will be 0.
	PixelSearch,,, xPos-err, yPos-err, xPos+err, yPos+err, %fleetSelectBGR%, var, Fast

	if (ErrorLevel == 0) {
		return true
	}
	else {
		return false
	}
}


;Opens a Solar Flare that the screen is centered on.
OpenSolarFlare() {
	MouseMove, screenCenterX, screenCenterY
	Sleep, %defaultSleep%
	Send, {RButton}
	Sleep, %longSleep%
	MouseMove, ringExploreX, ringExploreY
	Sleep, %defaultSleep%
	Send, {LButton}
	Sleep, %secondSleep%
}


;Checks to see if there is a solar flare at the given position. If there is, return true; otherwise, return false.

IsSolarFlare(hexX, hexY)
{
	Goto(hexX, hexY, false)
	Sleep, %defaultSleep%
	MouseMove, checkFlareX, checkFlareY
	Sleep, 2000
	
	PixelSearch,,, checkFlareX-err, checkFlareY-err, checkFlareX+err, checkFlareY+err, %flareBGR%, var, Fast
	if (ErrorLevel == 0) {
		return true
	}
	else {
		;MouseMove, 0, 0
		;PixelGetColor, outColor, checkFlareX, checkFlareY
		;Sleep, 5000
		;Send, %outColor%
		return false
	}
}



;Opens a file containing a list of hexes to check for solar flares, checks them, then returns a 3D array.
;stationNum is the number of the station you want to check for flares.

;Returns a 2D array:

;First Dimension: List of flares found at that station. Note that first index contains a number one more than the last index, and is not a flare.
;Second Dimension: [xHex, yHex, Resource Amount, Resource Type]

GetSolarFlares(stationNum)
{
	lineNumber := 1
	
	flares := []

	;Loop through each line in the flare file
	Loop {

		FileReadLine, line, %flareFilename%, %lineNumber%
		if (ErrorLevel == 0) {
			coords := []
			coords := StrSplit(line, ",")
			checkStationNumber := coords[1]	

			
			;Only check flares that match our station
			if (checkStationNumber != stationNum) {
				lineNumber++
				continue
			}
			
	
			xHex := coords[2]
			yHex := coords[3]
			
			

			foundFlare := IsSolarFlare(xHex, yHex)
			;foundFlare := true
			if (foundFlare == true) {
				
				;Open the Solar Flare and send the amount and type of resources to the clipboard
				OpenSolarFlare()
				Screenshot(flareResourceCheckStartX, flareResourceCheckStartY, flareResourceCheckEndX, flareResourceCheckEndY)
				Sleep, %longSleep%	



				;If this is the first flare that was found, create a openIndex counter for it.
					;openIndex stores the value of the first open index in the array.
					;Setting it to 2 means that index 2 is available to store flare information.

				if (flares[1, 1] == "") {
					flares[1, 1] := 2
				}
				openIndex := flares[1, 1]

				;flareResourceValues is an array that should store [Resource Amount, Resource Type]
				flareResourceValues := StrSplit(clipboard, " ")

				flares[openIndex, 1] := xHex
				flares[openIndex, 2] := yHex
				flares[openIndex, 3] := flareResourceValues[1]
				flares[openIndex, 4] := flareResourceValues[2]
				
				openIndex++
				flares[1, 1] := openIndex

				;Close Solar Flare page
				Send {Esc}
				Sleep, %defaultSleep%				
			}
			else {	
			;findFlare is false.
			}

		}
		else {
			;The file has ended (or some error occured, but let's just hope it isn't that)
			break
		}
		lineNumber++
	}
	return flares
}



;Given the Starborne hex system, distance is a bit unclear, but simple enough once you understand it.
;If the direction for both x and y is the same (if both are larger or smaller in the second hex), you add the differences between the x's and the y's
;If the direction for x and y is different (x2 > x1, but y2 < y1 for example), you take the maximum of the two diferences. Wack I know.
;Obviously, this is distance so always positive.

;x1 and y1 are the coordinates for hex1
;x2 and y2 are the coordinates for hex2

Distance(x1, y1, x2, y2)
{
	xDiff := x1 - x2
	yDiff := y1 - y2

	if(xDiff < 0) {
		if (yDiff < 0) {
			result := 0 - xDiff - yDiff
			return result
		}
		else {
			xDiff := 0 - xDiff
			if (xDiff > yDiff) {
				return xDiff
			}
			else {
				return yDiff
			}
		}
	}

	;xDiff is now positive no matter what

	if (yDiff < 0) {
		yDiff := 0 - yDiff
		if (xDiff > yDiff) {
			return xDiff
		}
		else {
			return yDiff
		}
	}
	
	result := xDiff + yDiff
	return result

}




;Actually sends industrials to solar flares.
;flareName is the file containing the flares list (By default, this should be "FlareHexes.txt")

;stationNum is the number of the station you're using

;stationHexY and stationHexY are the coordinates for the given station. This is used to determine distance between hexes.

;indPositionList is an array of positions for industrials that you are sending out. Ideally, this should be ordered from best fleet to worst fleet.
;This is because earlier fleets will be sent to the better flares.

;sortType is whether you're sorting by:
	;"amount", which is the absolute number of resources (more is preferred)
	;"amountPerHex", which is the number of resources divided by the distance (more per hex is preferred)
	;"distance", which is the distance (shorter is preferred)

;threshold is the minimum or maximum amount allowed to send a fleet. This depends on sortType.
;For example, if sortType is "amount" a threshold of "5000" would mean no fleets would be sent for less than 5000 resources

;preferred designates the preferred type of resource. This means that that type of resouce will be multiplied by the multiplier when determining what flare to go to.
;Note that this has no effect if "distance" is chosen as sortType.
;This should be: "metal", "gas", "crystal", or "none" (none obviously meaning none is preferred)

;preferredMultiplier is how much you multiply the preferred resource type by. For example if cyrstal is preferred with a multiplier of 1.5, a flare with 1000 crystal would
;be treated equivalently to a flare with 1500 metal.

SendSolarFlareIndustrials(stationNum, stationHexX, stationHexY, indPositionList, indCargoList, sortType, threshold, preferred, preferredMultiplier)
{
	;Automattically adjusts zoom as well.
	SelectStation(stationNum)

	

	;What industrial we are using next
	indIndex := 1
	
	shouldBreak := false

	;Skip over industrials that are not at base
	Loop {
		currentIndPosition := indPositionList[indIndex]
		if (currentIndPosition == "") {
			;All industrials were already sent out. This means we don't need to check for flares at all.
			return
		}

		SelectFleet(currentIndPosition)
		res := IsFleetSelected(currentIndPosition)
	
		if (res == false) {
			;This means that we clicked on it, but didn't select it. That means that it was already sent, so check the next one.
			indIndex++
			continue
		}

		;This means that we have now selected the fleet, which means that we can send at least one fleet and should now check for flares!
		;We need to deselect it now, though, or the code breaks
		SelectFleet(currentIndPosition)
		break
	}




	flares := GetSolarFlares(stationNum)
	openIndex := flares[1, 1]

	if (openIndex == "") {
		;No flares found :(
		return
	}

	
	;How many resources we are getting. This counts preffered resources as 1 resource, regardless of multiplier. Used to add to total amount later.
	amountGetting := 0


	Loop {

		;position of currentIndustrial
		currentIndPosition := indPositionList[indIndex]
		if (currentIndPosition == "") {
			;We've already sent all industrials
			break
		}

		;How much plasma cargo the current Industral fleet can hold
		currentIndCargo := indCargoList[indIndex]

		flareToGoToIndex := 0

		if (sortType == "amount") {
			maxAmount := 0
			maxIndex := 0

			index := 2

			;Go through all flares
			while (index < openIndex) {
				amount := flares[index, 3]

				if (amount > currentIndCargo) {
					amount := currentIndCargo
				}

				type := flares[index, 4]


				if (type == preferred) {
					amount := amount * preferredMultiplier
				}

				if (amount > maxAmount) {
					maxAmount := amount
					maxIndex := index
				}
				index++
			}
			
			if (maxAmount < threshold) {
				;if the most was below threshold, we don't use it.
				maxIndex := 0
			}
			
			amountGetting := flares[maxIndex, 3]
			if (amountGetting > currentIndCargo) {
				amountGetting := currentIndCargo
			}

			;If no flares were usable, maxIndex will still be 0.
			flareToGoToIndex := maxIndex

			;Set the amount of resources at the flare we're going to to 0, so we don't keep trying to send fleets to the same flare.
			flares[maxIndex, 3] := 0
		}
		else if (sortType == "distance") {
			;Much larger than possible max distance.
			minDistance := 10000 
			minIndex := 0

			index := 2

			;Go through all flares
			while (index < openIndex) {
				amount := flares[index, 3]

				if (amount < 1) {
					;This means the flare has already been taken or is unusable
					continue
				}
				

				flareHexX := flares[index, 1]
				flareHexY := flares[index, 2]

				distance := Distance(stationHexX, stationHexY, flareHexX, flareHexY)

				if (distance < minDistance) {
					minDistance := distance
					minIndex := index
				}
				index++
			}

			if (minDistance > threshold) {
				;All flares were too far away
				minIndex := 0
			}


			;If no flares were usable, minIndex will still be 0.
			flareToGoToIndex := minIndex

			amountGetting := flares[minIndex, 3]
			if (amountGetting > currentIndCargo) {
				amountGetting := currentIndCargo
			}

			;Set the amount of resources to 0 so flare becomes unusable
			flares[minIndex, 3] := 0
			
		}
		else {
			;default to resources per hex since I think that's the best.
			
			maxAmountPerHex := 0
			maxIndex := 0

			index := 2
		
			;Go through all flares
			while (index < openIndex) {
				
				flareHexX := flares[index, 1]
				flareHexY := flares[index, 2]
				amount := flares[index, 3]
				type := flares[index, 4]


				if (amount > currentIndCargo) {
					amount := currentIndCargo
				}


				distance := Distance(stationHexX, stationHexY, flareHexX, flareHexY)

				if (type == preferred) {
					amount := amount * preferredMultiplier
				}

				;If used correctly, distance can't be 0. User fault if there's an error here.
				amountPerHex := amount / distance

				if (amountPerHex > maxAmountPerHex) {
					maxAmountPerHex := amountPerHex
					maxIndex := index
				}
				index++
			}

			if (maxAmountPerHex < threshold) {
				;Not enough to send out
				maxIndex := 0

			}


			amountGetting := flares[maxIndex, 3]
			if (amountGetting > currentIndCargo) {
				amountGetting := currentIndCargo
			}


			flareToGoToIndex := maxIndex
			flares[maxIndex, 3] := 0


		}


		;At this point, we should know which flare we want to go to. If the index is 0, that means none are available
		if (flareToGoToIndex == 0) {
			break
		}

		flareHexX := flares[flareToGoToIndex, 1]
		flareHexY := flares[flareToGoToIndex, 2]

		Goto(flareHexX, flareHexY, false)
		Sleep, %defaultSleep%
		OpenSolarFlare()
		Sleep, %defaultSleep%
		
		;Attempt to select and send the industrial fleet.
		SelectFleet(currentIndPosition)
		Sleep, %defaultSleep%

		MouseMove, flareConfirmX, flareConfirmY
		Sleep, %defaultSleep%
		Send, {LButton}
		Sleep, %secondSleep%


		;If the fleet was sent to the flare, the fleet will become unselected. Otherwise, it will remain selected.
		stillSelected := IsFleetSelected(currentIndPosition)

		if (stillSelected == false) {
			;This means that the fleet was sent, so we move on to the next industrial fleet
			totalAmountResources := totalAmountResources + amountGetting
			indIndex++
			continue
		}

		;At this point we know that we failed to send the fleet.

		;We need to deselect the fleet ourselves now and espace from the flare window
		SelectFleet(currentIndPosition)
		Sleep, %defaultSleep%
		Send, {Esc}
		Sleep, %defaultSleep%
		
		;Now we just loop through again without increasing indIndex, so we keep looking for the same fleet.

	}
}


;Checks to make sure we're still in the game. Uses the spy icon in the top right due to its distinctive color.
;Note that you must be tabbed into the game for this to register true.

CheckInGame() {

	MouseMove, spyX, spyY
	PixelSearch,,, spyX-err, spyY-err, spyX+err, spyY+err, %spyBGR%, var, Fast
	if (ErrorLevel == 0) {
		;We found the icon!
		return true
	}
	else {
		;We did not find the icon :(
		MsgBox, Game not detected. Exiting Script.
		Send, ^+q
		Sleep, 1000
		MsgBox, Oops
		ExitApp
		return false
	}
}

