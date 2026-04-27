-- Dar permisos completos a service_role
GRANT SELECT, INSERT, UPDATE, DELETE ON public.productos TO service_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.pedidos TO service_role;

-- Tambien dar permisos a anon (para la web)
GRANT SELECT ON public.productos TO anon;
GRANT INSERT ON public.pedidos TO anon;

-- Refrescar cache
NOTIFY pgrst, 'reload schema';