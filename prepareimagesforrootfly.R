# 1. Set working directory
setwd("C:/Users/Kaining/BGU ZKN/R/MR data analysis with R/prepareimagesforrootfly/rootimage_changed")

# 2.Load packages
library("dplyr")
library("magick")

# 3. Rename: 
# (1) Reverse image number in order to stitch in correct order later
# (2) Add other parameters to meet name requirement of Rootfly
file.rename(list.files(pattern = ".jpg"), paste0("Pepperauto_T003_L",sprintf("%03d",length(list.files(pattern = ".jpg")):1), "_2021.10.15_001.jpg"))

# 4. Resize: make the dimension same as Bartz MR (640*480 pixels)
listoffiles <- list.files(path = "C:/Users/Kaining/BGU ZKN/R/MR data analysis with R/prepareimagesforrootfly/rootimage_changed",
                          full.names = TRUE) # Each time change the path of image folder 

for(i in seq_along(listoffiles)) {
  
  imfile <- image_read(listoffiles[i])
  
  resized <- image_scale(imfile, "640")
  
  image_write(resized, paste(listoffiles[i]))
  
}

# 5. Stitch images
pics <- dir("C:/Users/Kaining/BGU ZKN/R/MR data analysis with R/prepareimagesforrootfly/rootimage_changed", full.names = TRUE)
length_size <- length(pics)
pics[1:length_size] %>%
  image_read() %>%
  image_append(stack = TRUE) %>%
  image_write("stitched_image.jpg")
