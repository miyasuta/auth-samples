using { cuid, managed } from '@sap/cds/common';
using { ProductsService } from '../srv/external/ProductsService.csn';
namespace salesorders;

entity SalesOrders {
    key ID: UUID @title: '{i18n>id}' @Core.Computed;
    orderNumber: Integer @title: '{i18n>orderNumber}';
    description: String @title : '{i18n>description}';
    company: String @title : '{i18n>company}';
    items: Composition of many SalesOrderItems on items.order = $self;
}

entity SalesOrderItems: cuid {
    key ID: UUID @title: '{i18n>id}' @Core.Computed;
    itemNo: Integer @title: '{i18n>itemNo}';
    order: Association to SalesOrders @title: '{i18n>order}';
    product: Association to ProductsService.Products @title: '{i18n>product}';
}

// annotate ProductsService.Products with @cds.odata.valuelist;