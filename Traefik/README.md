Traefik is a simple dynamic reverse proxy. Supports alot of plugins and easy to use.

## Folder Structure
```
./traefik
├── data/
│   ├── acme.json
│   ├── config.yml (edit accordingly)
│   └── traefik.yml (edit accordingly)
└── docker-compose.yml
```

## File and Folder configuration
- Edit `.env` environment
- Change the `acme.json` permissions. This is to enable Traefik to write and read certs it has obtained
```
chmod 600 acme.json
```
- Create secrets to be put in the `.env` using *htpasswd*. This will be used to generate a credential pair for Traefik admin. Make sure *htpasswd*
```
sudo apt install apache2-utils
echo $(htpasswd -nB <user>) | sed -e s/\\$/\\$\\$/g # Change <user> to desired user
```
