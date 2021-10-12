# auth-samples
UI + 2 CAP projects with authentication handling

All 3 components (salesorderui, salesorders, products) are bound to different XSUAA instances.
The UI component (salesorderui) is meant to be executed from Fiori Launchpad on BTP.
The UI calls salesorders, then salesorders calls products service.
BTP destination with be created for the two cap services.

## Authentication flow
- UI -> salesorders: 
    - Authentication is done by destination, with **OAuthUserTokenExchange**. Here, authentication is done as a business user.
- salesorders -> products: 
    - Authentication is done by destination, with **OAuthClientCredentails**. Here, authentication is done as a system user.

##How to start
1. Clone this repository.
2. Execute `npm i` on each component.
3. Start products with `cds watch`.
4. Start salesorders with 'cds watch --port 4005`.
5. Start salesordersui with `npm start`.
