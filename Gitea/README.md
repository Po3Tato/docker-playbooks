Gitea is an open source repository management similar to GitHub. It can be self hosted for homelab code base.

## Folder Structure
```
./gitea
├── data/
└── docker-compose.yml
```

## File and Folder configuration
- Edit `.env` environment
- Generate a JWT token and add in `.env`
```
openssl rand -hex 32
```
