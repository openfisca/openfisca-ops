git pull
npm install

npm run build
echo "Restarting legislation-explorer service..."
sudo systemctl restart legislation-explorer.service
