trigger KnowledgeArticleTrigger on Knowledge__kav (after update) {
    System.debug('KnowledgeArticleTrigger invoked');
    if (Trigger.isAfter && Trigger.isUpdate) {
        Map<Id, Knowledge__kav> oldMap = Trigger.oldMap;
        Map<Id, Knowledge__kav> newMap = Trigger.newMap;

        for (Id articleId : Trigger.newMap.keySet()) {
            Knowledge__kav oldVersion = oldMap.get(articleId);
            Knowledge__kav newVersion = newMap.get(articleId);
            
            // Debug statements to log old and new values
            System.debug('Old Version: ' + oldVersion);
            System.debug('New Version: ' + newVersion);
            
            // Check if PublishStatus is 'Online' and old and new LastPublishedDate are different
            if (newVersion.PublishStatus == 'Online' && oldVersion.LastPublishedDate != newVersion.LastPublishedDate) {
                // Update NextReviewDate to be 30 days after LastPublishedDate
                newVersion.NextReviewDate = newVersion.LastPublishedDate.addDays(30);
                
                System.debug('NextReviewDate set to: ' + newVersion.NextReviewDate);
             // Republish the updated article
       // KbManagement.PublishingService.publishArticle(newVersion.KnowledgeArticleId, true);
            }
        }
    }
}