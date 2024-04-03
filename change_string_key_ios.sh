#!/bin/bash

# Define the root directory of your project
PROJECT_ROOT=""

# Define the paths to the Localizable.xcstrings and i18n.swift files
STRING_PATH="$PROJECT_ROOT/Formation/Localization/Localizable.xcstrings"
I18N_PATH="$PROJECT_ROOT/Formation/Localization/i18n.swift"

# Get the original and new keys from the command line
ORIGINAL_KEY=$1
NEW_KEY=$2

# Check if the new key already exists in the files
if grep -q "\"$NEW_KEY\"" "$STRING_PATH" "$I18N_PATH"; then
  echo "The new key '$NEW_KEY' already exists in the files. Please choose a different key."
  exit 1
fi

# Use sed to replace the keys in the Localizable.xcstrings and i18n.swift files
sed -i '' "s/\"$ORIGINAL_KEY\"/\"$NEW_KEY\"/g" "$STRING_PATH"
sed -i '' "s/\"$ORIGINAL_KEY\"/\"$NEW_KEY\"/g" "$I18N_PATH"

echo "Replaced '$ORIGINAL_KEY' with '$NEW_KEY' in Localizable.xcstrings and i18n.swift files."
