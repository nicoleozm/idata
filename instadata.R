# install packages
library("data.table")
library("ggplot2")

# create working directory path
path_base <- getwd()
folder_name <- "insta_data"
# data <- (data folder, doesn't exist yet)

# bring in data
instaData <- fread(paste(path_base, folder_name, 'jun_30_instadata.csv', sep = '/'), sep = ',', header = TRUE)

# mess with the data
instaData[instaData$day_of_week=='wednesady']$day_of_week <- "wednesday"
instaData$date_number <- as.numeric(substr(instaData$date_posted,4,5))
instaData$month <- as.numeric(substr(instaData$date_posted, 1, 2))
instaPortraits <- instaData[portrait_v_landscape=='portrait']
instaPortraits$nonHumanPortrait <- ifelse(instaPortraits$num_people==0, 1, 0)

# observe relationships
# no people has fewer than any other number. Evidence to interace
# num people with portrait to get whether it's a human portrait or not
ggplot(data = instaData, aes(x = num_people, y = num_likes)) + geom_point()

# looks like slightly fewer likes for non human portraits,
# way higher variance for human portraits
ggplot(data = instaPortraits, aes(x = nonHumanPortrait, y = num_likes)) + geom_point()

# CLEAR TREND NARCISISM: the ones that include me have more likes. Probs
# the only clear relationship I've seen thus far
ggplot(data = instaData, aes(x = includes_me, y = num_likes)) + geom_point()

# sunday posts maybe have more likes, definitely have higher variance
ggplot(data = instaData, aes(x = day_of_week,y = num_likes)) + geom_point()

# portraits have higher variance than landscape and maybe higher num likes
# should think about separating people portraits from food portraits
ggplot(data = instaData, aes(x = portrait_v_landscape, y = num_likes)) + geom_point()

# there is a clear time trend 
ggplot(data = instaData, aes(x = month, y = num_likes)) + geom_point()