
data(warpbreaks)
data(iris)

#First, let's load some packages! 
library(ggplot2)
library(dplyr)
library(gridExtra)
library(ggsignif)
library(png)


#Alright, let's jump into ggplot. 
ggplot(warpbreaks, aes( x = wool, y = breaks))+
  geom_boxplot()+
  geom_point() 


ggplot(warpbreaks, aes( x = wool, y = breaks, color = wool))+
  geom_violin(alpha = 0.4)+
  geom_jitter(width = 0.1, size = 2.5) + 
  stat_summary(fun = mean, geom = "point", shape = 2, size = 3, color = "black") +
  coord_flip() + 
  theme_bw()


ggplot(warpbreaks, aes( x = wool, y = breaks, color = wool))+
  geom_boxplot()+
  geom_jitter(width = 0.1, size = 2.5) + 
  stat_summary(fun = median, geom = "point", shape = 21, size = 3, fill = "black") +
  #fill vs color depending on shape
  #min, max, mean, median
  coord_flip() + 
  theme_bw()

a<- ggplot(warpbreaks, aes( x = wool, y = breaks))+
  geom_hline (yintercept = 25.25, linetype = "dashed", color = "grey")+
  geom_hline (yintercept = 31.03, linetype = "dashed", color = "grey")+
  geom_jitter(width = 0.1, size = 2.5, shape = 1, aes(color = wool)) + #let's talk about shapes!
  stat_summary(geom = "pointrange", #crossbar, errorbar
               fun.data = mean_cl_boot, 
               shape = 21, 
               fill = "white", 
               size = 0.8)+ 
  #https://rstudio-pubs-static.s3.amazonaws.com/3358_2def158be48047a6944bfcc60ea08f1b.html
  scale_x_discrete(labels = c("Acrlyic", "Llhama"))+
  scale_y_continuous(breaks = seq(0, 70, by = 10))+
  xlab("Wool Type")+
  ylab("Number of times yarn breaks (count)")+
  #fill vs color depending on shape
  #min, max, mean, median
  coord_flip() + 
  theme_bw()+
  #let's work with color
  scale_color_manual(values = c("#8d6502", "#e69f00"),  #note color vs fill
                     name = c("Wool Type"), #Legend Title
                     labels = c("Acrlyic", "Llhama")) #Factor title2


#how to find data from mean_cl_boot
#first, save ggplot as an object
a

#then check it out!
#this will give you the actual calculated numbers that ggplot did for you, 
#which are both interesting and important to check that ggplot did it correctly
b <- ggplot_build(a)
b


#Now, let's amp some stuff up and play with this iris data!

data("iris")
###################
### IRIS ----
###################
#there are three directions we can go here
ggplot(iris, aes( x = Sepal.Length, y = Sepal.Width, color = Species))+
  geom_point() # I like this one bests´data


ggplot(iris, aes( x = Petal.Length, y = Petal.Width, color = Species))+
  geom_point()

ggplot(iris, aes( y = Sepal.Length,  x= Species))+
  geom_point()


#Let's see what's going on!

iris$Species<- recode(iris$Species, 
                      setosa = "Setosa", 
                      versicolor = "Versicolor", 
                      virginica = "Virginica")

ggplot(iris, aes( x = Sepal.Length, y = Sepal.Width, color = Species))+
  geom_point(size = 3, shape = 16, alpha = 0.4) + 
  geom_point(size = 3, shape = 1, alpha = 0.5, color = "black") + 
  ylab("Sepal Width")+
  xlab("Sepal Length")+
  #look at what happens when I switch between color and fill
  stat_smooth(method = "glm", fill= "lightgrey", #lm, loess
              formula = y~ x, fullrange = F)+  #log(x), poly(x, 3); fullrange F/T
  facet_wrap(~ Species, scales = "free_x") + #scales = "free_y" or "free"
  theme_bw(base_family = "Times") + #change the text everywhere
  theme(
    legend.position = "none",
    axis.title = 
      element_text(size = 12),
    strip.background = element_rect(fill = "#fff7e5", linetype = "dotted"),
    strip.text= element_text(
                             size = 12, 
                             face = "bold", 
                             color = "#ca6e00")) + 
  scale_color_manual(values = c("#ec94ff", "#d64b80", "#b1e37e"))

#now do a violin dist/sina----
#insert significance stars!


#let's get some pictues in here
getwd()
img <- readPNG("iris1.png")
i1 <- grid::rasterGrob(img, interpolate = T)


ggplot(iris, aes(x = Species, y = Petal.Length))+
  geom_violin(fill = "lightgrey", aes(color = Species),
              size = 0.2, alpha = 0.2)+
  geom_sina(alpha = 0.4, size = 2.5, 
            shape = 21, 
            aes(fill = Species))+ 
  geom_signif(comparisons = list(c("Virginica", "Setosa")), map_signif_level = T)+
  geom_signif(comparisons = list(c("Versicolor", "Setosa")), 
              y_position = 5.5, map_signif_level = T)+
  #sina functions where the width 
  #of the jitter is controlled by the density distribution of the data
  theme_bw()+
  theme(legend.position = "none", 
        text = element_text(size = 14))+
  ylab("Petal Length (cm)")+
  annotation_custom(i1, 
                    ymin = 1.5, 
                    ymax = 3.5, 
                    xmin =1.75, 
                    xmax = 4)+
  scale_fill_manual(values = c("#ec94ff", "#d64b80", "#b1e37e"))+
  scale_color_manual(values = c("#ec94ff", "#d64b80", "#b1e37e"))

  


iris <- iris %>%
         group_by(Species) %>%
         mutate(grp.mean = mean(Sepal.Length))


#density plot
ggplot(iris, aes( x = Sepal.Length, fill = Species))+
  geom_density(alpha = 0.3) +
  geom_vline(aes(xintercept = grp.mean), 
             linetype = "dashed", 
             color = "darkgrey")+
  labs(x = " Sepal Length (cm)", y = "Density")+
  scale_fill_brewer(palette="Dark2") +
  annotate("text", x = 5.5, y = 1, label = "Setosa", 
           color = "darkgreen")+
  annotate("text", x = 6.19, y = 0.75, label = "Versicolor", 
           color = "orange")+
  annotate("text", x = 6.85, y = 0.75, label = "Virginica", 
           color = "purple")+
  theme_bw()+
  theme(legend.position = "none", 
        text = element_text(size = 14))


