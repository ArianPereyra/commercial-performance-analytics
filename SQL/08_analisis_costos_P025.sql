
-- PROYECTO: Commercial Performance & Profitability Analytics
-- CONSULTA 08: Análisis de costos del producto P025

SELECT
    d.producto_id,
    d.descuento_pct,

    COUNT(*) AS total_lineas,

    MIN(d.costo_unitario) AS costo_minimo,
    MAX(d.costo_unitario) AS costo_maximo,
    ROUND(AVG(d.costo_unitario), 2) AS costo_promedio,

    MIN(d.precio_unitario_lista) AS precio_minimo,
    MAX(d.precio_unitario_lista) AS precio_maximo,

    ROUND(
        AVG(
            d.precio_unitario_lista
            * (1 - d.descuento_pct / 100)
        ),
        2
    ) AS precio_neto_promedio

FROM pedidos p
INNER JOIN detalle_pedidos d
    ON p.pedido_id = d.pedido_id

WHERE p.estado = 'Facturado'
  AND d.producto_id = 'P025'

GROUP BY
    d.producto_id,
    d.descuento_pct

ORDER BY d.descuento_pct;
