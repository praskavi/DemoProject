@isTest
private class KnowledgeArticleTriggerTest {
     @isTest
    static void testKnowledgeArticleUpdateAndPublish() {
        // Create a new Knowledge Article Version
        Knowledge__kav newArticle = new Knowledge__kav(
            Title = 'Test Article',
            UrlName = 'test-article',
            Language = 'en_US',
            Summary = 'Test summary'
            
        );

        Test.startTest();
        insert newArticle;
        System.debug('Inserted Article ID: ' + newArticle.Id);

        // Retrieve the inserted article to get its KnowledgeArticleId
        newArticle = [SELECT Id, KnowledgeArticleId, PublishStatus FROM Knowledge__kav WHERE Id = :newArticle.Id];
        System.debug('Retrieved Article: ' + newArticle);

        // Publish the article
        KbManagement.PublishingService.publishArticle(newArticle.KnowledgeArticleId, true);

        // Retrieve the published article
        Knowledge__kav publishedArticle = [SELECT Id, PublishStatus, IsLatestVersion, LastPublishedDate, NextReviewDate 
                                            FROM Knowledge__kav 
                                            WHERE Id = :newArticle.Id 
                                            AND IsLatestVersion = true];
        System.debug('Published Article: ' + publishedArticle);

        // Assert the initial publication status and next review date
        System.assertEquals('Online', publishedArticle.PublishStatus, 'Failed to publish article');
        System.assertNotEquals(null, publishedArticle.LastPublishedDate, 'LastPublishedDate should not be null');
        //System.assertEquals(publishedArticle.LastPublishedDate.addDays(30), publishedArticle.NextReviewDate, 'Initial NextReviewDate is incorrect');

        // Create a draft article from the published article
        String draftArticleId = KbManagement.PublishingService.editOnlineArticle(newArticle.KnowledgeArticleId, true);
        System.debug('Draft Article ID: ' + draftArticleId);

        // Retrieve the draft article
        Knowledge__kav draftArticle = [SELECT Id, KnowledgeArticleId, PublishStatus, LastPublishedDate, NextReviewDate 
                                       FROM Knowledge__kav WHERE Id = :draftArticleId];
        System.debug('Draft Article: ' + draftArticle);

        // Update the NextReviewDate of the draft article
        draftArticle.NextReviewDate = draftArticle.LastPublishedDate.addDays(30);
        update draftArticle;
        System.debug('Updated Draft Article NextReviewDate: ' + draftArticle.NextReviewDate);

        // Republish the updated article
      //  KbManagement.PublishingService.publishArticle(draftArticle.KnowledgeArticleId, true);

        // Retrieve the published updated article
        Knowledge__kav updatedArticle = [SELECT Id, PublishStatus, IsLatestVersion, LastPublishedDate, NextReviewDate 
                                          FROM Knowledge__kav 
                                          WHERE Id = :draftArticle.Id 
                                          AND IsLatestVersion = true];
        System.debug('Updated Article: ' + updatedArticle);

        Test.stopTest();

        // Assert the updated publication status and next review date
        //System.assertEquals('Online', updatedArticle.PublishStatus, 'Failed to publish updated article');
        System.assertNotEquals(null, updatedArticle.LastPublishedDate, 'LastPublishedDate should not be null after update');
        System.assertEquals(updatedArticle.LastPublishedDate.addDays(30), updatedArticle.NextReviewDate, 'Updated NextReviewDate is incorrect');
    }
}