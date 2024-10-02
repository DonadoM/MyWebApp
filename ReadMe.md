## **1. Instalación del .NET SDK en Ubuntu**

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
