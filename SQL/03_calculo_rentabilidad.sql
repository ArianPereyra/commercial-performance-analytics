
-- PROYECTO: Commercial Performance & Profitability Analytics
-- ETAPA 3: SQL & Data Preparation
-- Consulta 03: Cálculo de rentabilidad por línea de venta

SELECT
    p.pedido_id,
    p.fecha_pedido,
    p.estado,
    d.linea_id,
    d.producto_id,
    d.cantidad,
    d.precio_unitario_lista,
    d.descuento_pct,
    d.costo_unitario,

    -- 1. Calcular venta neta por línea
    ROUND(
        d.cantidad * d.precio_unitario_lista
        * (1 - d.descuento_pct / 100),
        2
    ) AS venta_neta_linea,

    -- 2. Calcular costo total por línea
    ROUND(
        d.cantidad * d.costo_unitario,
        2
    ) AS costo_total_linea,

    -- 3. Calcular margen bruto por línea
    ROUND(
        d.cantidad * d.precio_unitario_lista
        * (1 - d.descuento_pct / 100)
        - d.cantidad * d.costo_unitario,
        2
    ) AS margen_bruto_linea

FROM pedidos p
INNER JOIN detalle_pedidos d
    ON p.pedido_id = d.pedido_id

-- Considerar únicamente pedidos facturados
WHERE p.estado = 'Facturado'

ORDER BY d.linea_id

LIMIT 20;
