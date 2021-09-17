pragma solidity ^0.5.6;
pragma experimental ABIEncoderV2;

import "./klaytn-contracts/token/KIP17/IKIP17Enumerable.sol";
import "./interfaces/IDSCMateName.sol";
import "./interfaces/IDSCMateFollowMe.sol";

contract DSCMateInfo {

    IKIP17Enumerable private mate = IKIP17Enumerable(0xE47E90C58F8336A2f24Bcd9bCB530e2e02E1E8ae);
    IDSCMateName private mateName = IDSCMateName(0x12C591fCd89B83704541B1Eac6b4aA18063A6954);
    IDSCMateFollowMe private followMe = IDSCMateFollowMe(0x68d0EC90b70407089a419EE99C32a44c0f5Da775);

    function names(uint256 start, uint256 end) view public returns (string[] memory) {
        string[] memory _names = new string[](end - start + 1);
        for (uint256 id = start; id <= end; id += 1) {
            _names[id - start] = mateName.getName(id);
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
