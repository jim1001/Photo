script "button_goToActivity Behavior"
on mouseUp pButtonNumber
   local tGetPhotoOut
   put getPhoto("S1_1A1") into tGetPhotoOut # function in stack script file
   set photoPath of card "PhotoExists" to item 1 of tGetPhotoOut
   if item 2 of tGetPhotoOut is "y" then
      set takePhoto of card "PhotoExists" to "n"
      go to card "PhotoExists"
   else 
      go to card "NoPhotoExists" # takePhoto of card "PhotoExists" gets set to "y" from card "NoPhotoExists"
   end if
   
end mouseUp
