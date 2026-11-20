
-- PROYECTO: Commercial Performance & Profitability Analytics
-- CONSULTA 16: Identificación de clientes inactivos
-- Fecha de corte: 31/12/2025
-- Regla: inactividad superior a 90 días

WITH ultima_compra AS (
    SELECT
        cliente_id,
        MAX(fecha_pedido) AS fecha_ultima_compra,
        COUNT(DISTINCT pedido_id) AS total_pedidos

    FROM pedidos
    WHERE estado = 'Facturado'
      AND fecha_pedido <= DATE '2025-12-31'

    GROUP BY cliente_id
),

clasificacion AS (
    SELECT
        c.cliente_id,
        c.cliente_nombre,
        c.segmento,
        c.zona,
        c.vendedor_id,
        u.fecha_ultima_compra,
        COALESCE(u.total_pedidos, 0) AS total_pedidos,

        DATE '2025-12-31'
        - u.fecha_ultima_compra AS dias_sin_comprar,

        CASE
            WHEN u.fecha_ultima_compra IS NULL
                THEN 'Sin compras'

            WHEN u.fecha_ultima_compra
                 < DATE '2025-12-31' - 90
                THEN 'Inactivo'

            ELSE 'Activo'
        END AS estado_cliente

    FROM clientes c

    LEFT JOIN ultima_compra u
        ON c.cliente_id = u.cliente_id
)

SELECT
    cliente_id,
    cliente_nombre,
    segmento,
    zona,
    vendedor_id,
    fecha_ultima_compra,
    dias_sin_comprar,
    total_pedidos,
    estado_cliente

FROM clasificacion

ORDER BY
    dias_sin_comprar DESC NULLS LAST,
    cliente_id;
