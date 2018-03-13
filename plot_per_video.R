# Plot graphics of User Study experemetn per each video
# Manually:
# Change number in the name of file before .txt that corresponds to ID of video.
# Change 'title'
#install.packages("tidyverse")
#library(tidyverse)

dat1 <- data.frame(
  pos = factor(),
  start = double(),
  end = double()
)

for (num in 1:6) {
  
  # Change number in the name of file before .txt that corresponds to ID of video.
  file_name = paste("User",num,"4.txt",sep = '')
  print(file_name)
  
  video1 = read.table(file_name, sep = '\n')
  
  user_name = strsplit(as.character(video1[1,"V1"]), ",")[[1]]
  like_clicks_list = as.numeric(strsplit(as.character(video1[6,"V1"]), ",")[[1]])
  dislike_clicks_list = as.numeric(strsplit(as.character(video1[7,"V1"]), ",")[[1]])
  duration = as.numeric(strsplit(as.character(video1[5,"V1"]), ",")[[1]])
  
  
  if(dislike_clicks_list[1] > like_clicks_list[1] ){
    
    print(">")
    if(length(dislike_clicks_list) < length(like_clicks_list)) {
      dislike_clicks_list = c(dislike_clicks_list, duration)
    }
    
    
  } else if (as.numeric(dislike_clicks_list[1]) < as.numeric(like_clicks_list[1])) {
    
    print("<")
     
    like_clicks_list = c(0, like_clicks_list)
    if(length(like_clicks_list) > length(dislike_clicks_list)){
      dislike_clicks_list = c(dislike_clicks_list, duration)
    }
    
  } else {
    print("Weired")
    
  }
  
  print(user_name)
  dat = data.frame(
    pos = user_name,
    start = like_clicks_list,
    end = dislike_clicks_list
  )
  print(dat)
  
  
  dat$pos = factor(dat$pos)
  dat1 = rbind(dat1,dat)
  
}

library(ggplot2)
ggplot(dat1) + 
  geom_segment(aes(x=pos, y = start, yend=end, xend=pos), color="blue", size=3) +
  coord_flip() + labs(title= "Video 4, Brown Butter Pumpkin Tortellini | Byron Talbott, with audio, with caption") +
  labs(x = "", y = "Duration in seconds")

# title= "Video 1, Basil Ice Cream, muted, without caption"
# title= "Video 2, The BEST Carrot Cake, with audio, without caption"
# title= "Video 3, Pan-fried Salmon, Spanish rice with Cilantro Oil recipe, muted, with caption"
# title= "Video 4, Brown Butter Pumpkin Tortellini | Byron Talbott, with audio, with caption"
