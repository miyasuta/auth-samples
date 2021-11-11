const { getNewWhere, getAttribute } = require('./utils')

module.exports = async function () {
    const service = await cds.connect.to('ProductsService');
    this.on('READ', 'Products', (req) => {
        //1. get user attributes
        const attr = req.user.attr;

        //2. map user attributes to external service priperties
        const configs = [{
            sourceProperty: "Company",
            targetProperty: "company",
            dummyValue: "zzzz" //set such value that no record will be fetched
        },{
            sourceProperty: "Region",
            targetProperty: "region",
            dummyValue: "z" //set such value that no record will be fetched
        }]
        const conditions = getAttribute(configs, attr);

        //3. set new where condition based on the user attributes
        const newWhere = getNewWhere(req.query.SELECT.where, conditions);
        req.query.SELECT.where = newWhere;

        //4. pass query and custom header (if necessary) to the external service
        return service.send({query: req.query, headers: {custom: 'abc'}});
    })
}