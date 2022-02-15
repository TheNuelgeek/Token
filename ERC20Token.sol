// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/IERC20Metadata.sol"; // this imported link contains ERC20Token and IRC20Token

contract ERC20Token is IERC20Metadata {
    // creating ERC20Token using the Token Standard
    // Token = T, TDECIMAL, TNAME, TSYMBOL
 
    // VARIABLES
    string private _tokenName;
    string private _tokenSymbol;
    uint8 private _tokenDecimal;
    uint256 private _totalSupply;

    mapping (address => uint256) balances;
    mapping(address => mapping(address => uint256)) _allowance;

    // FUNCTIONS

    constructor(
        string memory tokenName_,
        string memory tokenSymbol_,
        uint8 tokenDecimal_,
        uint256 totalSupply_
    )
    {
        _tokenName = tokenName_;
        _tokenSymbol = tokenSymbol_;
        _tokenDecimal = tokenDecimal_;
        _totalSupply = totalSupply_;
        balances[msg.sender] = _totalSupply;
    }

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function name() external override view returns (string memory){
        return _tokenName;
    }

    function symbol() external override view returns (string memory){
        return _tokenSymbol;
    }

    function decimals() external override view returns (uint8){
        return _tokenDecimal;
    }

    function totalSupply() external override view returns (uint256){
        return totalSupply;
    }

    // Account Balance

    function balanceOf(address account) external override view returns (uint256){
        return balances[account]; 
    }

    // Transfer
    function _transfer(address _from, address _to, uint256 _amount) internal returns(bool){
        require(_amount <= balances[_from], " Insufficient Balance");
        balance[_from] -= amount;
        balance[_to] += amount;
        return true;

        emit Transfer(_from, _to, _amount);
    }

    function transfer(address to, uint256 amount) external override returns (bool){
        _transfer(msg.sender, to, amount);

        emit Transfer(msg.sender, to, amount);
    }

    // Allowance
    function allowance(address owner, address spender) external view returns (uint256){
        return _allowance[owner][spender];
    }

    // Transfer from

    // Approve
    function approve(address spender, uint256 amount) external returns (bool){
        _allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender,spender, amount);
    }

     function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool)
    {
       uint _allowedAmount = allowance(from, msg.sender);
       require(amount <= _allowedAmount, "You do not have suffcient amount approved");
       _allowance[from][msg.sender] -= amount;
       _transfer(from, to, amount);
       emit Transfer(msg.sender, to, amount);
       
    }
}