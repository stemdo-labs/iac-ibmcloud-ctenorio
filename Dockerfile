# Etapa 1: Construcción
FROM maven:3.9-eclipse-temurin-17 AS build
# Establecer el directorio de trabajo
WORKDIR /app
# Copiar el archivo de dependencias y bajar las dependencias
COPY pom.xml .
RUN mvn dependency:go-offline
# Copiar el código fuente
COPY src ./src
# Compilar el proyecto y generar el JAR
RUN mvn package -DskipTests
# Verificar el contenido del directorio target 
RUN ls -la /app/target
# Etapa 2: Producción
FROM eclipse-temurin:17-jre-alpine
# Establecer el directorio de trabajo
WORKDIR /app
# Copiar el JAR compilado de la etapa anterior
COPY --from=build /app/target/*.jar app.jar
# Exponer el puerto 8080
EXPOSE 8080
# Comando para ejecutar la aplicación
CMD ["java", "-jar", "app.jar"]
