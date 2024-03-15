## Configure and run Headscale
- This link works only on Debian builds. Head [here](https://github.com/juanfont/headscale/releases)
```
wget --output-document=headscale.deb   https://github.com/juanfont/headscale/releases/download/v0.23.0-alpha5/headscale_0.23.0-alpha5_linux_amd64.deb
```
- Install Headscale
```
sudo dpkg --install headscale.deb
```
- Enable Headscale service, this will start Headscale at boot:
```
sudo systemctl enable Headscale
```
- Create an empty SQLite database
```
touch /var/lib/headscale/db.sqlite
```
- Create a Headscale configuration
```
touch /etc/headscale/config.yaml
```
- Start Headscale
```
sudo systemctl start Headscale
```
- Check if Headscale is running with no errors
