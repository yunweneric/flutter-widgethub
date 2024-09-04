#!/bin/bash

# Script to clean, get dependencies, build Flutter web (WASM), and deploy using Firebase

echo "Cleaning Flutter project..."
flutter clean

echo "Getting Flutter dependencies..."
flutter pub get

echo "Clearing terminal..."
clear

echo "Building Flutter web with WASM..."
flutter build web --wasm --target lib/main_dev.dart --dart-define-from-file=../envs/fwh/dev.env.json
# flutter build web --web-renderer html --target lib/main_dev.dart --dart-define-from-file=../envs/fwh/dev.env.json

echo "Deploying to Firebase..."
firebase deploy

echo "Deployment complete!"
