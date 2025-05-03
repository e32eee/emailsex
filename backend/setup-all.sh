#!/bin/bash
set -e

echo "Creating folders..."
mkdir -p backend/src frontend/src

echo "Creating install-and-run.sh ..."
cat > install-and-run.sh << 'EOF'
#!/bin/bash
set -e

echo "Installing backend dependencies..."
cd backend
npm install

echo "Building backend (if needed)..."
npx tsc || true

echo "Starting backend API and SMTP server in background..."
nohup npx ts-node src/app.ts > ../backend-api.log 2>&1 &
nohup npx ts-node src/smtp.ts > ../smtp.log 2>&1 &
cd ..

echo "Installing frontend dependencies..."
cd frontend
npm install

echo "Starting frontend dev server..."
npm start
EOF
chmod +x install-and-run.sh

echo "Creating README.md ..."
cat > README.md << 'EOF'
# Temp Mail MVP

A super simple, real 10-minute mail app for fast site registrations.

## Quick Start

Clone the repo and run:

```bash
chmod +x install-and-run.sh
./install-and-run.sh
```
EOF
