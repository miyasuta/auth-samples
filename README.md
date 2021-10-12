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
