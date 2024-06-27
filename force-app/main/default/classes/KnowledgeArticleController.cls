public with sharing class KnowledgeArticleController {
    @AuraEnabled(cacheable=true)
    public static List<Knowledge__kav> getArticlesOwnedByUser() {
        // Fetch the knowledge articles owned by the current user
        return [SELECT Id, Title,UrlName,NextReviewDate 
                FROM Knowledge__kav 
                WHERE CreatedById = :UserInfo.getUserId()
                ORDER BY CreatedDate DESC];
    }
}