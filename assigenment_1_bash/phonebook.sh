#!/bin/bash

if [ -f "phonebookDB.txt" ]
then
 echo ""
else
 cd \Documents
 touch phonebookDB.txt
fi
case $1 in
"-i")echo "ADD NEW CONTACT"
 read -p "Enter First Name: " fname
 read -p "Enter Second Name: " sname
 read -p "Enter Number: " number
 clear
 echo "New Contact Info:"
 echo "Name: $fname $sname"
 echo "Number: $number"
 echo "$fname $sname : $number" >> phonebookDB.txt
 echo "Saved successfully"
;;
"-v")echo "Your Phone Book Data"
 echo ""
 cat phonebookDB.txt
;;
"-s")echo "SEARCH CONTACTS"
 read -p "Enter contact name to search " search_name
 clear
 if grep -q "^$search_name" phonebookDB.txt
 then
   echo "SEARCH RESULTS"
   grep -i $search_name phonebookDB.txt
 else
  echo "Name not found"
 fi
;;
"-sa")echo "SEARCH CONTACTS"
 echo "Enter full contact name to search "
 read -a search_name
 clear
 if grep -q "^$search_name" phonebookDB.txt
 then
   echo "SEARCH RESULTS"
   grep -i ${search_name[0]} phonebookDB.txt | grep -i ${search_name[1]}
 else
  echo "Name not found"
 fi
;;

"-e")echo "DELETE ALL RECORDS"
 rm phonebookDB.txt
 echo "Delete Successfully"
;;
"-d")echo "DELETE CONTACT"
 echo "Enter contact name to be Deleted(case-sensitive) "
 while :
 do
 read -a delete_name
 case ${delete_name[1]} in
  "")clear
  if grep -q "^$delete_name" phonebookDB.txt
  then
   grep -i $delete_name phonebookDB.txt
   echo "which one you want to delete, write full name,please"
  else
  echo "Name not found"
  break
 fi
  ;;
  *)loc=${delete_name[0]}" "${delete_name[1]}
  if grep -q "^$loc" phonebookDB.txt
  then
    sed -i -e "/$loc/d" phonebookDB.txt
    echo "Delete Sucessful"
  else
    echo "Name not found"
  fi
  break
  ;;
 esac
 done 
;;
*)echo "Welcome to the phone book"
echo "Choose an option while running the script"
echo "-i to insert a new contact name and number"
echo "-v to view all saved contacts details"
echo "-s to search by contact name -only one name first or second-"
echo "-sa to search by contact name -full name-"
echo "-e to delete all records"
echo "-d to delete only one contact name"
;;
esac;
