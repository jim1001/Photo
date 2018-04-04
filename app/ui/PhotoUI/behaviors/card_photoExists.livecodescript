script "card_photoExists Behavior"
#The PhotoExists card is  used to:
#1. take a photo  - user sees camera controls on arrival. The process is started by "Take a photo" button on NoPhotoExists card)
#2.  display any exisitng photo
#3.  delete any existing photo if requested
local sError, sRect
on preOpenCard
   -- set the rect of graphic "Rectangle" to "156,86,652,752" -- keep in UI
   set the visible of graphic "Rectangle" to false
   put the rect of graphic "Rectangle" into sRect
   if there is a image "image" then
      delete  image "image"
   end if
   if there is a image "myPhoto" then
      delete  image "myPhoto"
   end if
   switch the takePhoto of this card
      case "n"
         create image "image"
         set the rect of image "image" to sRect
         set the filename of  image "image" to  the photoPath of this card 
         set the visible  of  image "image" to true
         break
      case "y"
         set the rect of the templateimage to sRect
         set the visible  of the templateimage to true      
         set the lockloc of the templateimage to true
         set the name of the templateimage to "myPhoto"
         break
      default
         answer "card_photoExistsBehavior: Unhandled option for takePhoto"
   end switch
end preOpenCard
--
on openCard
   if the takePhoto of this card is "y" then
      mobilePickPhoto "camera"
      -- If photo taken OK the result is empty.
      -- If camera times out the result is set to "cancel"
      if the result is not empty then
         -- Camera timed out so go back 
         go to card "NoPhotoExists" 
         exit openCard -- carried on to report Export error without this
      end if
      try
         export image "myPhoto" to file the photoPath of this card as JPEG
      catch sError
         answer "Export error:" && sError
      end try
   end if
end openCard
--
on closeCard
         reset the templateimage
end closeCard

command deletePressed
   answer "Do you really want to erase your photo? This action cannot be undone." with "Yes" or "No" titled "Confirmation"
   #Do nothing if user answers "No"
   if it is "Yes" then
      try
         delete file the photoPath of this card
      catch sError
         answer "Delete error:" && sError
      end try
      
      go to card "NoPhotoExists"
   end if
end deletePressed
