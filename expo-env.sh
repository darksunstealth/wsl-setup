#!/bin/bash

set -e

echo "🔧 Updating packages and installing dependencies..."
sudo apt update && sudo apt install -y curl git unzip software-properties-common

echo "🧱 Installing Node.js LTS (v20)..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

echo "📦 Installing Yarn (optional)..."
npm install -g yarn

echo "🕵️ Installing Watchman (recommended for Metro Bundler)..."
sudo apt install -y autoconf automake build-essential python3-pip libtool pkg-config
git clone https://github.com/facebook/watchman.git /tmp/watchman
cd /tmp/watchman
git checkout v2023.06.12.00
./autogen.sh
./configure
make
sudo make install
cd ~
rm -rf /tmp/watchman

echo "🚀 Installing Expo CLI globally..."
npm install -g expo-cli

echo "🔐 Setting up npm global environment without sudo (optional)..."
mkdir -p ~/.npm-global
npm config set prefix ~/.npm-global
echo 'export PATH=$HOME/.npm-global/bin:$PATH' >> ~/.bashrc
export PATH=$HOME/.npm-global/bin:$PATH

echo "✅ Environment is ready! Try: expo init myapp && cd myapp && expo start --tunnel"
