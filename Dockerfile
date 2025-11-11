# Usar imagen base de Java 21
FROM eclipse-temurin:21-jdk-alpine

# Directorio de trabajo
WORKDIR /app

# Copiar archivos de Gradle
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .

# Copiar código fuente
COPY src src

# Dar permisos de ejecución a gradlew
RUN chmod +x gradlew

# Construir la aplicación (sin tests para acelerar)
RUN ./gradlew build -x test

# Exponer el puerto
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["java", "-jar", "build/libs/inicial1-0.0.1-SNAPSHOT.jar"]