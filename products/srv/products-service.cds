using {products as db} from '../db/data-model';

@requires: ['authenticated-user','system-user']
service ProductsService {   
    entity Products as projection on db.Products;
}