# Kong

## Deployment

### 1. Crear la imagen customizada de Kong

```bash
docker build -t arquitectura/kong:latest ./kong.dockerfile
```

### 2. Editar el archivo .env

### 3. Generar los certificados

```bash
chmod +x makecerts.sh
./makecerts.sh
```

### 4. Realizar el bootstrap de las bases

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

### 5. Configurar balanceo

Editar el archivo default.conf de nginx y poner los puertos que se quieren exponer

### 6. Levantar los servicios

```bash
docker-compose up -d
```