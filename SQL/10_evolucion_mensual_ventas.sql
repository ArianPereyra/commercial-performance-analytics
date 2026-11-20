
-- PROYECTO: Commercial Performance & Profitability Analytics
-- CONSULTA 10: Evolución mensual de ventas y rentabilidad

WITH ventas AS (
    SELECT
        DATE_TRUNC(
            'month',
            p.fecha_pedido
        )::DATE AS mes,

        p.pedido_id,
        p.cliente_id,

        ROUND(
            d.cantidad * d.precio_unitario_lista
            * (1 - d.descuento_pct / 100),
            2
        ) AS venta_neta,

        ROUND(
            d.cantidad * d.costo_unitario,
            2
        ) AS costo_total

    FROM pedidos p
    INNER JOIN detalle_pedidos d
        ON p.pedido_id = d.pedido_id

    WHERE p.estado = 'Facturado'
),

ventas_mensuales AS (
    SELECT
        mes,
        COUNT(DISTINCT pedido_id) AS total_pedidos,
        COUNT(DISTINCT cliente_id) AS clientes_compradores,

        SUM(venta_neta) AS ventas_netas,
        SUM(costo_total) AS costos_totales

    FROM ventas
    GROUP BY mes
),

indicadores AS (
    SELECT
        mes,
        total_pedidos,
        clientes_compradores,
        ROUND(ventas_netas, 2) AS ventas_netas,

        ROUND(
            ventas_netas - costos_totales,
            2
        ) AS margen_bruto,

        ROUND(
            (ventas_netas - costos_totales)
            / NULLIF(ventas_netas, 0) * 100,
            2
        ) AS margen_bruto_pct,

        LAG(ventas_netas) OVER (
            ORDER BY mes
        ) AS ventas_mes_anterior

    FROM ventas_mensuales
)

SELECT
    mes,
    total_pedidos,
    clientes_compradores,
    ventas_netas,
    margen_bruto,
    margen_bruto_pct,

    ROUND(
        (ventas_netas - ventas_mes_anterior)
        / NULLIF(ventas_mes_anterior, 0) * 100,
        2
    ) AS variacion_mensual_pct

FROM indicadores
ORDER BY mes;
