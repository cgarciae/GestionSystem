part of aristadart.client;

@Injectable()
class ClientUserServices extends ClientService<User>
{
    ClientUserServices (Requester requester) : super (Col.user, requester);
    
    Future<User> NewOrLogin (User user)
    {
        return json (Method.POST, pathBase, user);
    }
    
    Future<BoolResp> IsAdmin (String id)
    {
        return requester.private (BoolResp, Method.GET, '${href(id)}/isAdmin');
    }
}