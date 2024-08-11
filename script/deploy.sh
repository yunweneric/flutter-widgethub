#!/bin/bash

# Script to clean, get dependencies, build Flutter web (WASM), and deploy using Firebase

echo "Cleaning Flutter project..."
flutter clean

echo "Getting Flutter dependencies..."
flutter pub get

echo "Clearing terminal..."
clear

echo "Building Flutter web with WASM..."
flutter build web --wasm

echo "Deploying to Firebase..."
firebase deploy

echo "Deployment complete!"
