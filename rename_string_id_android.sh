#!/bin/bash

# Define the root directory of your project
#ex PROJECT_ROOT="/Users/my_username/MyProjectName"
PROJECT_ROOT=

# Get the original and new resource names from the command line
ORIGINAL_RESOURCE_ID=$1
NEW_RESOURCE_ID=$2

# Define the modules you want to search in
SETTINGS_FILE="$PROJECT_ROOT/settings.gradle.kts"

## Check if settings.gradle.kts exists, else use settings.gradle
#if [ -f "$PROJECT_ROOT/settings.gradle.kts" ]; then
#    SETTINGS_FILE="$PROJECT_ROOT/settings.gradle.kts"
#else
#    SETTINGS_FILE="$PROJECT_ROOT/settings.gradle"
#fi

# Extract module names from the settings file and store in a variable
MODULES=$(awk -F '"' '/include/ {print $2}' $SETTINGS_FILE | sed 's/:/\//g')

# Convert string to array
IFS=$'\n' read -d '' -r -a MODULE_ARRAY <<< "$MODULES"

# Now you can use the MODULE_ARRAY variable in your script
#for MODULE in "${MODULE_ARRAY[@]}"; do
#  echo "$MODULE"
#done

echo "Total number of modules: ${#MODULE_ARRAY[@]}"
# Loop over each module and replace the text
for MODULE in "${MODULE_ARRAY[@]}"; do
  MODULE=$(echo "$MODULE" | sed 's/^\///')
  echo "Replacing in module: $MODULE"
  # Use find and perl to replace the text in .kt files
  find "$PROJECT_ROOT/$MODULE" -name "*.kt" | xargs perl -pi -e "s/R.string.\b$ORIGINAL_RESOURCE_ID\b/R.string.$NEW_RESOURCE_ID/g"
  # Use find and perl to replace the text in .xml files
  find "$PROJECT_ROOT/$MODULE" -name "*.xml" | xargs perl -pi -e "s/\@string\/\b$ORIGINAL_RESOURCE_ID\b/\@string\/$NEW_RESOURCE_ID/g"
  # Use find and perl to replace the text in strings.xml files
  find "$PROJECT_ROOT/$MODULE" -name "strings.xml" | xargs perl -pi -e "s/name=\"\b$ORIGINAL_RESOURCE_ID\b\"/name=\"$NEW_RESOURCE_ID\"/g"
done

echo "Replaced 'R.string.$ORIGINAL_RESOURCE_ID' with 'R.string.$NEW_RESOURCE_ID' in .kt files, '@string/$ORIGINAL_RESOURCE_ID' with '@string/$NEW_RESOURCE_ID' in .xml files, and the string resource name in strings.xml files of the specified modules."
