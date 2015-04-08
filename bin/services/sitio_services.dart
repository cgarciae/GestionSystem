part of aristadart.server;

@app.Group('/${Col.sitio}')
@Catch()
@Encode()
class SitioServices extends AristaService<Sitio>
{
    SitioServices (MongoService mongoDb) : super (Col.sitio, mongoDb);
    
    @app.DefaultRoute (methods: const [app.POST])
    @Private(ADMIN)
    Future<Sitio> New ()
    {
        throw new UnimplementedError();
    }
    
    @app.Route ('/:id', methods: const [app.GET])
    @Private(ADMIN)
    Future<Sitio> Get (String id, {@app.QueryParam() bool export: false})
    {
        throw new UnimplementedError();
    }
    
    @app.Route ('/:id', methods: const [app.PUT])
    @Private(ADMIN)
    Future<Sitio> Update (String id, Sitio delta)
    {
        throw new UnimplementedError();
    }
    
    //DELETE /:id ::
    @app.Route ('/:id', methods: const [app.DELETE])
    @Private(ADMIN)
    Future<Ref> Delete (String id)
    {
        throw new UnimplementedError();
    }

    @app.Route ('/:id/agregarCategoria', methods: const [app.POST])
    @Private(ADMIN)
    Future<BoolResp> AgregarCategoria (String id, Categoria categoria)
    {
        throw new UnimplementedError();
    }
    
    @app.Route ('/:id/eliminarCategoria', methods: const [app.DELETE])
    @Private(ADMIN)
    Future<BoolResp> EliminarCategoria (String id, Categoria categoria)
    {
        throw new UnimplementedError();
    }

    @app.Route ('/:id/agregarCategoriaDestacada', methods: const [app.POST])
    @Private(ADMIN)
    Future<BoolResp> AgregarCategoriaDestacada (String id, Categoria categoria)
    {
        throw new UnimplementedError();
    }
    
    @app.Route ('/:id/eliminarCategoriaDestacada', methods: const [app.DELETE])
    @Private(ADMIN)
    Future<BoolResp> EliminarCategoriaDestacada (String id, Categoria categoria)
    {
        throw new UnimplementedError();
    }

    @app.Route ('/:id/agregarImagenSlider', methods: const [app.POST])
    @Private(ADMIN)
    Future<BoolResp> AgregarImagenSlider (String id, ImagenSlider imagenSlider)
    {
        throw new UnimplementedError();
    }
    
    @app.Route ('/:id/eliminarImagenSlider', methods: const [app.DELETE])
    @Private(ADMIN)
    Future<BoolResp> EliminarImagenSlider (String id, ImagenSlider imagenSlider)
    {
        throw new UnimplementedError();
    }

}

