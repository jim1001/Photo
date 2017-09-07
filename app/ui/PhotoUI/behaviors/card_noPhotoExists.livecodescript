script "card_noPhotoExists Behavior"
on preOpenCard
   set the width of field "noPhoto" to the  formattedWidth  of field "noPhoto"
   set the height of field "noPhoto" to the  formattedHeight  of field "noPhoto"
   set the width of button "takePhoto" to the  formattedWidth  of button "takePhoto"
   set the height of button "takePhoto" to the  formattedHeight  of button "takePhoto"
end preOpenCard
