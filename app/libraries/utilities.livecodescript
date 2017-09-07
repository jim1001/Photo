script "Utilities Library"
command libraryTest
   answer "Utilities Library is available and working!"
end libraryTest

function getFilestubFromPath pPath
   set itemdelimiter to "."
   delete item -1 of pPath -- leaves path without suffix
   set itemdelimiter to "/"
   return item - 1 of pPath
end getFilestubFromPath

function assetsFolder
   switch the environment
      case "development"
         return "Z:/Data/Work/My Programs/LiveCode/DemPowerAssets" -- on Z: so included in CreateSynchronicity backups
         break
      case "mobile"
         return "/sdcard/DemPowerAssets"
         break
      default
         answer "Utilities library function assetsFolder: Unknown environment!"
         break
   end switch
end assetsFolder

command initVideoDev pRect, pVideoFile, pVisible
   # pRect is a 4 element array with keys "left", "top", "right", "bottom"
   local tLocn
   set the name of templatePlayer to "videoPlayer"
   set the showController of templatePlayer to true
   set the width of the templatePlayer to pRect["right"] - pRect["left"]
   set the height of the templatePlayer to pRect["bottom"] - pRect["top"] 
   put rectCenter(pRect) into tLocn
   set the location of the templatePlayer to tLocn[1], tLocn[2]
   set the locklocation of the templatePlayer to true
   set the visible of the templatePlayer to true
   if pVideoFile is not empty then
      set the filename of templatePlayer to pVideoFile
   end if
   create player
   reset the templatePlayer 
end initVideoDev

function initVideoMobile pRect, pVideoFile
   local tPlayerRect, tPlayerID
   // Check the control doesn't already exist. If so delete and recreate it
   if tPlayerID is among the lines of mobileControls() then
      mobileControlDelete tPlayerID
   end if 
   mobileControlCreate "player"
   put the result into tPlayerID
   # In LiveCode the rectangle of an object consists of four integers separated by commas
   # representing the object's left, top, right, and bottom edges
   put pRect["left"] & "," & pRect["top"] & "," & pRect["right"] & "," & pRect["bottom"] into tPlayerRect
   mobileControlSet tPlayerID, "rect", tPlayerRect --the second argument (tPlayerRect here) must be one string containing 4 comma separated numbers, not 4 individual numeric arguments  
   mobileControlSet tPlayerID, "showController", true
   if pVideoFile is not empty then
      mobileControlSet tPlayerID, "filename", pVideoFile
   end if
   mobileControlSet tPlayerID, "visible", true
   return tPlayerID
end initVideoMobile

function rectCenter pRect
   # pRect is a 4 element array with keys "left", "top", "right", "bottom"
   local tXY
   put pRect["left"] + (pRect["right"] - pRect["left"])/2 into tXY[1] 
   put pRect["top"] + (pRect["bottom"] - pRect["top"])/2 into tXY[2] 
   return tXY
end rectCenter

