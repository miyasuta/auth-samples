module.exports = async function () {
    this.before('READ', 'Products', (req)=> {
        console.log(req.headers);
    })
}