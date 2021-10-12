using { cuid, managed } from '@sap/cds/common';
namespace products;

entity Products {
    key ID: Integer @title: '{i18n>productCode}';
    name: String @title: '{i18n>name}'
}
