public without sharing class LeadProcessor implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext dbc){
        return Database.getQueryLocator([Select Id,Name from Lead]);
        
    }
    
    public void execute(Database.BatchableContext dbc, List<Lead> scope){
        List<Lead> updLeads = new List<Lead>();
        for (Lead eachLead: scope){
            eachLead.LeadSource ='Dreamforce';
            // add updated lead to list
            updLeads.add(eachLead);
        }
        update updLeads;
    }
     public void finish(Database.BatchableContext bc){
        System.debug(' records processed. Shazam!');
	}
}