command regenSecButtons
   #Regenerates pNum of buttons on a Section card
   #There is a max of 4 buttons in 2 rows of 2
   #Assumes buttons go between a field "cardTitle" and a widget "bottomNavBar"
   local tObjectSeparation, tButtonWidth, tButtonHeight, tCol1X, tRow1Y, tCol2X, tRow2Y
   put 10 into tObjectSeparation
   put (the width of this stack - (3 * tObjectSeparation)) / 2 into tButtonWidth
   put (the top of widget "bottomNavBar" - the bottom of field "cardTitle" - (3 * tObjectSeparation)) / 2 into tButtonHeight
   
   set the width of the templateButton to tButtonWidth
   set the height of the templateButton to tButtonHeight
   set the textSize of the templateButton to 30
   set the textAlign of the templateButton to "center"
   
   set the name of the templateButton to "r1c1"
   #set the label of the templateButton to "1.1 The meaning" & cr & "of home"
   put tObjectSeparation + (tButtonWidth / 2) into tCol1X
   put the bottom of field "cardTitle" + tObjectSeparation + (tButtonHeight / 2) into tRow1Y
   set the location of the templateButton to tCol1X, tRow1Y
   set the behavior of the templateButton to the long id of stack "button_Sect Behavior"
   create button
   
   set the name of the templateButton to "r1c2"  
   #set the label of the templateButton to "1.2 Inside your"  & cr & "home"
   put tCol1X + tObjectSeparation + tButtonWidth into tCol2X
   set the location of the templateButton to tCol2X, tRow1Y
   create button
   
   set the name of the templateButton to "r2c1"  
   #set the label of the templateButton to "1.3 The outdoors"
   put tRow1Y + tObjectSeparation + tButtonHeight into tRow2Y
   set the location of the templateButton to tCol1X, tRow2Y
   create button
   
   set the name of the templateButton to "r2c2"  
   #set the label of the templateButton to "1.4 Couplehood"
   set the location of the templateButton to tCol2X, tRow2Y
   create button
   
   reset the templateButton 
   
end regenSecButtons

command labelButton
   #Can run commands here individually in Message Box
   set the label of button "r1c1" to "Video"
   set the label of button "r1c2" to "Activity: Photo"
end labelButton

command createButtons pNum, pYMin, pYMax, pGap
   #Creates pNum buttons on rectangular grid, filling space between pYMin & pYMax with border all round of pGap 
   #Assumes buttons go across full width of card & 2 buttons per row
   local tButtonWidth, tButtonHeight, tNumRows, tNumVGaps, tButtonNum, tX, tY, tRowNum, tColNum
   put (the width of this stack - (3 * pGap)) / 2 into tButtonWidth -- 3 horizontal gaps across card width
   put round ( pNum / 2 ) into tNumRows --0.5 gets rounded up 
   put tNumRows + 1 into tNumVGaps -- tNumVGaps = num of gaps down page
   put (pYMax - pYMin - (tNumVGaps * pGap)) / tNumRows into tButtonHeight
   
   set the width of the templateButton to tButtonWidth
   set the height of the templateButton to tButtonHeight
   set the textSize of the templateButton to 30
   set the textAlign of the templateButton to "center"
   
   set the behavior of the templateButton to the long id of stack "button_Sect Behavior" --same for all buttons
   
   repeat with tButtonNum = 1 to pNum
      put round ( tButtonNum / 2 ) into  tRowNum
      if  ( tButtonNum mod 2 ) is 0 then
         put 2  into tColNum
      else
         put 1  into tColNum
      end if
      set the name of the templateButton to "r" & tRowNum & "c" & tColNum
      put ( tColNum * pGap) + ( ( ( 2 *  tColNum ) - 1 ) * tButtonWidth / 2 ) into tX
      put pYMin + (tRowNum * pGap) + ( ( ( 2 *  tRowNum ) - 1 ) * tButtonHeight / 2 ) into tY
      set the location of the templateButton to tX, tY
      create button
   end repeat
   
   reset the templateButton 
   
end createButtons

