library(tidyverse)

sleep<-read_csv("data/Sleep_health_and_lifestyle_dataset.csv")

glimpse(sleep)

head(sleep)

#Descriptive Statistic

sleep %>% 
  summarise(
    n = n(),
    avg_age = mean(Age, na.rm = TRUE),
    avg_sleep = mean(`Sleep Duration`, na.rm = TRUE),
    avg_stress = mean(`Stress Level`, na.rm = TRUE),
    avg_activity = mean(`Physical Activity Level`, na.rm = TRUE)
     )

sleep %>%
  count(Gender)

sleep %>%
  count(`Sleep Disorder`)

sleep %>%
  count(`BMI Category`)

# Factors represent categorical data (e.g., Gender, Occupation, Sleep Disorder).
# Using factors helps R treat categorical variables correctly in analysis and visualization.
sleep <- sleep %>%
  mutate(
    Gender = as.factor(Gender),
    Occupation = as.factor(Occupation),
    SleepDisorder = as.factor(`Sleep Disorder`),
  )

#Visualization

# Sleep Duration
sleep %>%
  ggplot(aes(x = `Sleep Duration`)) +
  geom_histogram(
    bins = 20,
    fill = "#2AB7CA",      
    color = "white",
    alpha = 0.8
  ) +
  labs(
    title = "Distribution of Sleep Duration",
    x = "Hours",
    y = "Count"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    panel.grid.major = element_line(color = "#E5E5E5"),
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold"),
    axis.title = element_text(face = "bold")
  )



# Quality of Sleep (scale: 1-10): A subjective rating of the quality of sleep, ranging from 1 to 10.
sleep %>%
  ggplot(aes(x = `Quality of Sleep`)) +
  geom_bar(
    fill = "#2AB7CA",   
    color = "white",
    alpha = 0.85
  ) +
  stat_count(
    geom = "text",
    aes(label = ..count..),
    vjust = -0.4,
    color = "#333333",
    size = 4,
    fontface = "bold"
  )+
  labs(
    title = "Quality of Sleep",
    x = "Score",
    y = "Count"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    panel.grid.major = element_line(color = "#E5E5E5"),
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold"),
    axis.title = element_text(face = "bold")
  )

# Sleep Duration by Gender
sleep %>%
  ggplot(aes(x = Gender, y = `Sleep Duration`, fill = Gender)) +
  geom_boxplot(
    fill = "#2AB7CA",        
    color = "#444444",       
    alpha = 0.8,
    linewidth = 1
  ) +
  scale_fill_manual(values = c("#2AB7CA", "#77D1E5")) +
  labs(
    title = "Sleep Duration by Gender",
    x = "Gender",
    y = "Sleep Duration (hours)"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "none",
    panel.grid.major = element_line(color = "#E5E5E5"),
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold"),
    axis.title = element_text(face = "bold")
  )




# Stress Level (scale: 1-10): A subjective rating of the stress level experienced by the person, ranging from 1 to 10.
sleep %>%
  ggplot(aes(x = `Stress Level`)) +
  geom_histogram(
    bins = 10,
    fill = "#FF6F61",     
    color = "white",
    alpha = 0.85
  ) +
  stat_bin(
    bins = 10,
    geom = "text",
    aes(label = ..count..),
    vjust = -0.4,
    color = "#333333",
    size = 4,
    fontface = "bold"
  ) +
  labs(
    title = "Stress Level Distribution",
    x = "Stress Level",
    y = "Count"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    panel.grid.major = element_line(color = "#E5E5E5"),
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold"),
    axis.title = element_text(face = "bold")
  )


#Correlation
numeric_vars <- sleep %>%
  select(`Sleep Duration`, `Quality of Sleep`, `Stress Level`, `Physical Activity Level`,`Daily Steps`, Age)

cor_matrix <- cor(numeric_vars, use = "complete.obs")
cor_matrix

install.packages("reshape2")
library(reshape2)
library(ggplot2)

cor_melt <- melt(cor_matrix)

