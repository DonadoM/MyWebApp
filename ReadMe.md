## **Instalación de Docker en Ubuntu**

1. **Actualiza la lista de paquetes:**

   sudo apt update

2. **Instalar los paquetes necesarios para que apt pueda usar repositorios sobre HTTPS:** 

   sudo apt install apt-transport-https ca-certificates curl software-properties-common

3. **Añadir la clave GPG oficial de docker**

   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

4. **Añade el repositorio de docker a apt**

   echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

5. **Actualizar la lista de paquetes**

   sudo apt update

6. **Instalar Docker**

   sudo apt install docker-ce

7. **Verificar que docker esté corriendo:**
   
   sudo systemctl status docker


## **2. Instalación del .NET SDK en Ubuntu**

1. **Actualiza la lista de paquetes**:

   sudo apt update

2. **Instala el .NET SDK 8.0**:

   sudo apt install dotnet-sdk-8.0



## **2. Crear la Aplicación Web**

1. **Crea una nueva aplicación web**:

   dotnet new web -n MyWebApp

2. **Accede al directorio de la aplicación**:

   cd MyWebApp

## **3. Crear el Dockerfile**

A continuación, necesitarás un archivo, usa nano para crear `Dockerfile` para que le indique a Docker cómo construir tu aplicación. Crea este archivo en la raíz de tu proyecto (`~/MyWebApp`) y añade el siguiente contenido:

```
dockerfile
# Etapa de construcción
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Etapa de ejecución
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "MyWebApp.dll"]
```

## **4. Construir la Imagen**

sudo docker build -t mywebapp:latest .

## **5. Etiquetar la Imagen**

```
sudo docker tag mywebapp:latest tusuario/mywebapp:latest
```

## **6. Iniciar Sesión en Docker Hub**

```
sudo docker login
```

## **7. Subir la Imagen a Docker Hub**

```
sudo docker push tusuario/mywebapp:latest
```

## **8. Ejecutar el Contenedor**

```
sudo docker run -d -p 8080:8080 --name mywebapp_container tusuario/mywebapp:latest
```

## **9. Acceder a la Aplicación Web**

```
http://localhost:8080
```

## **10. Verificar el Estado del Contenedor**

```
sudo docker ps
```



## **11. Ver los Registros del Contenedor**

```
sudo docker logs mywebapp_container
```

## **12. Detener el Contenedor**

```
sudo docker stop mywebapp_container
```
