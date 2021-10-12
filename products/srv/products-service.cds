using {products as db} from '../db/data-model';

@requires: ['authenticated-user','system-user']
service ProductsService {
    //  @(restrict: [
    //         { grant: 'READ', to: ['Admin', 'system-user'] }
    //     ])    
    entity Products as projection on db.Products;
}