script "Stack Init Library"
command libraryTest
   answer "stackInitLibrary is available and working!"
end libraryTest

command setStackTextProps
   set the textFont of this stack to "Droid Sans"
   set the textSize of this stack  to 16
end setStackTextProps

command setDefaultFolderToStackFolder
   local tPath
   put the effective filename of this stack into tPath
   set the itemDelimiter to slash
   delete last item of tPath
   set the defaultFolder to tPath
end setDefaultFolderToStackFolder

command setNavBarItemLabels
   -- nav bar data: 
   -- Settings, About Help -> cog, info, question sign
   -- Back, Home, Forward -> circle arrow left, home, circle arrow left
   local tNavItems
   put empty into tNavItems
   put "Settings" into tNavItems[1]["label"]
   put "Settings" into tNavItems[1]["name"]
   put "cog" into tNavItems[1]["icon_name"]
   put "cog" into tNavItems[1]["hilited_icon_name"]
   put "About" into tNavItems[2]["label"]
   put "About" into tNavItems[2]["name"]
   put "info" into tNavItems[2]["icon_name"]
   put "info" into tNavItems[2]["hilited_icon_name"]
   put "Help" into tNavItems[3]["label"]
   put "Help" into tNavItems[3]["name"]
   put "question sign" into tNavItems[3]["icon_name"]
   put "question sign" into tNavItems[3]["hilited_icon_name"]
   set the itemArray of widget "topNavBar" of card "Home" to tNavItems 
   put empty into tNavItems
   put "Back" into tNavItems[1]["label"]
   put "Back" into tNavItems[1]["name"]
   put "circle arrow left" into tNavItems[1]["icon_name"]
   put "circle arrow left" into tNavItems[1]["hilited_icon_name"]
   put "Home" into tNavItems[2]["label"]
   put "home" into tNavItems[2]["name"]
   put "home" into tNavItems[2]["icon_name"]
   put "Home" into tNavItems[2]["hilited_icon_name"]
   put "Forward" into tNavItems[3]["label"]
   put "Forward" into tNavItems[3]["name"]
   put "circle arrow right" into tNavItems[3]["icon_name"]
   put "circle arrow right" into tNavItems[3]["hilited_icon_name"]
   set the itemArray of widget "bottomNavBar" of card "Home" to tNavItems
end setNavBarItemLabels

function getVersion
   local tVersionString
   put levureBuildProfile() into tVersionString -- always shows "development" in IDE
   put " " & levureAppGet("version") after tVersionString
   put "-" & levureAppGet("build") after tVersionString
   return tVersionString
end getVersion

command createCardTitleField pCardTitle,pFieldName
   local tStackWidth, tFieldWidth, tNavBarHeight
   set the name of the templateField to pFieldName
   set the textSize of the templateField to 36
   set the opaque of the templateField to false
   set the showBorder of the templateField to false
   set the threeD of the templateField to false
   set the width of the templateField to width of this stack - 20 -- default templateField width appears to be 128
   set the textAlign of the templateField to "center"
   put  pCardTitle into the templateField 
   create field //creates a field with just set templateField properties
   reset the templateField   
   set the height of field  pFieldName to the formattedHeight of field pFieldName //formattedHeight/Width must refer to object on  current card
   set the width of field pFieldName to the formattedWidth of field pFieldName
   put  the width of field pFieldName into tFieldWidth
   put  the width of this stack into tStackWidth
   set the left of field pFieldName to (tStackWidth  - tFieldWidth)/2
   put the height of group "topNavBar" into  tNavBarHeight
   set the top of field pFieldName to tNavBarHeight + 20
   set visible of field pFieldName to true
end createCardTitleField
