script "card_noPhotoExists Behavior"
on preOpenCard
   #setObjSize the long id of field "noPhoto"
   #setObjSize the long id of button "takePhoto"
   #setObjSize the long id of button "takePhoto"
end preOpenCard

command takePhotoPressed
   set takePhoto of card "PhotoExists" to "y"
   go to card "PhotoExists"
end takePhotoPressed