command addActivityItem pNum, pType, pYStart, pDesc
   #pType can be one of strings {photo, write, read, watch}
   local tX, tY, tTitleFieldName, tDescFieldName, tButtName
   
   #Remove any old activities of same name
   put "Activity" & pNum & "Title" into tTitleFieldName
   put "Activity" & pNum & "Desc" into tDescFieldName
   put "r" & pNum into tButtName
   
   if the environment is "development" then
      if there is a field tTitleFieldName then
         delete field tTitleFieldName
      end if
      if there is a field tDescFieldName then
         delete field tDescFieldName
      end if
      if there is a button tButtName then
         delete button tButtName
      end if
   end if
   
   
   #Activity title field
   if pType is not among the words of "photo write read watch" then
      answer "utilities library addActivityItem command error : activity type not valid"
   end if
   
   set the name of the templateField to tTitleFieldName
   set the textSize of the templateField to 20
   set the textStyle  of the templateField to  "underline"
   set the dontwrap of the templateField to "true" 
   put "Activity" && pNum & ":" &&  pType into the templateField
   set the opaque of the templateField to false
   set the showBorder of the templateField to false
   set the threeD of the templateField to false
   create field
   reset the templateField
   #//formattedHeight/Width must refer to object on  current card so can't be set on a template object
   set the width of  field tTitleFieldName to the formattedWidth of field tTitleFieldName
   set the height of  field tTitleFieldName to the formattedHeight of field tTitleFieldName
   put 10 + (the width of  field tTitleFieldName / 2) into tX
   put pYStart + 10 +  (the height of  field tTitleFieldName / 2) into tY
   set the location of  field tTitleFieldName to tX,tY
   
   #Activity description field
   set the name of the templateField to tDescFieldName
   set the threeD of the templateField to false  
   set the showBorder of the templateField to false
   set the width of  the templateField  to the width of this stack - 20
   set the left of  the templateField  to 10
   set the top of  the templateField  to the bottom of field tTitleFieldName + 10
   put pDesc into the templateField
   create field
   reset the templateField
   set the height of  field tDescFieldName to the formattedHeight of field tDescFieldName
   
   #Activity go to button
   set the name of the templateButton to tButtName
   set the label of the templateButton to "Go to activity"
   set the top of the templateButton to the bottom of field tDescFieldName + 5
   set the behavior of the templateButton to the long id of stack "button_Sect Behavior" --same for all buttons 
   set the textSize of the templateButton to 18
   create button
   reset the templateButton
   set the height of  button tButtName to the formattedHeight of button tButtName   
   set the width of  button tButtName to the formattedWidth of button tButtName  
   set the left of button tButtName to 10 
end addActivityItem

command setForward tFCard
   #######
   # Creates & sets invisible field "forward" on the current card to be used by the bottomNavBar behavior script
   #######  
   #Abandoned in favor of using "go to next / previous card"
   #Use example (eg. preOpenCard for card Home):
   # on preopencard
   #    if there is no field "forward" then
   #       setForward "GuideIntroduction"
   #    end if
   #    if there is no field "back" then   
   #       setBack "Splash"
   #    end if
   # end preopencard
   set the name of the templateField to "forward"
   set the visible of the templateField to false
   put tFCard into the templateField
   create field
   reset the templateField
end setForward

command setBack tBCard
   #Abandoned in favor of using "go to next / previous card"   
   set the name of the templateField to "back"
   set the visible of the templateField to false
   put tBCard into the templateField
   create field
   reset the templateField
end setBack

command createVideoRect
   #Draws a graphic rectangle on current card to be placeholder for a video
   #Assumes video will be 664 x 498
   local rectBounds
   set the style of the templateGraphic to "rectangle"
   set  the name of the templateGraphic to "videoRect"
   -- work out video rect (video is 664 x 498)
   put (width of this stack - 664) / 2 into rectBounds["left"]
   if there is a field "cardTitle" of this card then
      put the bottom of field "cardTitle" + 10 into rectBounds["top"] 
   else
      put the bottom of widget "topNavBar" + 10 into rectBounds["top"]
   end if
   put rectBounds["left"]+664 into rectBounds["right"]
   put rectBounds["top"]+498 into rectBounds["bottom"]
   set the rect of the templateGraphic to rectBounds["left"], rectBounds["top"], rectBounds["right"], rectBounds["bottom"]
   create graphic
   reset templateGraphic
end createVideoRect

command setSize pName, pType
   switch pType
      case "button"
         set the width of button pName to the  formattedWidth of button pName
         set the height of button pName to the  formattedHeight of button pName
         break
      case "field"
         set the width of field pName to the  formattedWidth of field  pName
         set the height of field pName to the  formattedHeight of field  pName
         break
      default
         answer "Utilities library, setSize command: Object type not coded!"
   end switch
end setSize
