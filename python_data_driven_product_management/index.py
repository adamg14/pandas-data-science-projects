import pandas as pd
import matplotlib.pyplot as plt


# When was the global search for 'workout' at its peak?
workout_search = pd.read_csv('data/workout.csv')
plt.figure(figsize=(12, 6))
plt.plot(workout_search["month"], workout_search["workout_worldwide"])
plt.xticks(rotation=90)
plt.show()
plt.close()

# from the figure defined about the year for the global peak search of 'workout' is 2020
year_str = '2020'


# Of the keywords available, what was the most popular during the covid pandemic, and what is the most popular now?
keywords_df = pd.read_csv("data/three_keywords.csv")

print(keywords_df)

plt.plot(keywords_df["month"], keywords_df["home_workout_worldwide"], label="home_workout")
plt.plot(keywords_df["month"], keywords_df["gym_workout_worldwide"], label="gym_workout")
plt.plot(keywords_df["month"], keywords_df["home_gym_worldwide"], label="home_gym")
plt.xticks(rotation=90)
plt.legend(title="Regions", loc="upper left")
plt.show()
plt.close()
# from the visualisation about
# the most popular keyword search duing the covid pandemic:
peak_covid = 'home_workout'
# the current most popular keyword search:
current = 'home_gym'


# What country has the highest interest for workouts among the following: United States, Australia, or Japan?
workout_country_df = pd.read_csv("data/workout_geo.csv", index_col=0)
print("United States: ", str(workout_country_df.loc["United States"]))
print("Australia: ", workout_country_df.loc["Australia"])
print("Japan: ", workout_country_df.loc["Japan"])

# from the countries located in the data frame, the highest interest in workouts came from America
top_country = "United States"


# You'd be interested in expanding your virtual home workouts offering to either the Philippines or Malaysia. Which of the two countries has the highest interest in home workouts?
keywords_country_df = pd.read_csv("data/three_keywords_geo.csv", index_col=0)
philippines_home_workout = keywords_country_df.loc["Philippines", :]["home_workout_2018_2023"]
malaysia_home_workout = keywords_country_df.loc["Malaysia", :]["home_workout_2018_2023"]
print("Philippines: ", str(philippines_home_workout))
print("Malaysia: ", str(malaysia_home_workout))
# based off the information the best conutry to expand virtual home workouts offering is Philippines
home_workout_geo = "Philippines"