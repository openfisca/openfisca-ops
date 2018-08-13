git pull
npm install
npm install swagger-ui@3.17.3

NODE_ENV=production PATHNAME=/legislation/  API_URL=https://fr.openfisca.org/api/v22 npm run build
echo "Restarting legislation-explorer service..."
sudo systemctl restart legislation-explorer.service
