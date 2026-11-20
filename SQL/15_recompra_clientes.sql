
-- PROYECTO: Commercial Performance & Profitability Analytics
-- CONSULTA 15: Tasa de recompra trimestral

WITH pedidos_validos AS (
    SELECT
        pedido_id,
        cliente_id,
        DATE_TRUNC(
            'quarter',
            fecha_pedido
        )::DATE AS trimestre

    FROM pedidos
    WHERE estado = 'Facturado'
),

compras_cliente AS (
    SELECT
        trimestre,
        cliente_id,
        COUNT(DISTINCT pedido_id) AS total_pedidos

    FROM pedidos_validos

    GROUP BY
        trimestre,
        cliente_id
)

SELECT
    trimestre,

    COUNT(*) AS clientes_compradores,

    COUNT(*) FILTER (
        WHERE total_pedidos >= 2
    ) AS clientes_recurrentes,

    ROUND(
        COUNT(*) FILTER (WHERE total_pedidos >= 2)
        * 100.0 / NULLIF(COUNT(*), 0),
        2
    ) AS tasa_recompra_pct

FROM compras_cliente

GROUP BY trimestre
ORDER BY trimestre;
