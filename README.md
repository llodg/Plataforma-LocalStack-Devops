# Plataforma LocalStack DevOps

# Descripción del proyecto

Este proyecto simula una plataforma DevOps completa basada en contenedores Docker, integrando un entorno de servicios distribuidos con observabilidad, automatización e infraestructura simulada en la nube mediante LocalStack.

El objetivo del proyecto es reproducir un entorno cercano a producción donde se integran:
- Microservicios
- Reverse proxy
- Almacenamiento tipo AWS S3 (simulado)
- Monitorización de sistemas
- Logging centralizado
- Sistema de alertas

Todo el sistema es completamente reproducible mediante Docker Compose.

---

# Arquitectura del sistema

El sistema está compuesto por los siguientes componentes:

- **Flask App** → Microservicio principal que genera eventos y datos
- **Nginx** → Reverse proxy como punto de entrada único
- **LocalStack** → Simulación de servicios AWS (S3)
- **Prometheus** → Recolección de métricas
- **Grafana** → Visualización de métricas mediante dashboards
- **Loki** → Centralización de logs
- **Promtail** → Recolección y envío de logs a Loki
- **Alertmanager** → Sistema de alertas basado en métricas

---

# Flujo del sistema

Cuando se realiza una petición al sistema:

1. El usuario accede a Nginx
2. Nginx redirige la petición al microservicio Flask
3. Flask procesa la petición y:
   - Genera logs
   - Expone métricas
   - Sube archivos a S3 (LocalStack)
4. Prometheus recolecta métricas desde `/metrics`
5. Promtail envía logs a Loki
6. Grafana visualiza métricas y logs
7. Alertmanager evalúa reglas de alerta sobre métricas

---

# Tecnologías utilizadas

- Docker & Docker Compose
- Python (Flask)
- Nginx
- LocalStack (AWS S3 simulado)
- Prometheus
- Grafana
- Loki
- Promtail
- Alertmanager
- AWS CLI (para interacción con LocalStack)

---

# Cómo ejecutar el proyecto

### 1. Clonar el repositorio

```bash
git clone <URL_DEL_REPO>
cd plataforma-LocalStak-devops
