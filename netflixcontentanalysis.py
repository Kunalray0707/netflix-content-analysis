# ============================================
# Netflix Data Analysis using Python
# ============================================

# Import Libraries
import pandas as pd
import matplotlib.pyplot as plt

# --------------------------------------------
# Load Dataset
# --------------------------------------------
df = pd.read_csv('data/netflix_titles.csv')

# Show first 5 rows
print("Dataset Preview:")
print(df.head())

# --------------------------------------------
# Basic Info
# --------------------------------------------
print("\nDataset Info:")
print(df.info())

# --------------------------------------------
# Data Cleaning
# --------------------------------------------

# Convert date_added to datetime
df['date_added'] = pd.to_datetime(df['date_added'], errors='coerce')

# Fill missing values
df['country'].fillna('Unknown', inplace=True)
df['director'].fillna('Unknown', inplace=True)

# --------------------------------------------
# 1. Top 10 Latest Movies
# --------------------------------------------
latest_movies = df[df['type'] == 'Movie'].sort_values(by='release_year', ascending=False).head(10)
print("\nTop 10 Latest Movies:")
print(latest_movies[['title', 'release_year']])

# --------------------------------------------
# 2. Count Shows by Type
# --------------------------------------------
type_count = df['type'].value_counts()
print("\nShows by Type:")
print(type_count)

# Plot
type_count.plot(kind='bar')
plt.title("Movies vs TV Shows")
plt.xlabel("Type")
plt.ylabel("Count")
plt.show()

# --------------------------------------------
# 3. Action Genre Shows
# --------------------------------------------
action_shows = df[df['listed_in'].str.contains('Action', na=False)]
print("\nAction Shows:")
print(action_shows[['title', 'type', 'release_year']].head())

# --------------------------------------------
# 4. Top 5 Countries
# --------------------------------------------
top_countries = df['country'].value_counts().head(5)
print("\nTop Countries:")
print(top_countries)

# Plot
top_countries.plot(kind='bar')
plt.title("Top 5 Countries")
plt.xlabel("Country")
plt.ylabel("Count")
plt.show()

# --------------------------------------------
# 5. Top Directors
# --------------------------------------------
top_directors = df['director'].value_counts().head(5)
print("\nTop Directors:")
print(top_directors)

# --------------------------------------------
# 6. TV Shows After 2018
# --------------------------------------------
tv_shows = df[(df['type'] == 'TV Show') & (df['release_year'] > 2018)]
print("\nRecent TV Shows:")
print(tv_shows[['title', 'release_year']].head())

# --------------------------------------------
# 7. Genre Count
# --------------------------------------------
genre_count = df['listed_in'].value_counts().head(10)
print("\nTop Genres:")
print(genre_count)

# --------------------------------------------
# 8. Movies Longer Than 150 Minutes
# --------------------------------------------

# Extract duration number
df['duration_num'] = df['duration'].str.extract('(\d+)').astype(float)

long_movies = df[(df['type'] == 'Movie') & (df['duration_num'] > 150)]
print("\nLong Movies:")
print(long_movies[['title', 'duration']].head())

# --------------------------------------------
# 9. Shows Added in 2020
# --------------------------------------------
shows_2020 = df[df['date_added'].dt.year == 2020]
print("\nShows Added in 2020:")
print(shows_2020[['title', 'date_added']].head())

# --------------------------------------------
# 10. Top Countries for Movies
# --------------------------------------------
movie_countries = df[df['type'] == 'Movie']['country'].value_counts().head(5)
print("\nTop Movie Countries:")
print(movie_countries)

print("\nAnalysis Completed ✅")
