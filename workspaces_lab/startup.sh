sudo apt-get update
sudo apt-get install apache2 -y
cat <<EOF > /var/www/html/index.html
<html><body><h1>Hello Cloud Gurus!</h1></body></html>