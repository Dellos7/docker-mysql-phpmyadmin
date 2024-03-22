# Examen Aragón 2018 - ej.2 del Ejercicio 2 (Parte "A")

Base de datos **`agencia_viajes`**

## Levantar los servicios docker

```
docker-compose up
```

Acceder a PhpMyAdmin en http://localhost:8080/

## Recrear la BBDD

```bash
./scripts/resetDb.sh
```

## Consulta pedida en el ejercicio

```sql
select *
from asientos_libres_ocupados
where id_salida = 1;
```