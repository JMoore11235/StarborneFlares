#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#Include, HelperMethods_DO_NOT_MODIFY.ahk


^+LButton::
		
	startTime := A_TickCount
	global totalAmountResources := 0


	;Array where index number is the station number and contains a list with:
		;First Index: Station xHex
		;Second Index: Station yHex
		;Third Index: List of industrials
		;Fourth Dimension: List of industrial cargos (paired with second dimension)
		
	stations := []

	;iterate through the stationCoords file
	lineNum := 1
	Loop {
		FileReadLine, outText, %stationCoordinatesFilename%, %lineNum%
		if (ErrorLevel > 0) {
			;EOF. Or some other error (but we hope it isn't that)
			break
		}

		info := StrSplit(outText, ",")
		
		stationNum := info[1]

		if (stationNum > maxStationNumber) {
			MsgBox, Check StationCoordiantes.txt. There is a station number greater than maxStationNumber. The program will exit.
			ExitApp
		}

		stationAddX := info[2]
		stationAddY := info[3]

		;I don't check for duplicates cause if someone does that it's their own fault and I'm tired

		arrToAdd := []
		arrToAdd[1] := stationAddX
		arrToAdd[2] := stationAddY
		

		;Setup industrial arrays for the future
		arrToAdd[3] := []
		arrToAdd[4] := []

		stations[stationNum] := arrToAdd

		lineNum++
	}


	;iterate through the flareIndustrials file
	lineNum := 1
	Loop {
		FileReadLine, outText, %industrialFilename%, %lineNum%
		if (ErrorLevel > 0) {
			;EOF. Or some other error (but we hope it isn't that)
			break
		}


		info := StrSplit(outText, ",")
		stationNum := info[1]
		indPosition := info[2]
		indCargo := info[3]

		if (stations[stationNum][1] == "") {
			;This means that we have an industrial fleet for a station that is not being used
			lineNum++
			continue
		}

		indCheckIndex := 1
		while (stations[stationNum][3][indCheckIndex] != "") {
			;Keep going through the list of industrials until we find an empty spot
			indCheckIndex++
		}

		stations[stationNum][3][indCheckIndex] := indPosition
		stations[stationNum][4][indCheckIndex] := indCargo

		lineNum++
	}


	;We should have all information about the stations and industrial fleets good to go now. Now we just have to loop through each till the end of time.
	;Or until the user decides to quit, or their computer gains sentience and quits the program itself. Or the power goes out.

	;Or the game crashes. I think the checker works.



	
	
	;Old testing aides.

	;stationNum := 1
	;hexX := -287
	;hexY := -154
	;indPositionList := []
	;indPositionList[1] := 3
	;indCargoList := []
	;indCargoList[1] := 42000


	Loop {
		
		stationNumCheck := 1
		while (stationNumCheck <= maxStationNumber) {

			;Make sure we are still in the game. Don't want to be randomly clicking outside of game.
			CheckInGame()


			if (stations[stationNumCheck][1] == "") {
				;This means that we do not have any industrial fleets to send at this station. Skip it
				stationNumCheck++
				continue
			}
			else {
				;We have a station to check!

				hexX := stations[stationNumCheck][1]
				hexY := stations[stationNumCheck][2]
				indPositionList := stations[stationNumCheck][3]
				indCargoList := stations[stationNumCheck][4]

				;The rest of these are user constants.

				SendSolarFlareIndustrials(stationNumCheck, hexX, hexY, indPositionList, indCargoList, sortType, threshold, preferredResource, preferredResourceMultiplier)
			}
			stationNumCheck++
		}
		

		
		Sleep, %delayBetweenLoops%
	}


return










^+q::
	milliTime := A_TickCount - startTime
	
	numHours := milliTime//3600000
	milliTime := milliTime - (numHours * 3600000)
	

	numMinutes := milliTime//60000
	milliTime := millitime - (numMinutes * 60000)

	numSeconds := milliTime//1000
	
	MsgBox, The script ran for %numHours%h, %numMinutes%m, %numSeconds%s, and sent industrials to gather %totalAmountResources% resouces.

	ExitApp
return