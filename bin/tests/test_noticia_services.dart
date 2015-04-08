part of aristadart.tests;

noticiaServicesTests ()
{
    MongoDbManager dbManager = new MongoDbManager("mongodb://${partialDBHost}/userTesting");
    group("Noticia Services Tests", ()
    {
        ProtectedUser basicUser;
        var id = newId();
        
        createBasicUser () async
        {
            //Insertar usuario
            MongoDb db = await dbManager.getConnection();
            basicUser = new ProtectedUser()
                ..id = newId()
                ..admin = true;
            
            await db.insert (Col.user, basicUser);
            dbManager.closeConnection (db);
        }
        
        setUp(() async
        {
            app.addPlugin (getMapperPlugin(dbManager));
            app.addPlugin (AuthenticationPlugin);
            app.addPlugin (ErrorCatchPlugin);
            
            await createBasicUser();
        });

        //remove all loaded handlers
        tearDown(() async
        {
            app.tearDown();
            
            //Clear users
            MongoDb db = await dbManager.getConnection();
            await db.collection('user').drop();
            dbManager.closeConnection(db);
        });
        
        test("New", () async
        {
            var mongoService = new MongoServiceMock();
            var noticia = new Noticia()
                ..titulo = "Titulo"
                ..texto = "Texto";
            
            //SETUP
            app.addModule (new Module()
                  ..bind(UserServives)
                  ..bind(GoogleServices)//Injectar mock
                  ..bind(FileServices)
                  ..bind(MongoService, toValue: mongoService));
          
            app.setUp([#aristadart.server]);
        
            //Crear mock request
            MockRequest req = new MockRequest
            (
                '/noticia', method: app.POST, headers: {Header.authorization : basicUser.id}
            );
      
            //dispatch request
            MockHttpResponse resp = await app.dispatch(req);
            
            Noticia respNoticia = decodeJson(resp.mockContent, Noticia);
          
            
            
            expect (respNoticia.titulo, noticia.titulo, reason: resp.mockContent);
            expect (respNoticia.texto, noticia.texto);
        });
        
        test("New 2", () async
        {
            var mongoService = new MongoServiceMock();
            var noticia = new Noticia()
                ..titulo = "Titulo"
                ..texto = "Texto";
            
            var noticiaService = new NoticiaServices (mongoService);
            
            Noticia respNoticia = await noticiaService.New();
             
            expect (respNoticia.titulo, noticia.titulo);
            expect (respNoticia.texto, noticia.texto);
        });
        
        test("Get", () async
        {
            var noticia = new Noticia()
                ..titulo = "Titulo"
                ..texto = "Texto"
                ..id = newId();
            
            var mongoService = new MongoServiceMock()
                ..when(callsTo('findOne')).thenReturn (new Future.value (noticia));
            
            var noticiaService = new NoticiaServices (mongoService);
            
            Noticia respNoticia = await noticiaService.Get (noticia.id);
             
            expect (noticia, respNoticia);
        });
    });
}

