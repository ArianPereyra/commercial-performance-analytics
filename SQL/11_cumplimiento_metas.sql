
-- PROYECTO: Commercial Performance & Profitability Analytics
-- CONSULTA 11: Cumplimiento de metas por vendedor y mes

WITH ventas_mensuales AS (
    SELECT
        TO_CHAR(p.fecha_pedido, 'YYYY-MM') AS mes,
        p.vendedor_id,

        SUM(
            ROUND(
                d.cantidad * d.precio_unitario_lista
                * (1 - d.descuento_pct / 100),
                2
            )
        ) AS ventas_netas

    FROM pedidos p
    INNER JOIN detalle_pedidos d
        ON p.pedido_id = d.pedido_id

    WHERE p.estado = 'Facturado'

    GROUP BY
        TO_CHAR(p.fecha_pedido, 'YYYY-MM'),
        p.vendedor_id
)

SELECT
    m.mes,
    m.vendedor_id,
    v.nombre AS vendedor,
    m.meta_ventas,

    COALESCE(vm.ventas_netas, 0) AS ventas_netas,

    ROUND(
        COALESCE(vm.ventas_netas, 0)
        / NULLIF(m.meta_ventas, 0) * 100,
        2
    ) AS cumplimiento_pct,

    ROUND(
        COALESCE(vm.ventas_netas, 0) - m.meta_ventas,
        2
    ) AS desviacion_soles

FROM metas_mensuales m

INNER JOIN vendedores v
    ON m.vendedor_id = v.vendedor_id

LEFT JOIN ventas_mensuales vm
    ON m.mes = vm.mes
   AND m.vendedor_id = vm.vendedor_id

ORDER BY m.mes, m.vendedor_id;
