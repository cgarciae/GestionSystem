part of aristadart.tests;

homeServicesTests ()
{
    MongoDbManager dbManager = new MongoDbManager("mongodb://${partialDBHost}/userTesting");
    group("Home Services Tests", ()
    {
        setUp(() async
        {
            
        });

        //remove all loaded handlers
        tearDown(() async
        {
            
        });
        
        test("New", () async
        {
            
            var home = new Home()
                ..slider = [];
            
            var mongoService = new MongoServiceMock()
                ..when(callsTo('findOne'))
                    .thenReturn(new Future.value(null))
                    .thenReturn(new Future.value(home));
                    
            
            var homeServices = new HomeServices(mongoService);
            
            var resultHome = await homeServices.Get();
            
            mongoService.getLogs(callsTo('insert')).verify(happenedOnce);
            expect(resultHome.slider, []);
            expect(resultHome == home, false);
            
            mongoService.clearLogs();
            
            resultHome = await homeServices.Get();

            mongoService.getLogs(callsTo('insert')).verify(neverHappened);
            expect(resultHome == home, true);
        });
    });
}

