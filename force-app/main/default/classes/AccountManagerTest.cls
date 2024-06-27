@isTest
global class AccountManagerTest {
    @isTest static void testGetAccountById() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri ='https://cunning-bear-rteze7-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Accounts/'+ recordId +'/contacts';
           
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        Assert.isTrue(thisAccount != null);
        //Assert.areEqual('AcmeTest Corporation', thisAccount.Name);
    }
    // Helper method
    static Id createTestRecord() {
                 // Create test record
        Account acct = new Account(Name = 'AcmeTest Corporation');
        // Insert the accounts
        insert acct;
                 
        
        // Create contacts for each account
        Contact c1= new Contact(FirstName = 'Test', LastName = 'Doe', AccountId = acct.Id);
        insert c1;
         Contact c2 = new Contact(FirstName = 'Jane', LastName = 'Test', AccountId = acct.Id);
            insert c2;
        return acct.Id;
        }
                
        
    }