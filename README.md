# Capstone
This is my repository for my MSBA 2022 Capstone project at the University of Montana.
The flow of the project goes Twitter Demographics -> Spotify Dataset -> Lyrical Analysis -> Popularity Regression
The Twitter Demographics file serves on its own.
Here I pull data from Twitter to collect demographic information on Fantasy Records' new band. The collection starts with locations then move into genderss


The Spotify Dataset file creates a dataset of songs from artists related to the ones that make up the new band. That dataset is defined in a data dictionary then written to a csv that is used in the Lyrical Analysis file
The Lyrical Analysis file is where I do most of my analytical work. I clean the data, visualize relationships, etc. I write out two file called "songs_transformed.csv" and "genre_subset.csv" that are used in the popularity_regression R file

The Popularity Regression file develops a model that briefly covers the significant relationships among the data
