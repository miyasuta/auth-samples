using { salesorders as db } from '../db/data-model';
using { ProductsService } from './external/ProductsService.csn';

@requires: ['authenticated-user', 'system-user']
service SalesOrderService {
    @odata.draft.enabled
    entity SalesOrders 
     @(restrict: [
            { grant: 'READ', to: 'Viewer', where: 'company = $user.company' },
            { grant: ['READ', 'WRITE'], to: 'Sales', where: 'company = $user.company' },
            { grant: 'READ', to: 'Admin' }
        ])
    as projection on db.SalesOrders;

     @(restrict: [
            { grant: 'READ', to: 'Viewer', where: 'company = $user.company' },
            { grant: ['READ', 'WRITE'], to: 'Sales', where: 'company = $user.company' },
            { grant: 'READ', to: 'Admin' }
        ])
    entity SalesOrderItems as select from db.SalesOrderItems {*,
        order.company as company};

    entity Products as projection on ProductsService.Products;
}

annotate SalesOrderService.SalesOrders with @(
    UI: {
        SelectionFields: [
            description,
            company
        ],
        LineItem  : [
            { Value: orderNumber },
            { Value : description },
            { Value: company }
        ],
        PresentationVariant  : {
            $Type : 'UI.PresentationVariantType',
            SortOrder : [
                {
                    $Type : 'Common.SortOrderType',
                    Property : orderNumber,                    
                },
            ],
            Visualizations: ['@UI.LineItem']
        },
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'Sales Order',
            TypeNamePlural : 'Sales Orders',
            Title : {
                $Type : 'UI.DataField',
                Value : orderNumber,
            },
            Description : {
                $Type : 'UI.DataField',
                Value : description,
            },
        },
        Facets  : [
            {
                $Type : 'UI.ReferenceFacet',
                Target : '@UI.FieldGroup#GeneralInfo',
                Label : '{i18n>generalInfo}',
            },{
                $Type : 'UI.ReferenceFacet',
                Target : 'items/@UI.LineItem',
                Label : '{i18n>items}',
            },
        ],
        FieldGroup #GeneralInfo: {
            $Type : 'UI.FieldGroupType',
            Data : [
                {
                    $Type : 'UI.DataField',
                    Value : orderNumber,
                },
                {
                    $Type : 'UI.DataField',
                    Value : description,
                },
                {
                    $Type : 'UI.DataField',
                    Value : company,
                }                                
            ],
            
        },
    }
        
);

annotate SalesOrderService.SalesOrderItems with @(
    UI: {
        LineItem  : [
            { Value: itemNo },
            { Value: product_ID },
        ],
    }
){
    product @(
        Common.ValueList: {
            CollectionPath: 'Products',
            Parameters: [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : 'product_ID',
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name'
                }            
            ]
        }        
    )
};

annotate SalesOrderService.Products with @(){
    ID @(title: '{i18n>id}');
    name @(title: '{i18n>name}');
}