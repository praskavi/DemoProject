public class KnowledgeArticleUpdater {

    public static void updateNextReviewDateForOnlineArticles() {
        final String PUBLISH_STATUS_ONLINE = 'Online'; 
        
        // Log the start of the method execution
        System.debug('Starting updateNextReviewDateForOnlineArticles method.');
        
        // Query articles with PublishStatus as 'Online'
        final String q = 'SELECT Id, PublishStatus, LastPublishedDate FROM Knowledge__kav WHERE PublishStatus = :PUBLISH_STATUS_ONLINE';
        System.debug('Query: ' + q);
        
        List<Knowledge__kav> articles = Database.query(q);
        System.debug('Number of articles retrieved: ' + articles.size());
        
        List<Knowledge__kav> articlesToUpdate = new List<Knowledge__kav>();
        
        for (Knowledge__kav article : articles) {
            System.debug('Processing article with Id: ' + article.Id + ', LastPublishedDate: ' + article.LastPublishedDate);
            
            // Ensure LastPublishedDate is not null before updating NextReviewDate
            if (article.LastPublishedDate != null) {
                article.NextReviewDate = article.LastPublishedDate.addDays(120);
                System.debug('Updated NextReviewDate to: ' + article.NextReviewDate);
                articlesToUpdate.add(article);
            } else {
                System.debug('Skipping article with Id: ' + article.Id + ' because LastPublishedDate is null.');
            }
        }
        
        // Update the articles in the database
        if (!articlesToUpdate.isEmpty()) {
            System.debug('Updating ' + articlesToUpdate.size() + ' articles.');
            update articlesToUpdate;
        } else {
            System.debug('No articles to update.');
        }
        
        // Log the end of the method execution
        System.debug('Finished updateNextReviewDateForOnlineArticles method.');
    }
}