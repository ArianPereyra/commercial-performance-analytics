
-- PROYECTO: Commercial Performance & Profitability Analytics
-- CONSULTA 06: Diagnóstico de rentabilidad del producto P025

WITH ventas AS (
    SELECT
        p.pedido_id,
        d.linea_id,
        d.producto_id,
        d.descuento_pct,

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
      AND d.producto_id = 'P025'
),

rentabilidad AS (
    SELECT
        *,
        venta_neta - costo_total AS margen_bruto
    FROM ventas
)

SELECT
    producto_id,
    COUNT(*) AS total_lineas,
    COUNT(*) FILTER (WHERE margen_bruto < 0)
        AS lineas_negativas,
    COUNT(*) FILTER (WHERE margen_bruto > 0)
        AS lineas_positivas,
    COUNT(*) FILTER (WHERE margen_bruto = 0)
        AS lineas_sin_margen,

    ROUND(SUM(venta_neta), 2)
        AS ventas_netas_totales,

    ROUND(SUM(costo_total), 2)
        AS costo_total,

    ROUND(SUM(margen_bruto), 2)
        AS margen_bruto_total,

    ROUND(
        SUM(margen_bruto)
        / NULLIF(SUM(venta_neta), 0) * 100,
        2
    ) AS margen_bruto_pct,

    ROUND(AVG(descuento_pct), 2)
        AS descuento_promedio_pct

FROM rentabilidad
GROUP BY producto_id;
