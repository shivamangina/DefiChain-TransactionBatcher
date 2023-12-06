// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract MulticallExecuter {
    event MulticallExecuted(address[] targets);
      event Received(address, uint);
    error CallFailed(address _target, bytes _data);

    // multi call executer
    function multiCall(address[] calldata targets, uint256[] calldata val)
        external
        payable
        returns (bytes[] memory)
    {

        emit Received(msg.sender, msg.value);
        require(targets.length != 0, "target length is 0");
        // require(targets.length == data.length, "target length != data length");

        bytes[] memory results = new bytes[](targets.length);

        for (uint256 i; i < targets.length; i++) {
            (bool success, bytes memory result) = targets[i].call{
                value: val[i]
            }("");

            if (!success) {
                if (result.length == 0) {
                    revert CallFailed(targets[i], "");
                }
                assembly {
                    revert(add(result, 32), mload(result))
                }
            }
            results[i] = result;
        }

        emit MulticallExecuted(targets);

        return results;
    }

  
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }
}
