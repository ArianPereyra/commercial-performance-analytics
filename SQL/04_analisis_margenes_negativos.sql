
-- PROYECTO: Commercial Performance & Profitability Analytics
-- CONSULTA 04: Identificación de márgenes negativos

WITH ventas AS (
    SELECT
        p.pedido_id,
        p.fecha_pedido,
        p.cliente_id,
        p.vendedor_id,
        d.linea_id,
        d.producto_id,

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

rentabilidad AS (
    SELECT
        *,
        venta_neta - costo_total AS margen_bruto
    FROM ventas
)

SELECT
    COUNT(*) AS lineas_margen_negativo,
    ROUND(SUM(venta_neta), 2) AS ventas_afectadas,
    ROUND(SUM(margen_bruto), 2) AS margen_negativo_total

FROM rentabilidad
WHERE margen_bruto < 0;
