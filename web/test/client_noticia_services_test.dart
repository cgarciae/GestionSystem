part of aristadart.client.tests;

clientNoticiaServicesTest ()
{
    group ("Noticia Services:", ()
    {
        Requester requester;
        ClientNoticiaServices noticiaServices;
        
        setUp(()
        {
            requester = new RequesterMock();
            noticiaServices = new ClientNoticiaServices(requester);
        });
        
        tearDown(()
        {
            
        });
        
        test ("New", ()
        {
            String noticia = encodeJson(new Noticia()
                ..id = "1234"
                ..texto = "Texto"
                ..titulo = "Titulo");
            
            
            throw new UnimplementedError();
        });
        
        test ("Get", ()
        {
            throw new UnimplementedError();
        });
        
        test ("Update", ()
        {
            throw new UnimplementedError();
        });
        
        test ("Delete", ()
        {
            throw new UnimplementedError();
        });
        
        test ("Ultimas", ()
        {
            throw new UnimplementedError();
        });
    });
}