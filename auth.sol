pragma solidity >=0.7.0 <0.9.0;

contract Administration {

  struct User{
      uint256 id;
      string username;
      string email;
  }


  // this will be the super admin of the dapp
  address public super_admin ; 
  // admins of the dapp
  mapping(address => bool) public admins;
  // users
    mapping(address => User) public users;

  modifier is_super_admin(address _address){
      require(super_admin == _address,"Only admin can do that");
      _;
  }

  constructor(){
        // msg.sender is the account that deploy the contract to the main network
        super_admin  = msg.sender;
        admins[msg.sender] = true;
  }

  // functions

  function  add_admin(address new_admin)  public  is_super_admin(msg.sender) {
      // only super admin can add admins
           admins[new_admin] = true;
  }
  
  function is_admin(address _address) view public returns(bool){
      return admins[_address] == true;
  }




}
