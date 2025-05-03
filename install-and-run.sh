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
