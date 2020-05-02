;This file contains values that can and should be changed by the user to suit their needs.
;Each constant has a descriptor to help the user determine the best value.





;What are your screen dimensions in pixels? screenWidth for me is 2560 and screenHeight is 1440

;===================================================================================================================================
global screenWidth := 2560
global screenHeight := 1440
;===================================================================================================================================





;preferredResource:
;What resource do you want the most (or the least, depending on what you set the multiplier to- see below)?

;This value should be: "metal", "gas", "crystal", or "none".
;===================================================================================================================================
global preferredResource := "metal"
;===================================================================================================================================




;preferredResourceMultiplier:
;How much more do you want the preferred resource? For example, if this value is 1.5 and the preferredResource is "metal",
;then 1000 metal would be considered equivalent to 1500 gas or crystal. If this value is 1, then preferredResource does not matter.

;Note that if this value is below 1, the preferredResource will actually become less preferred than the other two,
;if that is how you want to use it.

;This value should never be below 0, but can be as high as you want it. Recommended levels are between 1 and 2.
;===================================================================================================================================
global preferredResourceMultiplier := 1.5
;===================================================================================================================================







;sortType:
;sortType is whether you're sorting by:
	;"amount", which is the absolute number of resources (more is preferred)
	;"amountPerHex", which is the number of resources divided by the distance (more per hex is preferred)
	;"distance", which is the distance (shorter is preferred)

;Note that if sortType is "distance", then preferredResource doesn't matter, only distance.

;===================================================================================================================================
global sortType := "amountPerHex"
;===================================================================================================================================




;threshold is the minimum or maximum amount allowed to send a fleet. This depends on sortType.
;For example, if sortType is "amount" a threshold of "5000" would mean no fleets would be sent for less than 5000 resources.
;if sortType is "amountPerHex", a theshold of "500" would mean a flare would need to have 500 resources per hex it was away from you.
;if sortType is "distance", a threshold of "50" would mean you would never go to a flare that is more than 50 hexes away.

;The lower the threshold, the more flares you'll go to, but you could get less value over all if you set it too low.
;After expirimentation, I've found that pretty low thresholds are better, since flares are not too common.
;Also remember when they get sent out, they'll always check all flares first, so this theshold means that there are no better flares.


;Recommended levels:
	;for "amount": 5000-40000
	;for "amount per hex": 200-1000		For reference, 250 means that you'd go for 10000 resources 40 hexes away.
	;for "distance": Why do you even have the flare in FlareHexes if you don't want this? Idk, like 50?

;Personal levels (what I use):
	;for "amount": 10000 (Actually I don't use this since I don't use amount. But if I did, this would be it.)
	;for "amount per hex": 250
	;for "distance": I just don't put it in my FlareHexes file.

;===================================================================================================================================
global threshold := 250
;===================================================================================================================================
		



;maxStationNumber

;This is the highest station number that you will use. Please don't put this at 8 or above (7 or lower is fine), because I'm too lazy
;to figure out scrolling on the station list. If you actually would do flare harvesting from 8 or more stations, let me know and I can
;probably implement this sometime in the future. Having this number higher than your actual max station is fine, so probably just leave
;it at 7 honestly. I'm not even sure why this is a user constant. #4AMDecisions

;===================================================================================================================================
global maxStationNumber := 7
;===================================================================================================================================




;delayBetweenLoops:
;How long you want to wait between checking for solar flares after you were done the last time. If this is 0, there is no downside
;except that there will be constant activity and you will probably recheck the same suns dozens of times before they flare.
;I would say this decreases power usage but honestly I have no idea. Maybe it will be less suspicious if you think Starborne is
;gonna hunt you down? Or maybe it will magically multiply your resources by this number. Who knows?

;Time delay in milliseconds. Reminder that 1000 milliseconds = 1 second. Thus a delay of 30000 would be 30 seconds.
;Figure out how many minutes I have it set to as a fun mental challenge! Hint: 1 minute = 60 seconds.


;===================================================================================================================================
global delayBetweenLoops := 300000
;===================================================================================================================================






;P.S. If you didn't solve the riddle, I actually don't know the answer. I just put a nice-looking number there and am hoping it works out.

;If you did solve the riddle, DM me on Discord at JMoney#6100 to tell me the answer! I really want to know the answer.
;Or if you have any questions in general.
;Or want to tell me that this sucks and you don't like it. Actually don't, my feelings get hurt easily :'(.