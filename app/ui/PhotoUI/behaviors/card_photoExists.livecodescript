script "card_photoExists Behavior"
#The PhotoExists card is  used to:
#1. take a photo  - user sees camera controls on arrival. The process is started by "Take a photo" button on NoPhotoExists card)
#2.  display any exisitng photo
#3.  delete any existing photo if requested
on openCard
   if the takePhoto of this card is "n" then 
      set the filename of  image "image" to  the photoPath of this card 
      set the visible  of  image "image" to true
   end if
   
   if the takePhoto of this card is "y" then
      set the rect of the templateimage to the rect of image "image"
      set the visible  of  image "image" to false
      set the visible  of the templateimage to true      
      set the lockloc of the templateimage to true
      set the name of the templateimage to "myPhoto"
      mobilePickPhoto "camera"
      answer "Export path:" && the photoPath of this card
      export image "myPhoto" to file the photoPath of this card as JPEG
      reset the templateimage
   end if
end openCard

command deletePressed
   answer "Do you really want to erase your photo? This action cannot be undone." with "Yes" or "No" titled "Confirmation"
   #Do nothing if user answers "No"
   if it is "Yes" then
      delete file the photoPath of this card
      go to card "NoPhotoExists"
   end if
   
      
end deletePressed
