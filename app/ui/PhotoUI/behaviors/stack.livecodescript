script "stack Behavior"
on preOpenStack
   setStackTextProps
end preOpenStack

function getPhoto pActivityID
   #Checks if there is a file on disk for the given activity
   #See the code for the expected path of the file for a given activity
   #for this test pActivityID = "S1_1A1" (Section 1.1, Activity1)
   local tFilePath, tPhotoExists
   put assetsFolder() & "/User/Photos/" & pActivityID & ".jpg" into tFilePath
   if there is a file tFilePath then
      put "y" into tPhotoExists
   else
      put "n" into tPhotoExists
   end if
   return tFilePath, tPhotoExists
end getPhoto
