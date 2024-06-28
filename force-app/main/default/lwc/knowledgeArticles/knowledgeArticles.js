import { LightningElement, wire, track } from 'lwc';
import getArticlesOwnedByUser from '@salesforce/apex/KnowledgeArticleController.getArticlesOwnedByUser';

const columns = [
    { label: 'Article Id', fieldName: 'Id' },
    { label: 'Title', fieldName: 'Title' },
    { label: 'Next Review Date', fieldName: 'NextReviewDate', type: 'date' },
    {
        label: 'URL',
        fieldName: 'articleUrl',
        type: 'url',
        typeAttributes: {
            label: {
                fieldName: 'UrlName'
            },
            target: '_blank'
        }
    }
];

export default class KnowledgeArticles extends LightningElement {
    @track columns = columns;
    
    @wire(getArticlesOwnedByUser)
    articles;

    get articlesData() {
        return this.articles.data ? this.articles.data.map(article => {
            return {
                ...article,
                articleUrl: `/lightning/r/Knowledge__kav/${article.Id}/view`
            };
        }) : [];
    }
}
