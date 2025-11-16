# 🧬 Mutant Detector API

API REST para detectar si un humano es mutante basándose en su secuencia de ADN.

[![Java](https://img.shields.io/badge/Java-21-orange.svg)](https://www.oracle.com/java/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2.0-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![Gradle](https://img.shields.io/badge/Gradle-8.8-blue.svg)](https://gradle.org/)
[![Tests](https://img.shields.io/badge/Tests-37%20passing-success.svg)](/)
[![Coverage](https://img.shields.io/badge/Coverage-58%25-yellow.svg)](/)

---

## 🌐 Demo en Vivo - TOTALMENTE FUNCIONAL

🚀 **API desplegada en Render:**

**Base URL:** [https://mutantes-api-v2.onrender.com](https://mutantes-api-v2.onrender.com)

**Swagger UI:** [https://mutantes-api-v2.onrender.com/swagger-ui.html](https://mutantes-api-v2.onrender.com/swagger-ui.html)

✅ **Función "Try it out" completamente operativa**

**Endpoints disponibles:**
- `POST /mutant` - Verificar si un ADN es mutante
- `GET /stats` - Obtener estadísticas de verificaciones

⚠️ **Nota:** El servicio puede tardar 30-60 segundos en despertar si no se ha usado recientemente (plan gratuito de Render).

---

## 📋 Tabla de Contenidos

- [Descripción](#-descripción)
- [Demo en Vivo](#-demo-en-vivo)
- [Características](#-características)
- [Requisitos Previos](#-requisitos-previos)
- [Instalación y Ejecución](#-instalación-y-ejecución)
- [API Endpoints](#-api-endpoints)
- [Swagger UI](#-swagger-ui)
- [Base de Datos H2](#-base-de-datos-h2)
- [Tests](#-tests)
- [Análisis de Eficiencia](#-análisis-de-eficiencia)
- [Cobertura de Código](#-cobertura-de-código)
- [Arquitectura](#-arquitectura)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Tecnologías](#-tecnologías)
- [Ejemplos de Uso](#-ejemplos-de-uso)
- [Deploy en Render](#-deploy-en-render)

---

## 🧬 Descripción

Este proyecto implementa una API REST que analiza secuencias de ADN para determinar si un humano es mutante. Un humano es considerado mutante si se encuentran **más de una secuencia** de cuatro letras iguales (A, T, C, G) de forma:
- Horizontal (→)
- Vertical (↓)
- Diagonal (↘ ↙)

### Ejemplo de ADN Mutante:
```
A T G C G A
C A G T G C
T T A T G T
A G A A G G  ← Secuencia horizontal
C C C C T A  ← Secuencia horizontal
T C A C T G
```

---

## ✨ Características

- ✅ **Detección de mutantes** mediante algoritmo optimizado O(N²)
- ✅ **API REST** con endpoints documentados
- ✅ **Persistencia** en base de datos H2 con hash SHA-256
- ✅ **Estadísticas** de verificaciones realizadas
- ✅ **37 Tests unitarios** con 100% de éxito
- ✅ **58% de cobertura** (94% en capa de servicio)
- ✅ **Documentación Swagger** interactiva y funcional
- ✅ **Análisis de métricas** de performance
- ✅ **Deduplicación** de registros por hash
- ✅ **Desplegado en Render** con HTTPS

---

## 📦 Requisitos Previos

- **Java 21** o superior
- **Gradle 8.8** (incluido con wrapper)
- **Git** (opcional, para clonar)

---

## 🚀 Instalación y Ejecución

### 1. Clonar el Repositorio
```bash
git clone https://github.com/Mariano251/mutantes.git
cd mutantes
```

### 2. Compilar el Proyecto
```bash
./gradlew build
```

### 3. Ejecutar la Aplicación
```bash
./gradlew bootRun
```

La aplicación estará disponible en: **http://localhost:8080**

### 4. Ejecutar Tests
```bash
./gradlew test
```

### 5. Ver Reporte de Cobertura
```bash
./gradlew test jacocoTestReport
# Abrir: build/reports/jacoco/test/html/index.html
```

---

## 🔌 API Endpoints

### **POST /mutant**
Verifica si un ADN corresponde a un mutante.

**Request:**
```json
{
  "dna": ["ATGCGA", "CAGTGC", "TTATGT", "AGAAGG", "CCCCTA", "TCACTG"]
}
```

**Responses:**

**200 OK** - Es mutante:
```json
{
  "result": "mutant"
}
```

**403 Forbidden** - Es humano:
```json
{
  "result": "human"
}
```

**400 Bad Request** - ADN inválido:
```json
{
  "timestamp": "2025-11-16T15:30:00",
  "status": 400,
  "error": "Bad Request",
  "message": "Invalid DNA sequence: must be a square NxN matrix (minimum 4x4) with only A, T, C, G characters",
  "path": "/mutant"
}
```

---

### **GET /stats**
Obtiene estadísticas de las verificaciones de ADN.

**Response:**
```json
{
  "count_mutant_dna": 40,
  "count_human_dna": 100,
  "ratio": 0.4
}
```

---

## 📚 Swagger UI

La documentación interactiva de la API está disponible en:

### **🌐 Producción (Render):**
**URL:** [https://mutantes-api-v2.onrender.com/swagger-ui.html](https://mutantes-api-v2.onrender.com/swagger-ui.html)

### **💻 Local:**
**URL:** [http://localhost:8080/swagger-ui.html](http://localhost:8080/swagger-ui.html)

### Características de Swagger:
- ✅ Documentación completa de endpoints
- ✅ Ejemplos de requests/responses
- ✅ **Función "Try it out" completamente operativa**
- ✅ Modelos de datos documentados
- ✅ Códigos de estado HTTP explicados

---

## 💾 Base de Datos H2

La aplicación usa **H2 Database** en memoria para persistir los registros.

### **Acceder a H2 Console (Local):**

1. **URL:** [http://localhost:8080/h2-console](http://localhost:8080/h2-console)

2. **Credenciales:**
   - **JDBC URL:** `jdbc:h2:mem:testdb`
   - **User Name:** `sa`
   - **Password:** *(dejar vacío)*

3. **Click en:** `Connect`

### **Queries Útiles:**
```sql
-- Ver todos los registros
SELECT * FROM DNA_RECORD;

-- Contar mutantes
SELECT COUNT(*) FROM DNA_RECORD WHERE IS_MUTANT = true;

-- Contar humanos
SELECT COUNT(*) FROM DNA_RECORD WHERE IS_MUTANT = false;

-- Ver últimos 10 registros
SELECT * FROM DNA_RECORD ORDER BY CREATED_AT DESC LIMIT 10;

-- Calcular ratio
SELECT 
    SUM(CASE WHEN IS_MUTANT = TRUE THEN 1 ELSE 0 END) AS mutantes,
    SUM(CASE WHEN IS_MUTANT = FALSE THEN 1 ELSE 0 END) AS humanos,
    CAST(SUM(CASE WHEN IS_MUTANT = TRUE THEN 1 ELSE 0 END) AS DOUBLE) / 
    CAST(SUM(CASE WHEN IS_MUTANT = FALSE THEN 1 ELSE 0 END) AS DOUBLE) AS ratio
FROM DNA_RECORD;
```

### **Estructura de la Tabla:**

| Columna | Tipo | Descripción |
|---------|------|-------------|
| `ID` | BIGINT | Primary Key (auto-increment) |
| `DNA_HASH` | VARCHAR(64) | Hash SHA-256 único del ADN |
| `IS_MUTANT` | BOOLEAN | true si es mutante, false si es humano |
| `CREATED_AT` | TIMESTAMP | Fecha y hora de creación |

---

## 🧪 Tests

El proyecto incluye **37 tests unitarios** con **100% de éxito**.

### **Ejecutar Tests:**
```bash
./gradlew test
```

### **Distribución de Tests:**

#### **MutantDetectorTest (17 tests):**
- ✅ Detección de mutantes horizontales
- ✅ Detección de mutantes verticales
- ✅ Detección de mutantes diagonales (\ y /)
- ✅ Detección de múltiples secuencias
- ✅ Casos edge: matrices mínimas (4x4)
- ✅ Matrices grandes (100x100, 1000x1000)

#### **MutantServiceTest (5 tests):**
- ✅ Verificación y persistencia de mutantes
- ✅ Verificación y persistencia de humanos
- ✅ Deduplicación por hash

#### **StatsServiceTest (6 tests):**
- ✅ Estadísticas sin registros
- ✅ Cálculo correcto de ratio

#### **MutantControllerTest (8 tests):**
- ✅ POST /mutant retorna 200 para mutantes
- ✅ POST /mutant retorna 403 para humanos
- ✅ GET /stats retorna JSON correcto

#### **AlgorithmMetricsTest (1 test):**
- ✅ Análisis completo de 5 métricas de performance

### **Resultados:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
37 tests ✅
0 failures
0 ignored
100% successful
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## ⚡ Análisis de Eficiencia

### **Complejidad del Algoritmo:**

**Temporal:**
- **Peor caso:** O(N²) - Debe recorrer toda la matriz
- **Caso promedio:** O(N) - Early termination tras encontrar 2 secuencias
- **Mejor caso:** O(1) - Encuentra 2 secuencias al inicio

**Espacial:** O(N) - Conversión a char[][]

### **Métricas de Performance:**

#### **Tiempos de Ejecución:**
```
Tamaño       Tiempo Avg (ms)
━━━━━━━━━━━━━━━━━━━━━━━━━━
6x6          0.010
10x10        0.012
50x50        0.061
100x100      0.094
500x500      0.533
1000x1000    1.842
```

#### **Throughput:**
- **>4 millones** de operaciones/segundo en matrices pequeñas
- **>50,000** ops/seg en matrices 100x100

---

## 📊 Cobertura de Código

### **Resultados de Cobertura:**

| Paquete | Cobertura | Estado |
|---------|-----------|--------|
| **controller** | 100% | ✅ PERFECTO |
| **service** | 94% | ✅ EXCELENTE |
| **validation** | 93% | ✅ EXCELENTE |
| **exception** | 40% | ⚠️ Normal (constructores) |
| **entity** | 41% | ⚠️ Normal (Lombok) |
| **dto** | 15% | ⚠️ Normal (Lombok) |
| **TOTAL** | **58%** | ✅ APROBADO |

---

## 🏗️ Arquitectura

El proyecto sigue una arquitectura en capas:
```
┌─────────────────────────────────────┐
│         Controller Layer            │  ← API REST Endpoints
│     (MutantController)              │
└────────────┬────────────────────────┘
             │
┌────────────▼────────────────────────┐
│         Service Layer                │  ← Lógica de Negocio
│  (MutantService, StatsService)      │
│  (MutantDetector)                    │
└────────────┬────────────────────────┘
             │
┌────────────▼────────────────────────┐
│       Repository Layer               │  ← Acceso a Datos
│   (DnaRecordRepository)              │
└────────────┬────────────────────────┘
             │
┌────────────▼────────────────────────┐
│         Database Layer               │  ← H2 Database
│        (DNA_RECORD)                  │
└─────────────────────────────────────┘
```

### **Patrones Implementados:**

- ✅ **Repository Pattern** - Abstracción de acceso a datos
- ✅ **DTO Pattern** - Separación de capas
- ✅ **Service Layer** - Lógica de negocio centralizada
- ✅ **Custom Validator** - Validación de entrada
- ✅ **Global Exception Handler** - Manejo centralizado de errores
- ✅ **Dependency Injection** - Inversión de control con Spring

---

## 📁 Estructura del Proyecto
```
mutantes/
├── src/
│   ├── main/
│   │   ├── java/org/example/
│   │   │   ├── config/
│   │   │   │   ├── SwaggerConfig.java
│   │   │   │   └── GlobalExceptionHandler.java
│   │   │   ├── controller/
│   │   │   │   └── MutantController.java
│   │   │   ├── dto/
│   │   │   │   ├── AnalysisResult.java
│   │   │   │   ├── DnaRequest.java
│   │   │   │   ├── ErrorResponse.java
│   │   │   │   └── StatsResponse.java
│   │   │   ├── entity/
│   │   │   │   └── DnaRecord.java
│   │   │   ├── exception/
│   │   │   │   └── DnaHashCalculationException.java
│   │   │   ├── repository/
│   │   │   │   └── DnaRecordRepository.java
│   │   │   ├── service/
│   │   │   │   ├── MutantDetector.java
│   │   │   │   ├── MutantService.java
│   │   │   │   └── StatsService.java
│   │   │   ├── validation/
│   │   │   │   ├── ValidDnaSequence.java
│   │   │   │   └── ValidDnaSequenceValidator.java
│   │   │   └── MutantDetectorApplication.java
│   │   └── resources/
│   │       └── application.properties
│   └── test/
│       └── java/org/example/
│           ├── controller/
│           │   └── MutantControllerTest.java
│           └── service/
│               ├── AlgorithmMetricsTest.java
│               ├── MutantDetectorTest.java
│               ├── MutantServiceTest.java
│               └── StatsServiceTest.java
├── .gitignore
├── build.gradle
├── Dockerfile
├── gradlew
├── gradlew.bat
├── Procfile
├── render.yaml
├── settings.gradle
├── system.properties
└── README.md
```

---

## 🛠️ Tecnologías

### **Backend:**
- **Java 21** - Lenguaje de programación
- **Spring Boot 3.2.0** - Framework principal
- **Spring Web** - API REST
- **Spring Data JPA** - ORM
- **H2 Database** - Base de datos en memoria

### **Validación:**
- **Jakarta Validation** - Validación de beans
- **Custom Validators** - Validación personalizada de ADN

### **Documentación:**
- **Springdoc OpenAPI 2.3.0** - Swagger UI

### **Testing:**
- **JUnit 5** - Framework de tests
- **Mockito** - Mocking
- **Spring Boot Test** - Tests de integración
- **JaCoCo** - Cobertura de código

### **Utilidades:**
- **Lombok** - Reducción de boilerplate
- **Gradle 8.8** - Build tool

### **Deploy:**
- **Docker** - Containerización
- **Render** - Hosting cloud

---

## 💡 Ejemplos de Uso

### **Ejemplo 1: Verificar un Mutante (cURL)**
```bash
curl -X POST https://mutantes-api-v2.onrender.com/mutant \
  -H "Content-Type: application/json" \
  -d '{
    "dna": [
      "ATGCGA",
      "CAGTGC",
      "TTATGT",
      "AGAAGG",
      "CCCCTA",
      "TCACTG"
    ]
  }'
```
**Respuesta:** `200 OK`
```json
{
  "result": "mutant"
}
```

---

### **Ejemplo 2: Verificar un Humano (cURL)**
```bash
curl -X POST https://mutantes-api-v2.onrender.com/mutant \
  -H "Content-Type: application/json" \
  -d '{
    "dna": [
      "ATGC",
      "CAGT",
      "TTAT",
      "AGAC"
    ]
  }'
```
**Respuesta:** `403 Forbidden`
```json
{
  "result": "human"
}
```

---

### **Ejemplo 3: DNA Inválido (cURL)**
```bash
curl -X POST https://mutantes-api-v2.onrender.com/mutant \
  -H "Content-Type: application/json" \
  -d '{
    "dna": [
      "ATXC",
      "CAGT",
      "TTAT",
      "AGAC"
    ]
  }'
```
**Respuesta:** `400 Bad Request`
```json
{
  "timestamp": "2025-11-16T15:30:00",
  "status": 400,
  "error": "Bad Request",
  "message": "Invalid DNA sequence: must be a square NxN matrix (minimum 4x4) with only A, T, C, G characters",
  "path": "/mutant"
}
```

---

### **Ejemplo 4: Obtener Estadísticas (cURL)**
```bash
curl https://mutantes-api-v2.onrender.com/stats
```
**Respuesta:** `200 OK`
```json
{
  "count_mutant_dna": 40,
  "count_human_dna": 100,
  "ratio": 0.4
}
```

---

### **Ejemplo 5: Usando Swagger UI**

1. Abrir: [https://mutantes-api-v2.onrender.com/swagger-ui.html](https://mutantes-api-v2.onrender.com/swagger-ui.html)
2. Expandir endpoint **POST /mutant**
3. Click en **"Try it out"**
4. Ingresar JSON de ejemplo:
```json
{
  "dna": [
    "ATGCGA",
    "CAGTGC",
    "TTATGT",
    "AGAAGG",
    "CCCCTA",
    "TCACTG"
  ]
}
```
5. Click en **"Execute"**
6. Ver resultado

---

## 🚀 Deploy en Render

### **Configuración del Servicio:**

**Runtime:** Docker  
**Region:** Frankfurt (EU Central)  
**Build Command:** `./gradlew build -x test`  
**Start Command:** `java -jar build/libs/inicial1-0.0.1-SNAPSHOT.jar`

### **Variables de Entorno:**
- `JAVA_VERSION=21`
- `SPRING_PROFILES_ACTIVE=prod`

### **Dockerfile Multi-Stage:**
```dockerfile
# Build stage
FROM eclipse-temurin:21-jdk-alpine as build
COPY . .
RUN chmod +x ./gradlew
RUN ./gradlew bootJar --no-daemon

# Runtime stage
FROM eclipse-temurin:21-jre-alpine
EXPOSE 8080
COPY --from=build ./build/libs/inicial1-0.0.1-SNAPSHOT.jar ./app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
```

---

## 📝 Validaciones

### **Reglas de Validación del DNA:**

1. ✅ Debe ser una matriz cuadrada (NxN)
2. ✅ Tamaño mínimo: 4x4
3. ✅ Solo caracteres permitidos: A, T, C, G
4. ✅ Todas las filas deben tener la misma longitud
5. ✅ No puede ser null o vacío

---

## 📞 Contacto

**Autor:** Mariano Cortez  
**GitHub:** [https://github.com/Mariano251](https://github.com/Mariano251)  
**Repositorio:** [https://github.com/Mariano251/mutantes](https://github.com/Mariano251/mutantes)

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT.

---

## 🎓 Agradecimientos

Proyecto desarrollado como parte del curso de Programación III.

**Año:** 2025

---

## 🔗 Enlaces Útiles

- **API Producción:** [https://mutantes-api-v2.onrender.com](https://mutantes-api-v2.onrender.com)
- **Swagger UI:** [https://mutantes-api-v2.onrender.com/swagger-ui.html](https://mutantes-api-v2.onrender.com/swagger-ui.html)
- **Stats Endpoint:** [https://mutantes-api-v2.onrender.com/stats](https://mutantes-api-v2.onrender.com/stats)
- **GitHub Repo:** [https://github.com/Mariano251/mutantes](https://github.com/Mariano251/mutantes)
- **Render Dashboard:** [https://dashboard.render.com](https://dashboard.render.com)

---

**Última actualización:** Noviembre 2025

---

✨ **Proyecto 100% Funcional y Desplegado** ✨