<VirtualHost _default_:80>
	ServerAdmin webmaster@localhost
	ServerName www.bupler.com
	ServerAlias bupler.com
	ServerSignature Off
	
	DocumentRoot /var/www/bupler-lib/docs/build/html/

	<Directory />
		Options FollowSymLinks
		AllowOverride All
	</Directory>
	<Directory /var/www/bupler/docs/build/html/>
		Options Indexes FollowSymLinks MultiViews
		AllowOverride All
		Order allow,deny
		allow from all
	</Directory>
</VirtualHost>
