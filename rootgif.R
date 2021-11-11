# 1.Load packages
library("dplyr")
library("magick")
library("purrr") 

#---------------------------------------------------------
# 2. Set working directory
setwd("C:/Users/Kaining/BGU ZKN/R/MR data analysis with R/prepareimagesforrootfly/cam3_gif/056_1005")

# 3. Rename: reverse image number in order to stitch in correct order later
file.rename(list.files(pattern = ".jpg"), paste0("Pepperauto_T003_L",sprintf("%03d",length(list.files(pattern = ".jpg")):1), ".jpg"))

# 4. Resize: make the dimension same as Bartz MR (640*480 pixels)
listoffiles <- list.files(path = "C:/Users/Kaining/BGU ZKN/R/MR data analysis with R/prepareimagesforrootfly/cam3_gif/056_1005",
                          full.names = TRUE) # Each time change the path of image folder 

for(i in seq_along(listoffiles)) {
  
  imfile <- image_read(listoffiles[i])
  
  resized <- image_scale(imfile, "640")
  
  image_write(resized, paste(listoffiles[i]))
  
}

# 5. change working directory
setwd("C:/Users/Kaining/BGU ZKN/R/MR data analysis with R/prepareimagesforrootfly/cam3_gif")

# 6. Stitch images for first 10 windows
pics <- dir("C:/Users/Kaining/BGU ZKN/R/MR data analysis with R/prepareimagesforrootfly/cam3_gif/056_1005", full.names = TRUE)
length_size <- length(pics)
pics[1:length_size] %>%
  image_read() %>%
  image_append(stack = TRUE) %>%
  image_write("cam3_w10_1005.jpg")
#----------------------------------------------------------
# Note: repeat what's inside two dash lines for other image folders


# 7. make .gif root animation (for cam3, first 10 windows)
cam3_w10_gif <- list.files(path = "C:/Users/Kaining/BGU ZKN/R/MR data analysis with R/prepareimagesforrootfly/cam3_gif", pattern = "*.jpg", full.names = T) %>% 
  map(image_read) %>% 
  image_join() %>% 
  image_annotate("Galiano with fertilizer at soil depth 0-10cm: 2021.08.15 - 2021.10.15", location = "+10+10", size = 20, color = "white") %>%
  image_animate(fps=1) %>% 
  image_write("cam3_w10.gif") 

