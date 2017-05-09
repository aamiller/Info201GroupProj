# Info201GroupProj

## Project Description
__Data Set__ : Bechdel Tests of movies from [FiveThirtyEight](https://github.com/fivethirtyeight/f/blob/master/bechdel/movies.csv)

##### Background of Data Set
This data was collected by FiveThirtyEight. There is not much information available from them about the dataset. We accessed it using FiveThirtyEight's github folder full of public .csv (_c_omma _s_eparated _v_alue) files. 
##### Note: The data only goes up to 2013.
##### What is a Bechdel Test?
According to [bechdeltest.com](http://bechdeltest.com/), the Bechdel Test, sometimes called the _Mo Movie Measure_ or _Bechdel Rule_ is a simple test which names the following three criteria: (1) it has to have at least two women in it, who (2) who talk to each other, about (3) something besides a man. The test was popularized by Alison Bechdel's comic _Dykes to Watch Out For_, in a 1985 strip called _The Rule_. 

The Bechdel Test has since become relatively well known and is often referenced in movie reviews. It has become a rather embarassing test to fail, though many movies do fail it. 

#### Audiences for this project
Our main audience are people who are critical of movies that fail the Bechdel Test and are interested in learning what trends there are in movies being better or worse at the test. We hope by showing these trends that people will be more critical of movies that are likely to fail the Bechdel Test based on the trends they align with. 

##### Questions that will be investigated
This project will answer the question of whether or not the budget of the movie increases the chance of passing or failing the test.
It will also answer the question of how the profit the movie makes can or cannot predict the chance of passing or failing the test.
Lastly, it will answer the question of how the year the movie was made effects the chance of passing or failing the test.


## Technical Description
__Format of Project:__ Shiny.io or HTML page (probably)
__Format of Data Read in:__ .csv file
__Major Libraries Used:__ Plotly, dplyr, ggplot2, knitr

#### Data Wrangling Needed
This data is already pretty well formatted. We may need to edit ascii for some titles that are displaying unicode. They also show an IMDB ID, which might lead to editing using the IMDB API.

#### Questions to be Answered with Statistical Analysis:
See above "questions that will be investigated."

#### Anticipated Major Challenges
The scope of our data is not massive, as it has about 1800 lines of data and some years do not have many movies. We may have to narrow down our scope to a few years where there is a lot of data.
