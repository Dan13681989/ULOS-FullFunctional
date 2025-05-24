#!/bin/bash

# Setup project files
curl -o LICENSE https://www.apache.org/licenses/LICENSE-2.0.txt

cat > CONTRIBUTING.md << 'EOF'
# Contributing to ULOS-FullFunctional

Thank you for your interest in contributing! Please follow these guidelines:

- Fork the repository and create your branch from main.
- Make sure your code follows existing style and tests pass.
- Submit pull requests with a clear description of your changes.
- Be respectful and constructive in discussions.

Happy coding!

EOF

cat > .gitignore << 'EOF'
.vscode/
.idea/
node_modules/
coverage/
*.swp
.DS_Store
EOF

git add LICENSE CONTRIBUTING.md .gitignore README.md
git commit -m "Setup project docs, license, contributing guide, and .gitignore"
git push origin main

# Create GitHub release (change tag if already exists)
gh release create v1.0.1 --title "v1.0.1 Release" --notes "Updated docs and config."
