//To execute: exec ./script.js
//npm install @truffle/contract

const artifacts = require('./build/contracts/Products.json');
var contract = require("@truffle/contract");
const Contract = contract(artifacts);

Contract.setProvider(web3.currentProvider);

module.exports = function(callback){

var deployed;
var sender;

//function createNewProduct(string memory _name, string memory _productInfo) public returns(bool){

Contract.deployed().then(function(instance) {
    deployed = instance;
    return deployed.owner.call();
  })
  .then(function(_sender){
    sender = _sender;
    return deployed.createNewProduct("Vino", "Blanco", {from:sender});
  })
  .then(function(result) {
    // Do something with the result or continue with more transactions.
	  //console.log(result);
	  return deployed.getTotalProducts.call();
  })
  .then(total => {
    console.log("Total Products: " + total);
  })
  .then(() => {
    return deployed.createNewPhase("origen", "Madrid", {from:sender});
  })
  .then(() => {
    return deployed.createNewPhase("destino", "Barcelona", {from:sender});
  })
  .then(result => {
    console.log("New Phase Id: " + result.logs[0].args._id.toNumber());
    return deployed.assignPhase(result.logs[0].args._id.toNumber(), 1, {from:sender});
  })
  .then(result => {
    //console.log("New Phase Id: " + result.logs[0].args._id.toNumber());
    return deployed.assignPhase(1, 1, {from:sender});
  })
  .then(()=>{
    return deployed.getProductTotalPhases(1);
  })
  .then(productPhases => {
    console.log("Product phases:" + productPhases)
  })
  .catch(function(err) {
	  // Easily catch all errors along the whole execution.
	  console.log("ERROR! " + err.message);
  });

}