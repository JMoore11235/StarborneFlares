Congrats you opened the readme and read at least eleven words! Just as a heads up, the majority of this project was done between
the hours of 12:00 AM and 5:00 AM, so some things might not make sense, including the comments depending. 


If you are a normal person and think that following a YouTube guide is easier than reading a readme, the link is here:




You can stop reading at this point if you have watched the video linked above; everything covered in this readme is also covered in that video.

If you are a weird person that would rather read a textfile than watch a video, I guess you don't have to watch the video, since everything covered
in the video is also covered here. In fact, this readme is basically a script for the video.




----------Step 0: Install Starborne and make sure you're running Windows

You probably already have Starborne installed, and if that's the case then you have to be running Windows. So hopefully this is already done.




----------Step 1: Download the files for this script, and put them in a folder.

This script contains a few files, and you will also need to add some shortcuts later on. This is the easiest step- just find somewhere 
on your computer to make a designated folder for the files and shortcuts required in this script. I personally have a folder on my Desktop called
"Stareborne Automation" that has a folder called "Scripts". You can do whatever you want, as longas you have a dedicated folder for this.

Also I just realized that you could literally just keep it in the folder that you extracted from the .zip file. So probably just do that.




-----------Step 2: Installing the programs you will need to run this script.

You will need do download a couple programs for this script to work properly. The first is AutoHotKey (AHK). This is the language that I wrote the
script in, and it is what will be controlling your mouse and keyboard during the automation.

Go to:

	https://www.autohotkey.com/

Then click on "Download", then "Download Current Version", then run the executable once it's done downloading.



Additionally, you will need to download an OCR program (that basically turns pictures into text) so that the program knows how many and what type of
resources are at a solar flare.

Go to:

	http://www.cvisiontech.com/index.php?option=com_downloadform&document_id=23&task=displayform&sas_id=&item_id=612

You will need to fill in an email and some basic information BUT THIS CAN ALL BE FAKED
For example, for my email address I used:

	fdsaf@fsdava.cad

I got that by randomly typing on my keyboard. Similiarly, name, etc. don't need to be real. This should give you the option
to download and run an executable.






----------Step 3: Add shortcuts to your script folder

At this point, you will need to add 2 shortcuts to the folder that you made in step one. The first is a shortcut to MS Paint, which should be called "Paint"
(without quotes). The second is the OCR program which should be called "PDF_Compressor". This allows the script to run the programs without you telling it
the direct executable path.




----------Step 4: Overwrite InputPicture

Open up MS Paint, make a cute little drawing, and then save it as InputPicture in the folder that you made in step one. If you did it right, this should
overwrite the current picture there. This is important because Paint will always remember what the last folder you saved a picture into, so my script
always assumes that it is in the correct folder. If you ever use Paint for something else and save a picture not in this folder, you will need to redo this
step in the future.



----------Step 5: Setup the OCR software

Open up PDF_Compressor. If you haven't already, I highly recommend going to the Youtube video now, as this is much more clear when you can see everything
yourself, but I will do my best in writting.

Go to the little page with a gear in the top left, 3rd from the left. When you hover over it, you should see "Edit Default Job Properties". Click on it.

On the Input tab:
	-Make sure that "File" and not "Directory" is selected, and then find InputPicture.png on your computer, and make that the file.
	-Make sure that the Rasterize PDF Input is "Automatic"s

On the Output tab:
	-Select "Place output next to input file"
	-For the "Output File" option, choose "Overwrite exisiting file"
	-Check the "Rename output with template" box, and replace the weird text with "Output" without the quotes.
	-Output Format should be "PDF/A-2u"

On the OCR tab:
	-Check the "Apply OCR" box, and set the mode to "Balanced".
	-Make sure that only English is checked in the OCR recognition box.
		--NOTE: If your game is not in English, don't worry. The script should still function decently well, the only issue is that I will
		be unable to determine what type of resource you have. This means that the prefered resource functionality will not work. Everything
		else should be fine though.


