img="$1"
HOME="/Users/alex"  # Define appropriately
db_file="Library/Application Support/Dock/desktoppicture.db"
db_path="$HOME/$db_file"

# Put the image path in the database
sql="insert into data values(\"$img\");"
/usr/bin/sqlite3 "$db_path" "$sql"

# Get the index of the new entry
sql="select max(rowid) from data;"
new_entry=$(/usr/bin/sqlite3 "$db_path" "$sql")
new_entry=$(echo "$new_entry" | tr -d '\n')

# Get all picture ids (monitor/space pairs)
get_pics_cmd=("/usr/bin/sqlite3" "$db_path" "select rowid from pictures;")
pictures=$("${get_pics_cmd[@]}")
pictures=$(echo "$pictures" | tr '\n' ' ')

# Clear all existing preferences
sql="delete from preferences; "

# Write all pictures to the new image
for pic in $pictures; do
    if [ -n "$pic" ]; then
        sql+="insert into preferences (key, data_id, picture_id) "
        sql+="values(1, $new_entry, $pic); "
    fi
done

/usr/bin/sqlite3 "$db_path" "$sql"

# Kill the dock to fix issues with cached wallpapers
/usr/bin/killall Dock