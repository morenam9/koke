# KOKE - Tienda de Kokedamas

## 1. Project Overview

**Nombre del proyecto:** KOKE - Tienda de Kokedamas  
**Tipo:** E-commerce de una sola página (SPA)  
**Funcionalidad principal:** Venta de kokedamas (bonsái japonés en esfera de musgo) con pedido directo por WhatsApp  
**Target:** Personas que buscan plantas decorativas para interiores, amantes de la naturaleza y décoration zen

---

## 2. UI/UX Specification

### Layout Structure

**Sections:**
1. **Header** - Logo, navegación (inicio, productos, cuidados, contacto)
2. **Hero** - Bienvenida con imagen principal y.call-to-action
3. **Productos** - Catálogo de kokedamas disponibles
4. **Cuidados** - Guía de cuidados de las kokedamas
5. **Carrito** - Resumen de compra flotante
6. **Footer** - Información de contacto y redes sociales

**Responsive Breakpoints:**
- Mobile: < 768px (1 columna)
- Tablet: 768px - 1024px (2 columnas)
- Desktop: > 1024px (3 columnas)

### Visual Design

**Color Palette:**
- Primary: `#2D5A3D` (Verde bosque profundo)
- Secondary: `#8B9A6B` (Verde sage)
- Accent: `#D4A574` (Terracota/dorado cálido)
- Background: `#FAF8F5` (Crema cálido)
- Text: `#1A1A1A` (Negro suave)
- Text Light: `#6B6B6B` (Gris medio)

**Typography:**
- Headings: 'Playfair Display', serif (elegante, editorial)
- Body: 'Nunito', sans-serif (friendly, legible)
- Logo: 'Playfair Display' italic

**Spacing:**
- Base unit: 8px
- Section padding: 80px vertical (desktop), 48px (mobile)

**Visual Effects:**
- Cards con sombras suaves `0 4px 20px rgba(0,0,0,0.08)`
- Hover en cards: lift + shadow aumentado
- Transiciones: 0.3s ease-out
- Imágenes con border-radius generoso (16px)

### Components

**Botones:**
- Primary: Fondo verde, texto blanco, padding 16px 32px, border-radius 50px
- Secondary: Borde verde, texto verde, fondo transparente
- Estados: hover (escala 1.02, sombra), active (escala 0.98)

**Tarjetas de producto:**
- Imagen grande (aspect-ratio 1:1)
- Nombre de planta
- Precio
- Botón "Agregar al carrito"
- Hover: translateY(-8px), sombra

**Carrito flotante:**
- Icono de bolsa con contador
- Sidebar desde la derecha
- Lista de items con posibilidad de eliminar
- Total y botón "Pedir por WhatsApp"

**Formulario de checkout:**
- Campos: Nombre, Teléfono, Dirección, Método de pago
- Validación visual inline

---

## 3. Functionality Specification

### Core Features

1. **Catálogo de productos**
   - 6 kokedamas diferentes con:
     - Nombre (ej: Sakura, Pino, Helecho, Lírio, Ficus, Bambú)
     - Descripción breve
     - Precio
     - Imagen (placeholder con emoji/illustración)

2. **Carrito de compras**
   - Agregar productos
   - Ver cantidad
   - Eliminar productos
   - Calcular total

3. **Checkout simplificado**
   - Recolección de datos del cliente:
     - Nombre completo
     - Teléfono (para WhatsApp)
     - Dirección de entrega
     - Método de pago (Efectivo/Transferencia)
   - Nota adicional opcional

4. **Envío por WhatsApp**
   - Generar mensaje automático con:
     - Resumen del pedido
     - Datos del cliente
     - Total
     - Link de WhatsApp con mensaje prellenado

### User Flow

1. Usuario llega a la página
2. Explora productos en la sección inicio
3. Lee cuidados si tiene dudas
4. Agrega productos al carrito
5. Completa formulario con sus datos
6. Click "Pedir por WhatsApp"
7. Se abre WhatsApp con mensaje listo

### Edge Cases
- Carrito vacío: mostrar mensaje friendly
- Sin teléfono válido: validar formato
- Página sin JavaScript: mensaje de fallback

---

## 4. Acceptance Criteria

- [ ] Página carga sin errores
- [ ] Logo "KOKE" visible en header
- [ ] 6 productos mostrados en catálogo
- [ ] Agregar producto al carrito funciona
- [ ] Contador de items actualiza
- [ ] Carrito muestra items y total
- [ ] Eliminación de items funciona
- [ ] Formulario valida campos requeridos
- [ ] Botón WhatsApp genera mensaje correcto
- [ ] Diseño responsive en mobile
- [ ] Sección cuidados visible y legible
- [ ] Animaciones suaves sin lag

---

## 5. Technical Notes

- Single HTML file con CSS y JS embebidos
- No requiere backend (WhatsApp API)
- Imágenes: uso de imágenes placeholder o emojis stylized
- WhatsApp link format: `https://wa.me/NUMERO?text=MENSAJE`