
-- PROYECTO: Commercial Performance & Profitability Analytics
-- CONSULTA 17: Validación final de datos comerciales

WITH validacion_ventas AS (
    SELECT
        COUNT(*) AS lineas_facturadas,
        COUNT(DISTINCT pedido_id) AS pedidos_facturados,
        COUNT(DISTINCT cliente_id) AS clientes_compradores,

        SUM(venta_neta) AS ventas_netas,
        SUM(costo_total) AS costos_totales,
        SUM(margen_bruto) AS margen_bruto

    FROM vw_ventas_rentabilidad
),

validacion_metas AS (
    SELECT
        COUNT(*) AS registros_metas,
        COUNT(DISTINCT mes) AS meses,
        COUNT(DISTINCT vendedor_id) AS vendedores
    FROM metas_mensuales
),

validacion_referencial AS (
    SELECT
        COUNT(*) AS lineas_sin_pedido
    FROM detalle_pedidos d
    LEFT JOIN pedidos p
        ON d.pedido_id = p.pedido_id
    WHERE p.pedido_id IS NULL
)

SELECT
    v.lineas_facturadas,
    v.pedidos_facturados,
    v.clientes_compradores,

    ROUND(v.ventas_netas, 2) AS ventas_netas,
    ROUND(v.costos_totales, 2) AS costos_totales,
    ROUND(v.margen_bruto, 2) AS margen_bruto,

    ROUND(
        v.ventas_netas - v.costos_totales - v.margen_bruto,
        2
    ) AS diferencia_conciliacion,

    m.registros_metas,
    m.meses,
    m.vendedores,

    r.lineas_sin_pedido

FROM validacion_ventas v
CROSS JOIN validacion_metas m
CROSS JOIN validacion_referencial r;
