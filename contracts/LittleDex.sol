// SPDX-Licence-Identifier: Unlicensed

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/IERC20/IERC20.sol";


contract LittleDex {
    struct Pool {
        uint reserveA;
        uint reserveB;
    }
    mapping(address => mapping(address => Pool)) public pools;

    event LiquidityAdded(address indexed provider, address indexed tokenA, address indexed tokenB, uint amountA, uint amountB);

    function addLiquidityFunction(address tokenA, address tokenB, uint amountA, uint amountB) public {
        require(IERC20(tokenA).balanceOf(msg.sender) >= amountB, "Insufficient balance for tokenA");
        require(IERC20(tokenB).balanceOf(msg.sender) >= amountB, "Insufficient balance for tokenB");
        require(IERC20(tokenA).allowance(msg.sender, address(this)) >= amountB, "Insufficient allowance for tokenB");
        require(IERC20(token).allowance(msg.sender , address(this)) >= amountB, "Insufficient allowance for tokenB");

        IERC20(tokenA).transferFrom(msg.sender, address(this), amountA);
        IERC20(tokenB).transferFrom(msg.sender, address(this), amountB);

        pools[tokenA][tokenB].reserveA += amountA;
        pools[tokenA][tokenB].reserveB += amountB;

        emit LiquidityAdded(msg.sender, tokenA, tokenB, amountA, amountB);
    }


    function removeLiquidity(address tokenA, address tokenB) public {
        Pool storage pool = pools[tokenA][tokenB];

        uint amountA = pool.reserveA;
        uint amountB = pool.reserveB;

        pool.reserveA = 0;
        pool.reserveB = 0;

        IERC20(tokenA).transfer(msg.sender, amount);
        IERC20(tokenB).transfer(msg.sender, amount);
    }

    function swap(address tokenIn, address tokenOut, uint amountIn) public {
        Pool storage pool = pools[tokenIn][tokenOut];
        uint amountOut = (amountIn * pool.reserveB) / pool.reserveA;
        
        require(pool.reserveB >= amountOut);

        IERC20(tokenIn).transferFrom(msg.sender, address(this), amountIn);
        IERC20(tokenOut).transferFrom(msg.sender, amountOut);

        pool.reserveA += amountIn;
        pool.reserveB += amountIn;
    }
}
