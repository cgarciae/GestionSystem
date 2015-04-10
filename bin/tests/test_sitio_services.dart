part of aristadart.tests;

sitioServicesTests ()
{
    MongoDbManager dbManager = new MongoDbManager("mongodb://${partialDBHost}/servicesTesting");
    MongoDb db;
    MongoService mongoService;
    SitioServices sitioServices;
    group("Sitio Services Tests:", ()
    {
        setUp(() async
        {
            db = await dbManager.getConnection();
            mongoService = new MongoServiceMock.spy (new MongoService.fromMongoDb(db));
            sitioServices = new SitioServices (mongoService);
        });

        //remove all loaded handlers
        tearDown(() async
        {
            await db.innerConn.collection(Col.sitio).drop();
            dbManager.closeConnection (db);
        });
        
        test("New", () async
        {
            var sitio = await sitioServices.New();
            
            expect (sitio.descripcion != null, true);
            expect (sitio.categorias, []);
            expect (sitio.id != null, true);
            expect (sitio.destacadas, []);
        });
        
        test("Get", () async
        {
            //Nuevo Sitio
            var sitio = await sitioServices.New();
            
            //Get
            var sitioGet = await sitioServices.Get (sitio.id);
            
            expect (encode(sitio), encode(sitioGet));
        });
        
        test("Update", () async
        {
            //Nuevo Sitio
            var sitio = await sitioServices.New();
            
            //Actualizar Sitio
            var actualizacion = "AAA";
            var sitioActualizado = await sitioServices.Update(sitio.id, new Sitio()..descripcion = actualizacion);
            
            expect (sitio.id, sitioActualizado.id);
            expect(sitioActualizado.descripcion, actualizacion);
        });
        
        test("Delete", () async
        {
            //Nuevo Sitio
            var sitio = await sitioServices.New();
            
            //Eliminar
            Ref ref = await sitioServices.Delete(sitio.id);
            expect (ref.id, sitio.id);
            
            //Validar sitio borrado
            var borrado = await sitioServices.findOne(where.id(StringToId(sitio.id)));
            expect (borrado, null);
        });
        
        test("Agregar y Eliminar Imagen Slider", () async
        {
            //Nuevo Sitio
            var sitio = await sitioServices.New();
            
            expect (sitio.slider, []);
            
            //Agregar Imagen
            var imagen = new ImagenSlider()
                ..caption = "caption";
            
            await sitioServices.AgregarImagenSlider (sitio.id, imagen);
            var sitioActualizado = await sitioServices.Get(sitio.id);
            
            //Validar
            expect (sitioActualizado.slider.length, 1);
            
            //Eliminar Imagen
            await sitioServices.EliminarImagenSlider(sitio.id, imagen);
            sitioActualizado = await sitioServices.Get(sitio.id);
            
            //Validar
            expect (sitioActualizado.slider.length, 0);
        });
        
        test("Agregar y Eliminar Categoria", () async
        {
            //Nuevo Sitio
            var sitio = await sitioServices.New();
            
            expect (sitio.categorias, []);
            
            //Agregar Categoria
            var categoria = new Categoria()
                ..id = newId();
            
            await sitioServices.AgregarCategoria (sitio.id, categoria);
            var sitioActualizado = await sitioServices.Get(sitio.id);
            
            //Validar
            expect (sitioActualizado.categorias.length, 1);
            
            //Eliminar Categoria
            await sitioServices.EliminarCategoria (sitio.id, categoria);
            sitioActualizado = await sitioServices.Get(sitio.id);
            
            //Validar
            expect (sitioActualizado.slider.length, 0);
        });
        
        test("Agregar y Eliminar Categoria Destacada", () async
        {
            //Nuevo Sitio
            var sitio = await sitioServices.New();
            
            expect (sitio.destacadas, []);
            
            //Agregar Categoria
            var categoria = new Categoria()
                ..id = newId();
            
            await sitioServices.AgregarCategoriaDestacada (sitio.id, categoria);
            var sitioActualizado = await sitioServices.Get(sitio.id);
            
            //Validar
            expect (sitioActualizado.destacadas.length, 1);
            
            //Eliminar Destacada
            await sitioServices.EliminarCategoriaDestacada (sitio.id, categoria);
            sitioActualizado = await sitioServices.Get(sitio.id);
            
            //Validar
            expect (sitioActualizado.destacadas.length, 0);
        });
    });
}

