# download log file 
wget 'https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz'

# unzip file
gunzip -f web-server-access-log.txt.gz

# e
echo "extract"
cut -d"#" -f1-4 web-server-access-log.txt > extract-log.txt

# t
echo "transform"
tr "#" "," < extract-log.txt > transform-log.csv

# l
echo "load"
echo "\c template1;\COPY access_log FROM '/home/project/transform-log.csv' DELIMITERS ',' CSV HEADER;" | psql --username=postgres --host=localhost
