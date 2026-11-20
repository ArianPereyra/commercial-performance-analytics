# Commercial Performance & Profitability Analytics

**Proyecto de portafolio | Inteligencia comercial B2B | 2024–2025**

Análisis de un escenario comercial B2B con **datos simulados**, orientado a comprender ventas, rentabilidad, cumplimiento de metas, comportamiento de clientes y oportunidades de mejora.

## Objetivo de negocio

Consolidar indicadores comerciales y financieros en un dashboard interactivo para facilitar el seguimiento de resultados y la identificación de riesgos y oportunidades.

## Herramientas

- **PostgreSQL / SQL:** consulta y preparación de los datos.
- **Excel:** verificaciones y conciliación de resultados.
- **Power BI / Power Query / DAX:** modelado, indicadores y visualización interactiva.

## Dashboard

El informe cuenta con cuatro páginas:

1. **Resumen Ejecutivo:** ventas, margen bruto, cumplimiento de metas, pedidos, evolución mensual y ranking de vendedores.
2. **Rentabilidad:** margen por categoría y producto, ventas a pérdida y margen porcentual por nivel de descuento.
3. **Desempeño comercial:** ventas frente a metas, cumplimiento y rentabilidad por ejecutivo.
4. **Clientes:** compradores, recurrencia, segmentos, clientes más rentables e inactividad de 90 días.

## Resultados del caso (2024–2025)

| Indicador | Resultado |
|---|---:|
| Ventas netas | S/ 15,303,659.10 |
| Margen bruto | S/ 3,040,753.95 |
| Margen bruto porcentual | 19.87% |
| Cumplimiento de metas | 162.91% |
| Pedidos distintos | 3,733 |
| Líneas de ventas | 11,147 |
| Clientes compradores | 120 |

### Hallazgos

- Los segmentos **Corporativa y Mediana** representan aproximadamente **80.9%** de las ventas netas del caso.
- El **Ejecutivo Comercial 06** lidera el ranking de ventas, con aproximadamente **S/ 2.11 millones**.
- Se identificaron **S/ 45,146.79** de margen bruto negativo agregado en líneas con pérdida; conviene investigar costos, precios y descuentos.
- Al cierre de 2025, el indicador de inactividad de **90 días** identificó **5 clientes** según la definición implementada en el dashboard.
- La **tasa de recompra mensual** mide el porcentaje de compradores con al menos dos pedidos distintos *dentro del mes*; no equivale a una tasa de retención entre meses.

Estos resultados describen únicamente un **dataset simulado**. Las recomendaciones comerciales son hipótesis para análisis, no conclusiones causales.

## Controles de calidad

- Conciliación: `Ventas netas − Costos totales − Margen bruto = 0` en 2024 y 2025.
- Conteo de líneas de ventas: **11,147**, coincidente entre las herramientas empleadas.
- Duplicados de `linea_id`: **0**.
- Filas con nulos en los campos esenciales evaluados: **0**.
- Validación de relaciones y filtros de las páginas del dashboard.

## Archivos

- `PowerBI/Commercial_Performance_Analytics_Final.pbix`: informe interactivo. *(Agregar el archivo local.)*
- `SQL/`: consultas SQL del proyecto. *(Agregar los scripts originales.)*
- `Imagenes/`: capturas reales de las cuatro páginas. *(Agregar capturas exportadas.)*

> **Nota:** El repositorio no contiene datos empresariales reales. Para reproducir las cifras se necesita disponer del dataset simulado y de las consultas originales; adjuntarlos solamente si tienes derecho a compartirlos.

## Autor

**Arian Rizaga** — Proyecto individual de análisis comercial y Business Intelligence.
