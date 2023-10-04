public class MockHttpViaCEPResponseGenerator implements HttpCalloutMock {
  public HTTPResponse respond(HTTPRequest req) {
    HttpResponse res = new HttpResponse();
    res.setHeader('Content-Type', 'application/json');

    if (req.getEndpoint().contains('01001000')) {
      res.setBody('{"cep": "01001-000","logradouro": "Praça da Sé","complemento": "lado ímpar","bairro": "Sé","localidade": "São Paulo","uf": "SP","ibge": "3550308","gia": "1004","ddd": "11","siafi": "7107"}');
      res.setStatusCode(200);
    }
    else if (req.getEndpoint().contains('00000000')) {
      res.setBody('{"erro":true}');
      res.setStatusCode(404);
    }
    else {
      res.setBody('{"erro":true}');
      res.setStatusCode(500);
    }

    return res;
  }
}
