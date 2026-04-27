-- ================================================
-- KOKE - Configuración de Base de Datos
-- Ejecutar este SQL en el SQL Editor de Supabase
-- ================================================

-- 1. Extensiones necesarias
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. Tabla PRODUCTOS
CREATE TABLE productos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nombre TEXT NOT NULL,
    descripcion TEXT,
    precio INTEGER NOT NULL,
    stock INTEGER DEFAULT 0,
    imagen TEXT,
    activo BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Insertar productos iniciales de KOKE
INSERT INTO productos (nombre, descripcion, precio, stock, imagen, activo) VALUES
('Sansiviera', 'Purificadora de aire. Resistente y elegante.', 4500, 10, 'img/kokedama-Lengua-de-suegra.jpg', true),
('Potus', 'Enredadera facilisima. Perfecta para principiantes.', 3800, 10, 'img/kokedama_potus_2.webp', true),
('Jade', 'Suculenta de suerte. Prosperidad para tu hogar.', 3200, 10, 'img/kokedama_jade.webp', true),
('Tradescantia', 'Hojas zebradas violetas. Colores únicos.', 4200, 10, 'img/kokedama_pasion_purpura.jpg', true),
('Monstera adansonii', 'Hojas perforadas. Selva urbana en tu casa.', 5500, 10, 'img/kokedama-adansonii.webp', true),
('Lazo de Amor', 'Corazones colgantes. Amor en forma de planta.', 4000, 10, 'img/kokedama_lazo_amor.webp', true);

-- 3. Tabla PEDIDOS
CREATE TABLE pedidos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    cliente_nombre TEXT NOT NULL,
    cliente_telefono TEXT,
    cliente_direccion TEXT,
    items JSONB NOT NULL,
    total INTEGER NOT NULL,
    medio TEXT DEFAULT 'web',
    metodo_pago TEXT DEFAULT 'efectivo',
    estado TEXT DEFAULT 'pendiente',
    notas TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ================================================
-- SECURITY (RLS)
-- ================================================

-- Habilitar RLS en ambas tablas
ALTER TABLE productos ENABLE ROW LEVEL SECURITY;
ALTER TABLE pedidos ENABLE ROW LEVEL SECURITY;

-- Política: Cualquiera puede ver productos activos
CREATE POLICY "productos_visibles" ON productos
    FOR SELECT USING (activo = true);

-- Política: Cualquiera puede crear pedidos
CREATE POLICY "crear_pedidos" ON pedidos
    FOR INSERT WITH CHECK (true);

-- Política: Solo lectura de pedidos (para dashboard)
CREATE POLICY "leer_pedidos" ON pedidos
    FOR SELECT USING (true);

-- ================================================
-- FUNCIONES ÚTILES
-- ================================================

-- Función para obtener resumen mensual
CREATE OR REPLACE FUNCTION get_resumen_mes(mes INTEGER, anio INTEGER)
RETURNS TABLE(
    mes TEXT,
    cantidad_pedidos BIGINT,
    ingresos INTEGER,
    producto_top TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        TO_CHAR(DATE_TRUNC('month', created_at), 'YYYY-MM')::TEXT,
        COUNT(*)::BIGINT,
        SUM(total)::INTEGER,
        (JSONB_EXTRACT_ARRAY_ELEMENTS(
            (SELECT JSONB_AGG((items->0)->>'nombre')
            FROM pedidos
            WHERE DATE_TRUNC('month', created_at) = DATE_TRUNC('month', TO_TIMESTAMP(anio || '-' || mes || '-01', 'YYYY-MM-DD'))
        ))[0]::TEXT
    FROM pedidos
    WHERE EXTRACT(MONTH FROM created_at) = mes
    AND EXTRACT(YEAR FROM created_at) = anio
    AND estado != 'cancelado'
    GROUP BY DATE_TRUNC('month', created_at);
END;
$$ LANGUAGE plpgsql;

-- ================================================
-- VERIFICAR QUE TODO ESTÉ BIEN
-- ================================================
SELECT 
    '✅ Productos configurados' as status,
    COUNT(*) as total
FROM productos;

SELECT 
    '✅ pedidos configurado' as status,
    COUNT(*) as total
FROM pedidos;