ggplot(cor_melt, aes(Var1, Var2, fill = value)) +
  geom_tile(color = "white") +
  geom_text(aes(label = round(value, 2)), color = "#333333", size = 4, fontface = "bold") +
  scale_fill_gradient2(
    low = "#FF6F61",      
    mid = "white",
    high = "#2AB7CA",     
    midpoint = 0
  ) +
  theme_minimal(base_size = 14) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, face = "bold"),
    axis.text.y = element_text(face = "bold"),
    plot.title = element_text(face = "bold")
  ) +
  labs(title = "Correlation Matrix", x = "", y = "")



#Relationships

sleep %>%
  ggplot(aes(x = `Daily Steps`, y = `Quality of Sleep`)) +
  geom_point(
    alpha = 0.6,
    color = "#2AB7CA",      
    size = 3
  ) +
  geom_smooth(
    method = "lm",
    se = FALSE,
    color = "#FF6F61",      
    linewidth = 1.2
  ) +
  labs(
    title = "Relationship Between Daily Steps and Sleep Quality",
    x = "Daily Steps",
    y = "Quality of Sleep (1–10)"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    panel.grid.major = element_line(color = "#E5E5E5"),
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold"),
    axis.title = element_text(face = "bold")
  )


sleep %>%
  ggplot(aes(x = `Stress Level`, y = `Quality of Sleep`)) +
  geom_point(
    alpha = 0.6,
    color = "#2AB7CA",
    size = 3
  ) +
  geom_smooth(
    method = "lm",
    se = FALSE,
    color = "#FF6F61",
    linewidth = 1.2
  ) +
  labs(
    title = "Relationship Between Stress Level and Sleep Quality",
    x = "Stress Level",
    y = "Quality of Sleep (1–10)"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    panel.grid.major = element_line(color = "#E5E5E5"),
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold"),
    axis.title = element_text(face = "bold")
  )


#Sleep Duration vs Stress Level

sleep %>%
  ggplot(aes(x = `Stress Level`, y = `Sleep Duration`)) +
  geom_point(color = "#FF6F61", alpha = 0.7, size = 3) +
  geom_smooth(method = "lm", color = "#2AB7CA", se = FALSE, linewidth = 1.2) +
  theme_minimal(base_size = 14) +
  theme(
    panel.grid.major = element_line(color = "#E5E5E5"),
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold"),
    axis.title = element_text(face = "bold")
  ) +
  labs(
    title = "Stress vs Sleep Duration",
    x = "Stress Level",
    y = "Sleep Duration (hours)"
  )


# Sleep Duration vs Physical Activity Level

sleep %>%
  ggplot(aes(x = `Physical Activity Level`, y = `Sleep Duration`)) +
  geom_point(
    alpha = 0.6,
    color = "#2AB7CA",
    size = 3
  ) +
  geom_smooth(
    method = "lm",
    se = FALSE,
    color = "#FF6F61",
    linewidth = 1.2
  ) +
  labs(
    title = "Sleep Duration vs Physical Activity Level",
    x = "Physical Activity Level",
    y = "Sleep Duration (hours)"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    panel.grid.major = element_line(color = "#E5E5E5"),
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold"),
    axis.title = element_text(face = "bold")
  )





sleep %>%
  group_by(`Sleep Disorder`) %>%
  summarise(
    avg_sleep = mean(`Sleep Duration`, na.rm = TRUE),
    avg_quality = mean(`Quality of Sleep`, na.rm = TRUE),
    avg_stress = mean(`Stress Level`, na.rm = TRUE),
    n = n()
  )

counts <- sleep %>%
  count(`Sleep Disorder`)
View(counts)
counts

sleep %>%
  ggplot(aes(x = `Sleep Disorder`, y = `Sleep Duration`)) +
  geom_boxplot(
    fill = "#2AB7CA",        
    color = "#444444",       
    alpha = 0.8,
    linewidth = 1
  ) +
  labs(
    title = "Sleep Duration by Sleep Disorder",
    x = "Sleep Disorder",
    y = "Sleep Duration (hours)"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    panel.grid.major = element_line(color = "#E5E5E5"),
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold"),
    axis.title = element_text(face = "bold")
  )




