sudo apt install nginx certbot python3-certbot-nginx -y

read -p "Your Domain: " DOMAIN

cpd () {
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/$DOMAIN
}
cpd

lnd () {
ln -s /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/
}
lnd

sed -i "s/_;/$DOMAIN;/" "/etc/nginx/sites-available/$DOMAIN"
sed -i "s/ default_server//" "/etc/nginx/sites-available/$DOMAIN"
sed -i "53 r /root/ReverseProxyN/reverse.txt" "/etc/nginx/sites-available/$DOMAIN"

certbot --nginx -d $DOMAIN --register-unsafely-without-email

systemctl restart nginx
