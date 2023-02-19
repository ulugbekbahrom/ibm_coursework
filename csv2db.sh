# This script
# Extracts data from /etc/passwd file into a CSV file.

# The csv data file contains the user name, user id and 
# home directory of each user account defined in /etc/passwd

# Transforms the text delimiter from ":" to ",".
# Loads the data from the CSV file into a table in PostgreSQL database.

# extract phase
echo "Extracting data"

# extract columns 1 (user name), 3 (user id) and
# 6 (home directory path) from /etc/passwd
cut -d":" -f1,3,6 /etc/passwd > extracted-data.txt

# transform phase
echo "Transforming data"

# read the extracted data and replace the colons with commas.
tr ":" "," < extracted-data.txt > transformed-data.csv

# load phase
echo "Loading data"

# send the instructions to connect to 'template1' and
# copy the file to the table 'users' thoruhg command pipeline.
echo "\c template1;\COPY users FROM '/home/project/transformed-data.csv' DELIMITERS ',' CSV;" | psql --username=postgres --host=localhost
