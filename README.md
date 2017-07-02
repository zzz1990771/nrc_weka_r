# nrc_weka_r

## About
This repo was created for apply NRC lexicons to tweets using [AffectiveTweets](http://weka.sourceforge.net/packageMetaData/AffectiveTweets/index.html), which is a WEKA package for analyzing emotion and sentiment of English written tweets. AffectiveTweets was also made available as the official baseline system for the WASSA-2017 Shared Task on Emotion Intensity (EmoInt) by NRC- Canada.

The standard processure recommended by NRC is currently for Python only. For the need of our research with R, A wrapped R code was developed with AffectiveTweets in this repo.

### Prerequisites
* Download the latest stable [version](http://www.cs.waikato.ac.nz/ml/weka/downloading.html) or the  developer [branch](http://www.cs.waikato.ac.nz/ml/weka/snapshots/weka_snapshots.html) of Weka.
You can also build the developer branch from the SVN repository: 

```bash
svn co https://svn.cms.waikato.ac.nz/svn/weka/trunk/weka/
ant -f weka/build.xml exejar
```

* Install AffectiveTweets using the [WekaPackageManager](http://weka.wikispaces.com/How+do+I+use+the+package+manager%3F): 

```bash
java -cp weka.jar weka.core.WekaPackageManager -install-package AffectiveTweets
```

* (Optional) Install other useful packages for classification, regression and evaluation:

```bash
java -cp weka.jar weka.core.WekaPackageManager -install-package LibLINEAR
java -cp weka.jar weka.core.WekaPackageManager -install-package LibSVM
java -cp weka.jar weka.core.WekaPackageManager -install-package RankCorrelation
```
