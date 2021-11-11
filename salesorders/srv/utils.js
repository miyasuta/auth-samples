function getNewWhere(currentWhere, conditions) {
    //condition is empty
    if (Object.keys(conditions).length === 0) {
        return currentWhere;
    }

    const newWhere = _getWhere(conditions);
    if (!currentWhere) {
        return newWhere;
    } else {
        return [...currentWhere, 'and', ...newWhere];
    }
}

function getAttribute(configs, attributes) {
    /*  <sample input>
        configs : [{
            sourceProperty: "Company",
            targetProperty: "company",
            dummyValue: "zzzz" //if a user does not have the attribute, set such value that no record will be fetched
        },{
            sourceProperty: "Company",
            targetProperty: "region",
            dummyValue: "z" //if a user does not have the attribute, set such value that no record will be fetched
        }]

        attributes : {"Company": ["1000", "2000"], "Region": ["Asia"]}        

        <sample output>
        case 1: user has all attributes
        {
            "company": ["2000", "2000"],
            "region": ["Asia"]
        }
        case 2: user has partial attributes       
        {
            "company": ["2000", "2000"],
            "region": ["z"]
        }        
    */
 
    let outputAttributes = {};
    configs.forEach((config) => {        
        let sourceProp = config.sourceProperty;
        let targetProp = config.targetProperty;
        let userAttribute = attributes[sourceProp];

        //user has attribute
        if (userAttribute) {
            //don't add filter condition when the user has wildcard authorization
            let attributeVal = Array.isArray(userAttribute) ? userAttribute : [userAttribute];
            if (attributeVal[0] !== '*') {
                outputAttributes[targetProp] = attributeVal;
            }                                 
        }
        //user does not have attribute 
        else {
            outputAttributes[targetProp] = config.dummyValue;
        }
    })
    return outputAttributes;

}

function _getWhere(conditions) {
    let aWhere = [];
    Object.keys(conditions).forEach((key, index) => {
        if (index > 0) {
            aWhere.push('and');
        }
        let currentProperty = conditions[key];
        //multiple conditions
        if (currentProperty.length > 1) {
            aWhere.push('(');
            currentProperty.forEach((currentValue, index) => {
                if (index > 0) {
                    aWhere.push('or');
                }
                aWhere.push({ ref: [key] }, '=', { val: currentValue });
            })
            aWhere.push(')');
            //single condition
        } else {
            aWhere.push({ ref: [key] }, '=', { val: currentProperty[0] });
        }
    })
    return aWhere
}

module.exports = {
    getNewWhere: getNewWhere,
    getAttribute: getAttribute
}