/**
 * Created by klaud on 25.01.2018.
 */

public with sharing class EP_ContactFormController {

    public class ContactViewModel {
        public String FirstName { get; set; }
        public String LastName { get; set; }
        public String Email { get; set; }
        public String BusinessPhone { get; set; }
        public String Company { get; set; }
        public String Subject { get; set; }
        public String Description { get; set; }

        public ContactViewModel() {
            FirstName = '';
            LastName = '';
            Email = '';
            BusinessPhone = '';
            Company = '';
            Subject = '';
            Description = '';
        }
    }

    public ContactViewModel contactFormInformation { get; set; }


    public String thanks { get; set; }

    public EP_ContactFormController() {
        this.contactFormInformation = new ContactViewModel();
        this.thanks = '';
    }


    public PageReference submit() {

        Lead newLead = new Lead(FirstName = contactFormInformation.FirstName,
                LastName = contactFormInformation.LastName,
                Email = contactFormInformation.Email,
                Phone = contactFormInformation.BusinessPhone,
                Company = contactFormInformation.Company,
                LeadSource = 'Web',
                Status = 'New');
        insert newLead;

        Case newCase = new Case(Status = 'New',
                Priority = 'Medium',
                Origin = 'Web',
                CurrencyIsoCode = 'EUR',
                Lead__c = newLead.Id,
                Subject = contactFormInformation.Subject,
                Description = contactFormInformation.Description);
        insert newCase;

        this.thanks = 'Thank you for the message! We will answer your questions as soon as possible.';

        return null;
    }


}