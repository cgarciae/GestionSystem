part of aristadart.client;

@Component
(
    selector : "sitio",
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
  }
  
  click ()
  {
    print ("Hola");
  }
}