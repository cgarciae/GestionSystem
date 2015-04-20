part of aristadart.client.tests;

class RequesterMock extends Mock implements Requester
{
    RequesterMock ();
    RequesterMock.spy (Requester real) : super.spy (real);
}