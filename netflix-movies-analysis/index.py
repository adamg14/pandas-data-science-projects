# Importing pandas and matplotlib
import pandas as pd
import matplotlib.pyplot as plt

# Read in the Netflix CSV as a DataFrame
netflix_df = pd.read_csv("netflix_data.csv")

# most frequet movie duration in the 1990s
# filter for all the films in the ninties
ninties_films = netflix_df[(netflix_df["release_year"] >= 1990) & (netflix_df["release_year"] <= 1999)]
# use this filtered dataframe to calculate the modal duration
duration = int(ninties_films["duration"].mode())
print(duration)

# count the number of short action movies released in the ninties
# use the ninties movies dataframe defined above
# short action movies = under 90 minute duration and have the genre of action
# shape = rows x columns 
short_movie_count = ninties_films[(ninties_films["duration"] < 90) & (ninties_films["genre"] == "Action")].shape[0]
print(short_movie_count)