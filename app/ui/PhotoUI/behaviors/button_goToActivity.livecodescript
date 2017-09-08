script "button_goToActivity Behavior"
on mouseUp pButtonNumber
   local tGetPhotoOut
   put getPhoto("S1_1A1") into tGetPhotoOut
   if item 2 of tGetPhotoOut is "y" then
      set photoPath of card "PhotoExists" to item 1 of tGetPhotoOut
      go to card "PhotoExists"
   else 
      set photoPath of card "NoPhotoExists" to item 1 of tGetPhotoOut
      go to card "NoPhotoExists"
   end if
end mouseUp
