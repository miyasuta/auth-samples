using { cuid, managed } from '@sap/cds/common';
namespace products;

entity Products {
    key ID: Integer @title: '{i18n>productCode}';
    name: String @title: '{i18n>name}';
    company: String @title: '{i18n>company}';
    region: String @title: '{i18n>region}'
}
