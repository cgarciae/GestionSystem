part of aristadart.client;

@Component
(
    selector : "view-test",
    templateUrl: 'components/views/sitio/sitio.html'
)
class InnerViewTest
{
  String subsitio;
  String templateUrl;
  
  InnerViewTest (RouteProvider route)
  {
    subsitio = route.parameters["subsitio"];
    templateUrl = "view/sitio/${subsitio}.html";
    
    print ("INIT");
  }
  
  click ()
  {
    print ("Hola");
  }
}