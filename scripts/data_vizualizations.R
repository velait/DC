# Plottings
library(tidyverse)

surveys_complete <- read_csv("data/surveys_complete.csv")


# base
ggplot(surveys_complete, aes(x=weight, y=hindfoot_length)) + geom_point()

# colored + fit
ggplot(surveys_complete, aes(x=log(weight), y=hindfoot_length)) + geom_point(aes(x=log(weight), y=hindfoot_length, color=species), size=0.1) + geom_smooth(method="lm")

                                                                 

ggplot(surveys_complete, aes(x=log(weight), y=hindfoot_length)) + geom_point(alpha=0.1, aes(color=species))


# Use what you just learned to create a scatter plot of weight (y-axis) over species_id (x-axis) with the plot types showing in different colors. Is this a good way to show this type of data? 

surveys_complete$plot_id <- factor(surveys_complete$plot_id)

ggplot(surveys_complete, aes(y=weight, x=species_id)) + geom_point(alpha=0.4, aes(color=plot_id))


# box
ggplot(surveys_complete, aes(y=log(weight), x=species_id)) + geom_jitter(alpha=0.3, size=0.5, aes(color=plot_id)) + geom_boxplot(outlier.size = 0.2) 


# Challenges
# Boxplots are useful summaries, but hide the shape of the distribution. For example, if the distribution is bimodal, we would not see it in a boxplot. An alternative to the boxplot is the violin plot, where the shape (of the density of points) is drawn.

ggplot(surveys_complete, aes(y=weight, x=species_id)) + geom_violin() + scale_y_log10()

# In many types of data, it is important to consider the scale of the observations. For example, it may be worth changing the scale of the axis to better distribute the observations in the space of the plot. Changing the scale of the axes is done similarly to adding/modifying other components (i.e., by incrementally adding commands). Try making these modifications:
#   Represent weight on the log10 scale; see scale_y_log10().
   
ggplot(surveys_complete, aes(y=weight, x=species_id)) + geom_violin() + scale_y_log10()

# So far, we’ve looked at the distribution of weight within species. Try making a new plot to explore the distribution of another variable within each species.
 
# Create a boxplot for hindfoot_length. Overlay the boxplot layer on a jitter layer to show actual measurements.
# Add color to the data points on your boxplot according to the plot from which the sample was taken (plot_id).

ggplot(surveys_complete, aes(y= hindfoot_length, x= species_id)) + geom_boxplot() + geom_jitter(width = 0.1, size=0.2, aes(color=plot_id))



##########

yearly_count <- surveys_complete %>%
  group_by(year, species_id) %>% 
  tally()

ggplot(yearly_count, aes(x=year, y=n)) + geom_line()

ggplot(yearly_count, aes(x=year, y=n, group=species_id, color=species_id)) + geom_line()


ggplot(data=yearly_count, aes(x=year, y=n)) + geom_line() + facet_wrap(~ species_id)


# add sexes to count
yearly_sex_counts <- surveys_complete %>%
  group_by(year, species_id, sex) %>% 
  tally()

ggplot(yearly_sex_counts, aes(x=year, y=n, color=sex)) + geom_line() + facet_wrap(~species_id) + theme_bw() + grey_theme + labs(title="Observed species over time", x="Year", y="Number of observations")

grey_theme <- theme(panel.grid = element_blank(), text= element_text(size=16), axis.text.x = element_text(color="grey20", size=12, angle=90, hjust=0.5, vjust=0.5))



# With all of this information in hand, please take another five minutes to either improve one of the plots generated in this exercise or create a beautiful graph of your own. Use the RStudio ggplot2 cheat sheet for inspiration. Here are some ideas:
#   See if you can change the thickness of the lines.
# Can you find a way to change the name of the legend? What about its labels?
#   Try using a different color palette (see http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/).



monthly_count <- surveys_complete %>%
  group_by(month, species_id) %>% 
  tally()


p <- ggplot(monthly_count, aes(x=month, y=n, group=species_id, color=species_id)) + geom_line() + facet_wrap(~ species_id)+ labs(title="Observed species over time", x="Months", y="Number of observations") + grey_theme

#save
ggsave("plots/my_first_plot.png", p, width=15, height=10, dpi=300)
