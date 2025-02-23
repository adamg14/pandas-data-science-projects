# Re-run this cell 
import pandas as pd
import numpy as np

# Read in the data
schools = pd.read_csv("schools.csv")

# Preview the data
print(schools.head())

# Which NYC schools have the best math results?
best_math_schools = schools[schools["average_math"] >= 800*0.8][["school_name", "average_math"]].sort_values("average_math", ascending=False)

schools["total_SAT"] = schools["average_math"] + schools["average_reading"] + schools["average_writing"]

# What are the top 10 performing schools based on the combined SAT scores?
top_10_schools = schools.sort_values("total_SAT", ascending=False)[["school_name", "total_SAT"]]
top_10_schools = top_10_schools.iloc[:10]

print(top_10_schools.head())

# Which single borough has the largest standard deviation in the combined SAT score?
borough_stats = schools.groupby("borough")["total_SAT"].agg(['count', np.mean, np.std,])
borough_stats = borough_stats.round(2)
borough_stats = borough_stats.reset_index()
borough_stats.columns = "borough", "num_schools", "average_SAT", "std_SAT"
borough_stats.sort_values("std_SAT", ascending=False)
largest_std_dev = borough_stats[borough_stats["std_SAT"] == borough_stats["std_SAT"].max()]

print(largest_std_dev)
