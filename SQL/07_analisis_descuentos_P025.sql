
-- PROYECTO: Commercial Performance & Profitability Analytics
-- CONSULTA 07: Rentabilidad por descuento del producto P025

WITH ventas AS (
    SELECT
        d.linea_id,
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
    descuento_pct,
    COUNT(*) AS total_lineas,

    COUNT(*) FILTER (WHERE margen_bruto < 0)
        AS lineas_negativas,

    ROUND(SUM(venta_neta), 2)
        AS ventas_netas,

    ROUND(SUM(margen_bruto), 2)
        AS margen_bruto,

    ROUND(
        SUM(margen_bruto)
        / NULLIF(SUM(venta_neta), 0) * 100,
        2
    ) AS margen_bruto_pct

FROM rentabilidad

GROUP BY descuento_pct
ORDER BY descuento_pct;
