# Plot graphics of User Study experemetn per each video
# Manually:
# Change number in the name of file before .txt that corresponds to ID of video.
# Change 'title'
# install.packages g('ggplot', dep = TRUE)
library(ggplot2)
dat1 <- data.frame(
  pos = factor(),
  start = double(),
  end = double()
)

var_list = list()

for (num in 1:4) {
  
  # Change number in the name of file before .txt that corresponds to ID of video.
  file_name = paste("User6",num,".txt",sep = '')
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
    pos = paste("Video ",num),
    start = like_clicks_list,
    end = dislike_clicks_list
  )
  print(dat)
 
  dat$pos = factor(dat$pos)
  dat1 = rbind(dat1,dat)
  
}

ggplot(dat1) + 
  geom_segment(aes(x=pos, y = start, yend=end, xend=pos), color="blue", size=3) +
  coord_flip() +   ggtitle("User 6") +
  theme(plot.title = element_text(hjust = 0.5))+
  labs(x = "", y = "Duration in seconds")


