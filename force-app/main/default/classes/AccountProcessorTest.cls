@isTest
public class AccountProcessorTest {
@isTest
   public static void countContactsTest(){
      /*  // Load Test Data
        // Declare empty Account list
        List<Account> accounts = new List<Account>();
        // Populate Test account names
        for (Integer i=0;i<10;i+1){
            accounts.add(new account(Name ='Test Account' + i));
                        
        }
        insert accounts;
        // Declare empty Contact List
        List<Contact> contacts = new List<Contact>();
        // Declare empty List of AccountIds to be passed to AccountProcessor
        List<Id> AccountIds= new List<Id>();
        // Add contact for every account
        for (Account acc: accounts){
            contacts.add(new Contact(FirstName=acc.Name,LastName='TestContact',AccountId=acc.Id));
            accountIds.add(acc.Id);            
        }
*/
        // List to hold the accounts
        List<Account> accounts = new List<Account>();
// Create some example accounts
        accounts.add(new Account(Name = 'Test Corporation', Phone = '123-456-7890', Industry = 'Manufacturing'));
        accounts.add(new Account(Name = 'Test1 Enterprises', Phone = '987-654-3210', Industry = 'Technology'));
        accounts.add(new Account(Name = 'NextGen Test', Phone = '555-555-5555', Industry = 'Healthcare'));
       insert accounts;
       
       // Declare empty Contact List
        List<Contact> contacts = new List<Contact>();
        // Declare empty List of AccountIds to be passed to AccountProcessor
        List<Id> AccountIds= new List<Id>();
        // Add contact for every account
        for (Account acc: accounts){
            contacts.add(new Contact(FirstName=acc.Name,LastName='TestContact',AccountId=acc.Id));
            AccountIds.add(acc.Id);   
       
        }
       insert contacts;
        // Do the test
        Test.startTest();
        
        AccountProcessor.countContacts(AccountIds);
        
        Test.stopTest();
        // Check result
        List<Account> Accs=[Select Id,Number_of_Contacts__c from Account];
        for(Account acc:accs){
            system.assertEquals(1,acc.Number_Of_Contacts__c,'Error:At least 1 Account record missing');
        }
        
        
    }
}