On the General tab:
	-In the "Time Scheduled Processing" subcategory, check "Start job at:" and then choose some time in the past. This is so that the OCR program
	will automatically start any new jobs it gets (which saves time and improved click accuracy).





----------Step 6: Setup user files


At this point, you should have the following files/shortcuts in your script folder:

	-Constants_DO_NOT_MODIFY.ahk
	-FlareHexes.txt
	-FlareIndustrials.txt
	-FlareScript_RUN_THIS_BUT_DONT_MODIFY.ahk
	-HelperMethods_DO_NOT_MODIFY.ahk
	-InputPicture.png
	-Paint
	-PDF_Compressor
	-README_but_still_dont_modify_pls.txt
	-StationCoordinates.txt
	-UserConstants.ahk


If you couldn't guess, you should not modify anything with "Do not modify" in the filename. Unless you know what you are doing, you could make
the program not work. However, the files that do not have this in the title you can and should modify. All files have some examples to show proper
formatting. And by examples, I just mean those are the values that I use.

Important: whenever "station number" is referenced, it is refering to what position it is on the station list on the right side of your screen. The
very top station is "Station 1", and the bottom (without scrolling) should be "Station 7". My script obviously can't tell which station is your first
one that you built, so it is all based on position in that list. Anything below 7 is not usuable by my script because accurately scrolling sounds like
too much work. (However, if you could actually use this for more than 7 stations, let me know and I can probably implement it.)

Whenever I refer to the "x hex" or "x coordinate", I mean the value on the left valueof the coordinate system in Starborne. "y" is the right value.
In game these coordinates are generally framed as [x,y].

Note that in all modifiable text files, there should never be any spaces. If you put spaces, the program will error out and you will be sad.



I'll go over each file one by one and describe what you should put in them, and how to do so properly:


