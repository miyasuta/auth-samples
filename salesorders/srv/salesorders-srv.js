module.exports = async function () {
    this.before('READ', 'SalesOrdersNoAuth', (context) => {
        console.log('authInfo: ', context.req.authInfo);
        if (context.req.authInfo) {
            const jwt =  context.req.authInfo.getTokenInfo().getTokenValue();
            console.log('JWT: ', jwt);
        }
    })

    // this.on('READ', 'SalesOrderItems', (req, next) => {
    //     console.log('Item Read Handler');
    //     return next();
    // })

    const service = await cds.connect.to('ProductsService');
    this.on('READ', 'Products', (req) => {
        return service.tx(req).run(req.query);
    })
}