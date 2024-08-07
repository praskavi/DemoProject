@isTest
public class LeadProcessorTest {
@isTest
   public static void testBatchClass(){
        List<Lead> leads = new List<Lead>();
       
     // insert 10 leads
        for (Integer i=0;i<10;i++) {
            leads.add(new Lead(FirstName='Lead',LastName='TestContact'+i,Company='TestCo +i'));
        }
        insert leads;

    
        Test.startTest();
        LeadProcessor uca = new LeadProcessor();
        Id batchId = Database.executeBatch(uca);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertEquals(10, [select count() from Lead where LeadSource='Dreamforce']);
    
}
}