-----1: FlareHexes.txt:

	This is the most tedious file by far. On each line, there should be 3 numbers which describe a sun. The first number is the station that can
	harvest from this sun, the second number is the x coordinate for that star, and the third number is the y coordinate. Each star should have its
	own line.

	Example: "1,35,-13" (without the quotes) would correspond to a star that can be harvested by station 1 at the location [35,-13]
	
	I recommend putting no more than 15 or 20 stars for each station, and if you are in a highly contested/low sun density area,
	maybe put as few as 5 or 10. The method that I used to make sure that I wasn't missing or duplicating any stars was by starting at the top,
	and working my way in a circle around the station until I got back to the top.


	Note that you can have mutliple stations list the same star, which means that they will both be able to harvest from it. This is useful if you
	have two harvesting stations nearby each other. You don't have to worry about overlap, since the script takes care of checking if a flare is
	already being harvested. However, per usual, these should be on seperate lines (and don't need to be adjacent, but could be).

	Example: 

		1,35,-13
		1,16,14
		2,35,-13

	is fine. 



-----2: FlareIndustrials.txt:

	This is much faster than the previous file. Similarly, there should be three numbers on each line, and the first number is the station number.
	


	The second number is a bit harder to properly explain; again, I highly recommend you check the YouTube video, as it is easier to visualize this
	than have it explained through words.

	The second number is the position of your industrial in the station. This is the place where it appears	on your screen when you select the
	station. Currently, only the first two rows are supported; any industrial fleets in the 3rd or further rows are not usable.
	(If this is a big issue, let me know and I can probably fix this. It's a scrolling issue, same as above.)

	The numbering system is a little weird due to how the game displays fleets. The bottom row visable without scrolling is always numbers 1-6
	going from left to right. If you only have 1 fleet at the station, it will be at position 1. If there are 2 or more rows, the top row is
	labeled 7-12. Note that if you have 7 fleets, for example, only positions 1, 7, 8, 9, 10, 11, and 12 will have fleets. 2-6 will be unoccupied.

	If it is ever implemented, the third row will be 13-18, fourth row will be 19-24 etc.



	The third number is simply the industrial fleet's plasma cargo capacity. This is so that if your fleet can only carry 10k resources, it will
	treat 10k and 40k flares as the same (since it can only pick up 10k anyway). This number does not need to be exact, or even extremely accurate.
	Just a ballpark number is fine, and the program will work. Obviously, cargo capacity can change based on cards or other factors.
	It isn't necessary to constantly update these numbers, unless there is a significant change in capacity.



	Example: "1,4,25000" (without the quotes) would represent an industrial stationed at station 1, at position 4, with a plamsa cargo of 25k.

	Each industrial should be on a new line. Additionally, you can have multiple industrials harvesting from the same station. Simply list them on
	seperate lines with the same station number.

	I added this functionality even though I don't use it. I had to make another fleet just to test this, and I honestly didn't test it that thouroghly.
	If you have issues with this, let me know and I can fix it.



-----3: StationCoordinates.txt:

	This is also pretty easy. Just list all of the stations that you want this script to work on, as well as their coordinate location. This is used to
	determine which stations to check, and also to determine distance to each flare.

	Example: "1,64,21" (again, without quotes) would represent that you want station 1 to be activated as part of this script, and that it is at [64,21].

	
	Note that if for any reason, you want a station to stop being used in the script (i.e. industrial fleet moved), you only need to remove that station
	from this file. You do not need to delete any lines in FlareHexes.txt; any flares listed in that file that correspond to a station not listed in this
	file will be ignored. This is because it is really freaking annoying to redo that file. Trust me.




-----4: UserConstants.ahk:

	This is the only non-text file on this list. In order to edit it, right click on it and choose "Edit file". I won't go over what to do here since
	I've already explained everything in that file, but only edit things between the "=" lines, and only edit the values (not the names of the variables).


	



----------Step 6.5: Look through the other files

	This step is completly optional, but if you want to see what my code looks like when I code between midnight and 4 AM, go to "edit file" on the other
	.ahk files, and take a peak. It's actually pretty cool. However, please don't edit them if you want the script to work properly. Actually, what do I
	care. Sure go ahead and edit them- just rememeber the GitHub page when you mess stuff up so you can go back and redownload the file(s).









----------Step 7: Test the program to make sure it works

	Double click on FlareScript_RUN_THIS_BUT_DONT_MODIFY.ahk. This will compile the script, but won't actually make it start running.
	If you get any warnings or errors, something's wrong. To fix this, learn the AHK language, figure out what the error means, and fix my program.
	Just kidding- you probably setup one or more of the files wrong. If you can't figure out what is going on, DM me on Discord and I can try to help.
	This holds true for any error or warning messages you get when running.

	In order to launch the program, first get into Starborne, make sure that you have the "Fleets" tab selected at the bottom, then use the right mouse
	button to rotate the camera so that it is looking straight down on the game. For the life of me I can't figure out how to automate this, so you have
	to do it yourself.

	Trust me, I tried clicking and dragging with the right mouse button, but it just doesn't work. It's wack.

	
	There are two commands you need to know. Both of them involve holding down the Control and Shift keys at the same time, and then either pressing q
	or clicking the left mouse button. (think Control, Alt, Delete; but instead it's Control, Shift, q). Control, Shift, Click will start the sript, and
	Control, Shift, q stops it.

	Note that you will have to compile (double click on) the script every time you quit out of it.


	If you quit the script before you run it, you'll get some warnings about variables not being assigned a value, but don't worry about those.
	(They only happen because some variables are only given values once the script starts running.)




	Whenever you quit the program (or it crashes), you should get a little window telling you how long the script ran for, and how many resouces your 
	industrials were sent to collect. This may not be actually how many were collected, though, if someone sniped a flare from you.




	Assuming everything is working, you should see the script check your stations and start taking pictures of your desktop. It is important that you 
	don't move the mouse or press any keys (besides Control, Shift, q if you want to quit) or else the script might do something unintended.

	Hopefully, everything works. If not, and you can't figure out why, feel free to DM me.




----------Step 8: ??????


----------Step 9: Profit!