import { LightningElement, wire, track } from 'lwc';
import getArticlesOwnedByUser from '@salesforce/apex/KnowledgeArticleController.getArticlesOwnedByUser';

const columns = [
   // { label: 'Article Id', fieldName: 'Id' },
    { label: 'Title', fieldName: 'Title' },
    { label: 'Next Review Date', fieldName: 'NextReviewDate', type: 'date'},
    {label: 'URL',fieldName: 'UrlName',type:'url'}
];

export default class KnowledgeArticles extends LightningElement {
    @track columns = columns;
    
    @wire(getArticlesOwnedByUser)
    articles;
}
