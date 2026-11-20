
-- PROYECTO: Commercial Performance & Profitability Analytics
-- CONSULTA 05: Productos con margen bruto negativo

WITH ventas AS (
    SELECT
        d.linea_id,
        d.producto_id,
        pr.producto_nombre,
        c.categoria_nombre,
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

    INNER JOIN productos pr
        ON d.producto_id = pr.producto_id

    INNER JOIN categorias c
        ON pr.categoria_id = c.categoria_id

    WHERE p.estado = 'Facturado'
),

rentabilidad AS (
    SELECT
        *,
        venta_neta - costo_total AS margen_bruto
    FROM ventas
)

SELECT
    producto_id,
    producto_nombre,
    categoria_nombre,

    COUNT(*) AS lineas_negativas,

    ROUND(SUM(venta_neta), 2)
        AS ventas_afectadas,

    ROUND(SUM(margen_bruto), 2)
        AS margen_negativo_total,

    ROUND(AVG(descuento_pct), 2)
        AS descuento_promedio_pct

FROM rentabilidad

WHERE margen_bruto < 0

GROUP BY
    producto_id,
    producto_nombre,
    categoria_nombre

ORDER BY margen_negativo_total ASC;
