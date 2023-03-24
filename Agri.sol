// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.19;

contract Agri {
    
    // Define a struct to hold the farm's details
    struct Farm {
        string name;
        uint area;
        string location;
        uint farmerId; // The ID of the farmer associated with this farm
        uint[] productIds; // An array of IDs for the products associated with this farm
    }

    // Define a struct to hold the farmer's details
    struct Farmer {
        string name;
        uint age;
        string location;
        uint phone;
        uint[] farmIds; // An array of IDs for the farms associated with this farmer
    }

    // Define a struct to hold the product's details
    struct Product {
        string name;
        string description;
        uint price;
        uint quantity;
        uint farmId; // The ID of the farm associated with this product
        uint[] transactionIds; // An array of IDs for the transactions associated with this product
    }

    // Define a struct to hold transaction details
    struct Transaction {
        uint productId;
        uint quantity;
        uint totalPrice;
        address buyer;
    }

    // Define a mapping to store the farmers
    mapping(uint => Farmer) public farmers;

    // Define a mapping to store the farms
    mapping(uint => Farm) public farms;

    // Define a mapping to store the products
    mapping(uint => Product) public products;
    
    // Define a variable to track the number of farmers in the mapping
    uint public farmerCount;

    // Define a variable to track the number of farms in the mapping
    uint public farmCount;

    // Define a variable to track the number of products in the mapping
    uint public productCount;

    // Define a mapping to store transactions
    mapping(uint => Transaction) public transactions;

    // Define a variable to track the number of transactions in the mapping
    uint public transactionCount;
    
    // Define a function to add a new farmer to the mapping
    function addFarmer(string memory _name, uint _age, string memory _location, uint _phone) public {
        farmers[farmerCount] = Farmer(_name, _age, _location, _phone, new uint[](0));
        farmerCount++;
    }
    
    // Define a function to add a farm ID to a farmer's array
    function addFarmToFarmer(uint _farmerId, uint _farmId) public {
        farmers[_farmerId].farmIds.push(_farmId);
    }
    
    // Define a function to get the farm IDs associated with a farmer
    function getFarmIds(uint _farmerId) public view returns (uint[] memory) {
        return farmers[_farmerId].farmIds;
    }
        
    // Define a function to add a new farm to the mapping
    function addFarm(string memory _name, uint _area, string memory _location, uint _farmerId) public {
        farms[farmCount] = Farm(_name, _area, _location, _farmerId, new uint[](0));
        farmCount++;
    }
    
    // Define a function to add a product ID to a farm's array
    function addProductToFarm(uint _farmId, uint _productId) public {
        farms[_farmId].productIds.push(_productId);
    }
    
    // Define a function to get the product IDs associated with a farm
    function getProductIds(uint _farmId) public view returns (uint[] memory) {
        return farms[_farmId].productIds;
    }
    
    // Define a function to add a new product to the mapping
    function addProduct(string memory _name, string memory _description, uint _price, uint _quantity, uint _farmId) public {
        products[productCount] = Product(_name, _description, _price, _quantity, _farmId, new uint[](0));
        productCount++;
    }
    
    // Define a function to add a transaction ID to a product's array
    function addTransactionToProduct(uint _productId, uint _transactionId) public {
        products[_productId].transactionIds.push(_transactionId);
    }
    
    // Define a function to get the transaction IDs associated with a product
    function getTransactionIds(uint _productId) public view returns (uint[] memory) {
        return products[_productId].transactionIds;
    }



    // Define a function to add a new transaction to the mapping
    function sell(uint _productId, uint _quantity, uint _totalPrice) public {
        require(products[_productId].price * _quantity == _totalPrice, "Invalid total price");
        require(_quantity > 0, "Quantity must be greater than zero");

        // Deduct sold quantity from the available product quantity
        products[_productId].quantity -= _quantity;

        // Add transaction to the mapping
        transactions[transactionCount] = Transaction(_productId, _quantity, _totalPrice, msg.sender);
        transactionCount++;
    }

}
