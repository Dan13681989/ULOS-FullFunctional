#!/bin/bash
set -e  # stop on errors

echo "Building the project..."
make all

echo "Adding changes..."
git add .

commit_msg="Build and update: $(date +"%Y-%m-%d %H:%M:%S")"
git commit -m "$commit_msg" || echo "No changes to commit."

echo "Pushing changes..."
git push origin main

latest_tag=$(git describe --tags $(git rev-list --tags --max-count=1) 2>/dev/null || echo "v0.0.0")
echo "Latest tag: $latest_tag"

IFS='.' read -r major minor patch <<< "${latest_tag#v}"
next_patch=$((patch + 1))
next_tag="v${major}.${minor}.${next_patch}"

echo "Creating new tag $next_tag..."
git tag "$next_tag"
git push origin "$next_tag"

echo "Creating GitHub release..."
gh release create "$next_tag" --title "$next_tag Release" --notes "Automated release $next_tag"

echo "Release $next_tag created successfully!"
