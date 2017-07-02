############################################################
folderpath = "C:/Users/zzz19/Documents/work/tweets/Weekly_tweets_Oct31_Nov06/"
output_folder = "C:/Users/zzz19/Documents/work/tweets/output/"
############################################################

#temp folder
temp = "c:/temp/"
weka_path = "\"C:\\Program Files\\Weka-3-8\\weka.jar\""

#the function clean_tweets()
clean_tweets = function(Tweets) {
  Tweets$cleaner_Tweet = gsub("&amp", "", Tweets$text)
  Tweets$cleaner_Tweet = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", Tweets$cleaner_Tweet)
  Tweets$cleaner_Tweet = gsub("http\\w+", "", Tweets$cleaner_Tweet)
  Tweets$cleaner_Tweet = gsub("[ \t]{2,}", "", Tweets$cleaner_Tweet)
  Tweets$cleaner_Tweet = gsub("^\\s+|\\s+$", "", Tweets$cleaner_Tweet) 
  Tweets$cleaner_Tweet = gsub("@\\w+", "", Tweets$cleaner_Tweet)
  Tweets$cleaner_Tweet = gsub("[[:punct:]]", "", Tweets$cleaner_Tweet)
  Tweets$cleaner_Tweet = gsub("[[:digit:]]", "", Tweets$cleaner_Tweet)
  Tweets$cleaner_Tweet = gsub("\n", " ", Tweets$cleaner_Tweet)
  Tweets$cleaner_Tweet = gsub("^\\s+", "", Tweets$cleaner_Tweet)  
  Tweets$cleaner_Tweet <- str_replace_all(Tweets$cleaner_Tweet," "," ")
  Tweets$cleaner_Tweet <- str_replace(Tweets$cleaner_Tweet,"RT @[a-z,A-Z]*: ","")
  Tweets$cleaner_Tweet <- str_replace_all(Tweets$cleaner_Tweet,"#[a-z,A-Z]*","")
  Tweets$cleaner_Tweet <- str_replace_all(Tweets$cleaner_Tweet,"@[a-z,A-Z]*","")
  return(Tweets)
}

#convert csv to arff specific for election tweets
csv_to_arff = function(input_file, output_file){
  df = read.csv(filepath,colClasses = c("text"="character"))
  df$text = gsub("\n", " ", df$text)
  v_df = as.vector(df["text"])
  #write header
  fileConn<-file(output_file)
  writeLines(c(paste("@relation ","\"","h_florida","\"",sep = ""),
             "@attribute content string",
             "@data"
              ), fileConn)
  close(fileConn)
  #write body
  write.table(v_df, output_file, append = TRUE, row.names = FALSE, col.names = FALSE)
}

#call 11 nrc lexicons
nrc_lexicons = function(input_filepath,output_filepath, weka_path){
  exec = "java -Xmx4G -cp %3 weka.Run weka.filters.unsupervised.attribute.TweetToLexiconFeatureVector -i %1 -I 1 -A -D -F -H -J -L -N -P -Q -R -T -U -o C:\\temp\\weka.arff
java -Xmx4G -cp %3 weka.Run weka.core.converters.CSVSaver -i C:\\temp\\weka.arff -o %2"
  write(exec,"./weka_nrc.bat")
  system(paste("./weka_nrc.bat",input_filepath, output_filepath, weka_path, sep = " "))
}

#parse file name
parse_filename = function(filename){
  file_split   = strsplit(filename,"_")[[1]]
  metadata     = data.frame(week = file_split[3],
                          Candidate = substr(file_split[2],2,nchar(file_split[2])),
                          State = file_split[4],
                          Situation = file_split[5])
  return(metadata)
}


#main
files = list.files(folderpath)
for (file in files) {
  filepath = paste(folderpath,file,sep = "")
  #metadata = parse_filename(file)
  csv_to_arff(filepath, paste(temp,sub("\\.csv", ".arff", file),sep = ""))
  nrc_lexicons(paste(temp,sub("\\.csv", ".arff", file),sep = ""), paste(output_folder,"nrc_",file,sep = ""), weka_path)
}




