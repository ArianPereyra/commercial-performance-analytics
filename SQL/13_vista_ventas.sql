
-- PROYECTO: Commercial Performance & Profitability Analytics
-- CONSULTA 13: Vista reutilizable de ventas y rentabilidad

CREATE OR REPLACE VIEW vw_ventas_rentabilidad AS

SELECT
    d.linea_id,
    p.pedido_id,
    p.fecha_pedido,
    DATE_TRUNC('month', p.fecha_pedido)::DATE AS mes,
    p.cliente_id,
    p.vendedor_id,
    d.producto_id,
    d.cantidad,
    d.precio_unitario_lista,
    d.descuento_pct,
    d.costo_unitario,

    -- Venta neta por línea
    ROUND(
        d.cantidad * d.precio_unitario_lista
        * (1 - d.descuento_pct / 100),
        2
    ) AS venta_neta,

    -- Costo total por línea
    ROUND(
        d.cantidad * d.costo_unitario,
        2
    ) AS costo_total,

    -- Margen bruto en soles
    ROUND(
        d.cantidad * d.precio_unitario_lista
        * (1 - d.descuento_pct / 100)
        - d.cantidad * d.costo_unitario,
        2
    ) AS margen_bruto

FROM pedidos p

INNER JOIN detalle_pedidos d
    ON p.pedido_id = d.pedido_id

WHERE p.estado = 'Facturado';
