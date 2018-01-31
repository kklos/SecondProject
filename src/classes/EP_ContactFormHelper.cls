/**
 * Created by klaud on 26.01.2018.
 */

public class EP_ContactFormHelper {

    @future(callout=true)
    public static void callFun(String JsonBody) {
        System.debug(JsonBody);
        String LOGIN = MM_RestRemoteSettings__c.getInstance('AdminConnectionSettings').login__c;
        String PASSWORD = MM_RestRemoteSettings__c.getInstance('AdminConnectionSettings').password__c;
        String SESSIONID = '';
        String SERVER_URL = '';

        try {
            HttpRequest request = new HttpRequest();
            request.setEndpoint(MM_RestRemoteSettings__c.getInstance('AdminConnectionSettings').loginEndPoint__c);
            request.setMethod('POST');
            request.setHeader('Content-Type', 'text/xml;charset=UTF-8');
            request.setHeader('SOAPAction', '""');
            request.setBody('<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/"><Header/><Body><login xmlns="urn:partner.soap.sforce.com"><username>'
                    + LOGIN + '</username><password>' + PASSWORD + '</password></login></Body></Envelope>');

            HttpResponse res = new Http().send(request);
            System.debug(res.getBody());
            if (res.getStatusCode() == 200) {
                System.debug('http 200 OK');
                Dom.XmlNode resultElmt = res.getBodyDocument().getRootElement()
                        .getChildElement('Body', 'http://schemas.xmlsoap.org/soap/envelope/')
                        .getChildElement('loginResponse', 'urn:partner.soap.sforce.com')
                        .getChildElement('result', 'urn:partner.soap.sforce.com');
                SESSIONID = resultElmt.getChildElement('sessionId', 'urn:partner.soap.sforce.com').getText();
                System.debug(SESSIONID);
                SERVER_URL = resultElmt.getChildElement('serverUrl', 'urn:partner.soap.sforce.com') .getText().split('/services')[0];
                System.debug(SERVER_URL);
            }

            HttpRequest req = new HttpRequest();
            req.setMethod('POST');
            req.setHeader('Authorization', 'Bearer ' + SESSIONID);
            system.debug(req.getHeader('Authorization'));
            req.setHeader('Content-Type', 'application/json; charset=UTF-8');
            req.setBody(JsonBody);
            req.setEndpoint(SERVER_URL + MM_RestRemoteSettings__c.getInstance('AdminConnectionSettings').restEndPoint__c);
            new Http().send(req);
        } catch (Exception exp) {
            System.debug(exp.getMessage());
        }
    }

    @InvocableMethod
    public static void postToChatter(List<Id> leads) {
        Lead lead = [SELECT Id, FirstName, LastName FROM Lead WHERE Id = :leads][0];
        String JSON = '{"ParentId" : "0F90O0000009ZZDSA2","Type" : "LinkPost",'
                +'"Body" : "New Lead was created: '+ lead.FirstName +' '+ lead.LastName+'",'
                +' "LinkURL" : "https://mechanics-dev-ed.lightning.force.com/'+ lead.Id+'", "Title": "New Lead" }';
        System.debug(JSON);

        callFun(JSON);
    }
}

