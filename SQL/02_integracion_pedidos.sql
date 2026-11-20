
-- Integración de pedidos y detalle de ventas
SELECT
    p.pedido_id,
    p.fecha_pedido,
    p.estado,
    d.linea_id,
    d.producto_id,
    d.cantidad,
    d.precio_unitario_lista,
    d.descuento_pct,
    d.costo_unitario
FROM pedidos p
INNER JOIN detalle_pedidos d
    ON p.pedido_id = d.pedido_id
ORDER BY p.pedido_id, d.linea_id
LIMIT 20;




