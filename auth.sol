pragma solidity >=0.7.0 <0.9.0;

contract Administration {

  struct User{
      bool is_in;
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
      require(super_admin == _address,"Only super admin can do that");
      _;
  }

   modifier is_admin(address _address){
      require(admins[_address] == true,"Only admin can do that");
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
           require(admins[new_admin] == false,"Admin already exist");
           admins[new_admin] = true;
           require(users[new_admin].is_in == false  ,"user already exist");
           users[new_admin] = User(true,"","") ;
  }
  
  function add_user(address new_user)  public  is_admin(msg.sender) {
      // only super admin can add admins
           require(users[new_user].is_in == false  ,"user already exist");
           users[new_user] = User(true,"","") ;
  }

  function set_user(address _user,string memory _username ,string memory _email ) public is_admin(msg.sender){
          require(users[_user].is_in == true,"User is not in");
          users[_user].username = _username;
          users[_user].email = _email;
  }

  /*function is_admin(address _address) view public returns(bool){
      return admins[_address] == true;
  }*/




}
