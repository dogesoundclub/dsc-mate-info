pragma solidity ^0.5.6;
pragma experimental ABIEncoderV2;

import "./klaytn-contracts/token/KIP17/IKIP17Enumerable.sol";
import "./interfaces/IDSCNFTName.sol";
import "./interfaces/IDSCMateFollowMe.sol";

contract DSCMateInfo {

    IKIP17Enumerable private mate = IKIP17Enumerable(0xE47E90C58F8336A2f24Bcd9bCB530e2e02E1E8ae);
    IDSCNFTName private mateName = IDSCNFTName(0xd095c72B42547c7097089E36908d60d13347823a);
    IDSCMateFollowMe private followMe = IDSCMateFollowMe(0x68d0EC90b70407089a419EE99C32a44c0f5Da775);

    function names(uint256 start, uint256 end) view public returns (string[] memory) {
        string[] memory _names = new string[](end - start + 1);
        for (uint256 id = start; id <= end; id += 1) {
            _names[id - start] = mateName.names(address(mate), id);
        }
        return _names;
    }

    function links(uint256 start, uint256 end, uint256 index) view public returns (string[] memory) {
        string[] memory _links = new string[](end - start + 1);
        for (uint256 id = start; id <= end; id += 1) {
            _links[id - start] = followMe.followMe(address(mate), id, index);
        }
        return _links;
    }
}
