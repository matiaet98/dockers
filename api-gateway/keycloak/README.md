# Keycloak

## Deployment

### 1. Crear los certificados SSL

```bash
chmod +x makecerts.sh
./makecerts.sh
```

### 2. Modificar las variables del archivo .env

### 3. Levantar el servicio

```bash
docker-compose up -d
```