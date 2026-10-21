/* ============================================================
   NFC ANALYTICS - 6 QUERIES ANALITICAS (PostgreSQL)
   Autor: Felipe Guzman Chaves

   Cada query responde una pregunta de negocio y practica un
   concepto de SQL distinto. Lee los comentarios: ahi esta la
   parte que te sirve para explicarlo en una entrevista.
   ============================================================ */


/* ------------------------------------------------------------
   0. PREPARACION: una vista "plana" para no repetir JOINs
   ------------------------------------------------------------
   Como tu base tiene llaves primarias y foraneas, las columnas
   estan repartidas en varias tablas. Esta vista las junta UNA vez
   y las demas queries leen de aqui.

   ADAPTALA a los nombres reales de tus tablas. Lo importante es
   que al final la vista tenga estas columnas:
   fecha, producto, precio_unitario, descuento_pct, monto_venta,
   costo_unitario, ganancia, margen_pct, canal, ciudad
   ------------------------------------------------------------ */
CREATE OR REPLACE VIEW vw_ventas AS
SELECT
    v.fecha,
    p.nombre_producto  AS producto,
    v.precio_unitario,
    v.descuento_pct,
    v.monto_venta,
    v.costo_unitario,
    v.ganancia,
    v.margen_pct,
    c.nombre_canal     AS canal,
    ci.nombre_ciudad   AS ciudad
FROM ventas v
JOIN productos p  ON p.id_producto = v.id_producto
JOIN canales   c  ON c.id_canal    = v.id_canal
JOIN ciudades  ci ON ci.id_ciudad  = v.id_ciudad;


/* ------------------------------------------------------------
   1. CRECIMIENTO MES A MES (MoM)
   ------------------------------------------------------------
   Pregunta: ¿el negocio crece o se estanca?
   Concepto: CTE + LAG()

   LAG(columna) trae el valor de la fila ANTERIOR segun el ORDER BY.
   Asi comparas cada mes contra el mes pasado sin hacer un self-join.
   NULLIF evita dividir entre cero.
   ------------------------------------------------------------ */
WITH mensual AS (
    SELECT
        DATE_TRUNC('month', fecha)::date AS mes,
        SUM(monto_venta)                 AS ingresos,
        COUNT(*)                         AS transacciones
    FROM vw_ventas
    GROUP BY 1
)
SELECT
    mes,
    ROUND(ingresos::numeric, 2)                          AS ingresos,
    transacciones,
    ROUND(LAG(ingresos) OVER (ORDER BY mes)::numeric, 2) AS ingresos_mes_anterior,
    ROUND(
        100.0 * (ingresos - LAG(ingresos) OVER (ORDER BY mes))
        / NULLIF(LAG(ingresos) OVER (ORDER BY mes), 0)
    ::numeric, 2)                                        AS crecimiento_pct
FROM mensual
ORDER BY mes;


/* ------------------------------------------------------------
   2. INGRESOS ACUMULADOS + PROMEDIO MOVIL DE 3 MESES
   ------------------------------------------------------------
   Pregunta: ¿cual es la tendencia real, sin el ruido de un mes malo?
   Concepto: funciones de ventana con "frame" (ROWS BETWEEN)

   - SUM() OVER (ORDER BY mes)  -> suma corrida (acumulado).
   - AVG() ... ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
     -> promedio de este mes y los 2 anteriores. Suaviza la curva.
   ------------------------------------------------------------ */
WITH mensual AS (
    SELECT
        DATE_TRUNC('month', fecha)::date AS mes,
        SUM(monto_venta)                 AS ingresos
    FROM vw_ventas
    GROUP BY 1
)
SELECT
    mes,
    ROUND(ingresos::numeric, 2)                                  AS ingresos,
    ROUND(SUM(ingresos) OVER (ORDER BY mes)::numeric, 2)         AS ingresos_acumulados,
    ROUND(AVG(ingresos) OVER (
        ORDER BY mes
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    )::numeric, 2)                                               AS promedio_movil_3m
FROM mensual
ORDER BY mes;


/* ------------------------------------------------------------
   3. ANALISIS PARETO (80/20) DE PRODUCTOS
   ------------------------------------------------------------
   Pregunta: ¿que productos generan la mayor parte de la plata?
   Concepto: ventana sin PARTITION (porcentaje del total) + CASE

   - SUM() OVER ()                 -> total global en cada fila.
   - SUM() OVER (ORDER BY ... DESC) -> acumulado de mayor a menor.
   Clasificacion ABC: A = el nucleo del negocio (hasta 80%),
   B = hasta 95%, C = la cola.
   ------------------------------------------------------------ */
WITH por_producto AS (
    SELECT
        producto,
        SUM(monto_venta) AS ingresos,
        SUM(ganancia)    AS ganancia
    FROM vw_ventas
    GROUP BY producto
)
SELECT
    producto,
    ROUND(ingresos::numeric, 2)                                         AS ingresos,
    ROUND((100 * ingresos / SUM(ingresos) OVER ())::numeric, 2)         AS pct_ingresos,
    ROUND((100 * SUM(ingresos) OVER (ORDER BY ingresos DESC)
           / SUM(ingresos) OVER ())::numeric, 2)                        AS pct_acumulado,
    ROUND((100 * ganancia / SUM(ganancia) OVER ())::numeric, 2)         AS pct_ganancia,
    CASE
        WHEN 100 * SUM(ingresos) OVER (ORDER BY ingresos DESC)
             / SUM(ingresos) OVER () <= 80 THEN 'A'
        WHEN 100 * SUM(ingresos) OVER (ORDER BY ingresos DESC)
             / SUM(ingresos) OVER () <= 95 THEN 'B'
        ELSE 'C'
    END                                                                 AS clase_abc
