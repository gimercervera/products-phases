pragma solidity ^0.5.12;
import "./Phases.sol";

contract Products is Phases{

    uint private totalProducts;
    address public owner;

    struct Product {
        string productName;
        string productInfo;
        address productOwner;
        uint[] phases;
    }

    mapping(uint => Product) public  productHolder;

    constructor() public {
       owner = msg.sender;
    }

    function createNewProduct(string memory _name, string memory _productInfo) public returns(bool){
        totalProducts++;
        uint[] memory _phases;
        
        productHolder[totalProducts] = Product(_name, _productInfo, owner, _phases);
        return true;
    }
    
    function assignPhase(uint _phaseId, uint _productId) public returns(bool){
        require(isValidPhase(_phaseId));
        productHolder[_productId].phases.push(_phaseId);
        return true;
    }
    
    function getProductName(uint _id) public view returns(string memory){
        return productHolder[_id].productName;
    }
    
    function getProductTotalPhases(uint _id) public view returns(uint){
        return productHolder[_id].phases.length;
    }
    
    
    function getTotalProducts() view public returns(uint){
        return totalProducts;
    }

}