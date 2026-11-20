
-- PROYECTO: Commercial Performance & Profitability Analytics
-- CONSULTA 12: Desempeño acumulado por vendedor
-- Periodo: 2024-2025

WITH ventas_vendedor AS (
    SELECT
        p.vendedor_id,

        SUM(
            ROUND(
                d.cantidad * d.precio_unitario_lista
                * (1 - d.descuento_pct / 100),
                2
            )
        ) AS ventas_netas,

        SUM(
            ROUND(
                d.cantidad * d.costo_unitario,
                2
            )
        ) AS costos_totales

    FROM pedidos p
    INNER JOIN detalle_pedidos d
        ON p.pedido_id = d.pedido_id

    WHERE p.estado = 'Facturado'

    GROUP BY p.vendedor_id
),

metas_vendedor AS (
    SELECT
        vendedor_id,
        SUM(meta_ventas) AS meta_total
    FROM metas_mensuales
    GROUP BY vendedor_id
)

SELECT
    v.vendedor_id,
    v.nombre,
    v.zona,

    ROUND(m.meta_total, 2) AS meta_total,

    ROUND(
        COALESCE(ve.ventas_netas, 0),
        2
    ) AS ventas_netas,

    ROUND(
        COALESCE(ve.ventas_netas, 0) - m.meta_total,
        2
    ) AS desviacion_soles,

    ROUND(
        COALESCE(ve.ventas_netas, 0)
        / NULLIF(m.meta_total, 0) * 100,
        2
    ) AS cumplimiento_pct,

    ROUND(
        COALESCE(ve.ventas_netas, 0)
        - COALESCE(ve.costos_totales, 0),
        2
    ) AS margen_bruto,

    ROUND(
        (COALESCE(ve.ventas_netas, 0)
        - COALESCE(ve.costos_totales, 0))
        / NULLIF(ve.ventas_netas, 0) * 100,
        2
    ) AS margen_bruto_pct

FROM vendedores v

LEFT JOIN metas_vendedor m
    ON v.vendedor_id = m.vendedor_id

LEFT JOIN ventas_vendedor ve
    ON v.vendedor_id = ve.vendedor_id

ORDER BY cumplimiento_pct DESC;
