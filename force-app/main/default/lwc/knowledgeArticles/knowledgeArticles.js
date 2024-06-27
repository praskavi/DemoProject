import { LightningElement, wire } from 'lwc';
import getArticlesOwnedByUser from '@salesforce/apex/KnowledgeArticleController.getArticlesOwnedByUser';

export default class KnowledgeArticles extends LightningElement {
    @wire(getArticlesOwnedByUser)
    articles;
}