FROM por_producto
ORDER BY ingresos DESC;


/* ------------------------------------------------------------
   4. MEJORES 2 CANALES EN CADA CIUDAD
   ------------------------------------------------------------
   Pregunta: ¿donde invertir marketing en cada ciudad?
   Concepto: RANK() con PARTITION BY

   PARTITION BY ciudad reinicia el ranking en cada ciudad.
   Como no puedes filtrar una funcion de ventana en el WHERE del
   mismo SELECT, se calcula en una CTE y se filtra afuera.
   (Si hay empates, RANK deja huecos; DENSE_RANK no.)
   ------------------------------------------------------------ */
WITH ciudad_canal AS (
    SELECT
        ciudad,
        canal,
        SUM(monto_venta) AS ingresos,
        SUM(ganancia)    AS ganancia,
        COUNT(*)         AS transacciones
    FROM vw_ventas
    GROUP BY ciudad, canal
),
con_ranking AS (
    SELECT
        *,
        RANK() OVER (PARTITION BY ciudad ORDER BY ingresos DESC) AS ranking
    FROM ciudad_canal
)
SELECT
    ciudad,
    ranking,
    canal,
    ROUND(ingresos::numeric, 2) AS ingresos,
    ROUND(ganancia::numeric, 2) AS ganancia,
    transacciones
FROM con_ranking
WHERE ranking <= 2
ORDER BY ciudad, ranking;


/* ------------------------------------------------------------
   5. ¿CUANTO NOS CUESTAN LOS DESCUENTOS?
   ------------------------------------------------------------
   Pregunta: ¿los descuentos valen la pena o solo regalan margen?
   Concepto: agregaciones + SUM(COUNT(*)) OVER () + metrica derivada

   - dinero_cedido = lo que dejaste de cobrar (precio lista - precio final).
   - Ojo: este query muestra el COSTO del descuento. Para saber si
     SUBE las ventas necesitas una columna "cantidad" o comparar contra
     un periodo sin descuento. Con tu dataset actual (descuentos
     asignados al azar) no vas a ver un efecto en volumen, y eso es
     una razon mas para mejorar el generador de datos.
   ------------------------------------------------------------ */
SELECT
    descuento_pct,
    COUNT(*)                                                       AS transacciones,
    ROUND((100.0 * COUNT(*) / SUM(COUNT(*)) OVER ())::numeric, 2)  AS pct_transacciones,
    ROUND(AVG(monto_venta)::numeric, 2)                            AS ticket_promedio,
    ROUND(AVG(margen_pct)::numeric, 2)                             AS margen_promedio_pct,
    ROUND(SUM(ganancia)::numeric, 2)                               AS ganancia_total,
    ROUND(SUM(precio_unitario - monto_venta)::numeric, 2)          AS dinero_cedido
FROM vw_ventas
GROUP BY descuento_pct
ORDER BY descuento_pct;


/* ------------------------------------------------------------
   6. VENTAS PROMEDIO POR DIA DE LA SEMANA (incluyendo dias sin ventas)
   ------------------------------------------------------------
   Pregunta: ¿que dia se vende mas? (tu README dice que el lunes)
   Concepto: generate_series + LEFT JOIN + COALESCE

   Error clasico: promediar solo los dias que SI tuvieron ventas
   infla el resultado. Aqui se crea un calendario con TODOS los dias
   y los dias sin ventas cuentan como 0.
   (Si prefieres, cambia generate_series por tu tabla calendario.)
   ------------------------------------------------------------ */
WITH dias AS (
    SELECT d::date AS dia
    FROM generate_series(
        (SELECT MIN(fecha)::date FROM vw_ventas),
        (SELECT MAX(fecha)::date FROM vw_ventas),
        INTERVAL '1 day'
    ) AS d
),
ventas_dia AS (
    SELECT fecha::date AS dia, SUM(monto_venta) AS total
    FROM vw_ventas
    GROUP BY 1
)
SELECT
    EXTRACT(ISODOW FROM d.dia)::int AS num_dia,
    (ARRAY['Lunes','Martes','Miercoles','Jueves','Viernes','Sabado','Domingo'])
        [EXTRACT(ISODOW FROM d.dia)::int]  AS dia_semana,
    COUNT(*)                               AS dias_en_periodo,
    COUNT(v.total)                         AS dias_con_ventas,
    ROUND(SUM(COALESCE(v.total, 0))::numeric, 2)  AS ingresos_totales,
    ROUND(AVG(COALESCE(v.total, 0))::numeric, 2)  AS promedio_diario
FROM dias d
LEFT JOIN ventas_dia v ON v.dia = d.dia
GROUP BY 1, 2
ORDER BY 1;
