#!/bin/bash

SOURCE_DIR="../"
DEST_DIR="github-actions"

# Ensure destination directory exists
mkdir -p "$DEST_DIR"

# If README.md doesn't exist, create it
if [[ ! -f "$DEST_DIR/README.md" ]]; then
    touch "$DEST_DIR/README.md"
    echo "# Collected GitHub Actions" > "$DEST_DIR/README.md"
fi

# Use find to recursively search for .github/workflows directories
while IFS= read -r workflows_dir; do
    project_name=$(basename $(dirname $(dirname "$workflows_dir")))
    
    # Ensure project-specific directory exists in destination directory
    mkdir -p "$DEST_DIR/$project_name"

    # Copy the YAML files from the workflows directory into the respective project directory inside DEST_DIR
    cp "$workflows_dir/"*.yml "$DEST_DIR/$project_name/"

    # Add/sync to README.md
    for yaml_file in "$workflows_dir/"*.yml; do
        # Extract job names
        job_names=$(grep "name:" $yaml_file | awk -F 'name: ' '{print $2}')
        
        # Update README.md with the job names
        filename=$(basename $yaml_file)
        echo -e "\n## $project_name/$filename" >> "README.md"
        for job in $job_names; do
            echo "- $job" >> "README.md"
        done
    done

done < <(find "$SOURCE_DIR" -type d -path "*/.github/workflows")

echo "GitHub Actions workflows collected and README.md updated successfully."
