# Etapa 1: Construcción (build)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Establecer el directorio de trabajo en el contenedor
WORKDIR /src

# Copiar los archivos del proyecto y restaurar las dependencias
COPY *.csproj ./
RUN dotnet restore

# Copiar el resto del código fuente y compilar la aplicación
COPY . ./
RUN dotnet publish -c Release -o /app/publish

# Etapa 2: Ejecución (runtime)
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Copiar los archivos compilados desde la etapa de construcción
COPY --from=build /app/publish .

# Exponer el puerto 8080
EXPOSE 8080

# Configurar el punto de entrada para ejecutar la aplicación
ENTRYPOINT ["dotnet", "MyWebApp.dll"]


