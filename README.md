# nrc_weka_r

## About
This repo was created for apply NRC lexicons to tweets using [AffectiveTweets](http://weka.sourceforge.net/packageMetaData/AffectiveTweets/index.html), which is a WEKA package for analyzing emotion and sentiment of English written tweets. AffectiveTweets was also made available as the official baseline system for the WASSA-2017 Shared Task on Emotion Intensity (EmoInt) by NRC- Canada.

The standard processure recommended by NRC is currently for Python only. For the need of our research with R, A wrapped R code was developed with AffectiveTweets in this repo.

### Prerequisites
* Download the latest stable [version](http://www.cs.waikato.ac.nz/ml/weka/downloading.html) (recommended for Windows user) or the  developer [branch](http://www.cs.waikato.ac.nz/ml/weka/snapshots/weka_snapshots.html) of Weka.
You can also build the developer branch from the SVN repository: 

```bash
svn co https://svn.cms.waikato.ac.nz/svn/weka/trunk/weka/
ant -f weka/build.xml exejar
```

* Install AffectiveTweets using the weka GUI [WekaPackageManager](http://weka.wikispaces.com/How+do+I+use+the+package+manager%3F) or by command-lin

```bash
java -cp weka.jar weka.core.WekaPackageManager -install-package AffectiveTweets
```

* (Optional) Install other useful packages for classification, regression and evaluation:

```bash
java -cp weka.jar weka.core.WekaPackageManager -install-package LibLINEAR
java -cp weka.jar weka.core.WekaPackageManager -install-package LibSVM
java -cp weka.jar weka.core.WekaPackageManager -install-package RankCorrelation
```
### Usage

* Open up 11_NRC_on_csv.r in R studio or whichever editor you feel comfortable. There is two input path you should change before runing the code. 

############################################################

folderpath = "C:/Users/zzz19/Documents/work/tweets/Weekly_tweets_Oct31_Nov06/"

output_folder = "C:/Users/zzz19/Documents/work/tweets/output/"

############################################################

* please change the folderpath to the path of folder contains tweets csv files. Note that avoid backslash in windows.
* please change the output_folder to the path of folder you want to store your results.

* The code will convert the original csv file to an ARFF file for weka to process then output the NRC result with 11 lexicons. 
THe result would have one column for original text and 43 columns for emotion scores and sentiment scores. Note that the order of the tweets won't change during the process, free feel to merge the results back to the original tweets files by index.
