
-- PROYECTO: Commercial Performance & Profitability Analytics
-- CONSULTA 14: Análisis comercial por cliente

SELECT
    c.cliente_id,
    c.cliente_nombre,
    c.segmento,
    c.zona,
    c.vendedor_id,

    COUNT(DISTINCT v.pedido_id)
        AS total_pedidos,

    ROUND(SUM(v.venta_neta), 2)
        AS ventas_netas,

    ROUND(SUM(v.costo_total), 2)
        AS costos_totales,

    ROUND(SUM(v.margen_bruto), 2)
        AS margen_bruto,

    ROUND(
        SUM(v.margen_bruto)
        / NULLIF(SUM(v.venta_neta), 0) * 100,
        2
    ) AS margen_bruto_pct,

    ROUND(
        SUM(v.venta_neta)
        / NULLIF(COUNT(DISTINCT v.pedido_id), 0),
        2
    ) AS ticket_promedio

FROM clientes c

INNER JOIN vw_ventas_rentabilidad v
    ON c.cliente_id = v.cliente_id

GROUP BY
    c.cliente_id,
    c.cliente_nombre,
    c.segmento,
    c.zona,
    c.vendedor_id

ORDER BY margen_bruto DESC;
