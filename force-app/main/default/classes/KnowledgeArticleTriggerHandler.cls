public class KnowledgeArticleTriggerHandler {
    public static void onAfterUpdate(List<Knowledge__kav> newArticles, Map<Id, Knowledge__kav> oldMap) {
        List<Knowledge__kav> articlesToUpdate = new List<Knowledge__kav>();

        for (Knowledge__kav newArticle : newArticles) {
            Knowledge__kav oldArticle = oldMap.get(newArticle.Id);

            if (oldArticle.PublishStatus != 'Online' && newArticle.PublishStatus == 'Online' && newArticle.IsLatestVersion) {
                newArticle.NextReviewDate = Date.today().addDays(30); // Set NextReviewDate to 30 days from today
                articlesToUpdate.add(newArticle);
                System.debug('Article with Id ' + newArticle.Id + ' is set for NextReviewDate: ' + newArticle.NextReviewDate);
            }
        }

        if (!articlesToUpdate.isEmpty()) {
            System.debug('Updating articles with new NextReviewDate.');
            update articlesToUpdate;
        }
    }
}