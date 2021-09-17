pragma solidity ^0.5.6;
pragma experimental ABIEncoderV2;


/**
 * @dev Interface of the KIP-13 standard, as defined in the
 * [KIP-13](http://kips.klaytn.com/KIPs/kip-13-interface_query_standard).
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others.
 *
 * For an implementation, see `KIP13`.
 */
interface IKIP13 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * [KIP-13 section](http://kips.klaytn.com/KIPs/kip-13-interface_query_standard#how-interface-identifiers-are-defined)
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

/**
 * @dev Required interface of an KIP17 compliant contract.
 */
contract IKIP17 is IKIP13 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of NFTs in `owner`'s account.
     */
    function balanceOf(address owner) public view returns (uint256 balance);

    /**
     * @dev Returns the owner of the NFT specified by `tokenId`.
     */
    function ownerOf(uint256 tokenId) public view returns (address owner);

    /**
     * @dev Transfers a specific NFT (`tokenId`) from one account (`from`) to
     * another (`to`).
     *
     * Requirements:
     * - `from`, `to` cannot be zero.
     * - `tokenId` must be owned by `from`.
     * - If the caller is not `from`, it must be have been allowed to move this
     * NFT by either `approve` or `setApproveForAll`.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) public;

    /**
     * @dev Transfers a specific NFT (`tokenId`) from one account (`from`) to
     * another (`to`).
     *
     * Requirements:
     * - If the caller is not `from`, it must be approved to move this NFT by
     * either `approve` or `setApproveForAll`.
     */
    function transferFrom(address from, address to, uint256 tokenId) public;
    function approve(address to, uint256 tokenId) public;
    function getApproved(uint256 tokenId) public view returns (address operator);

    function setApprovalForAll(address operator, bool _approved) public;
    function isApprovedForAll(address owner, address operator) public view returns (bool);


    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public;
}

/**
 * @title KIP-17 Non-Fungible Token Standard, optional enumeration extension
 * @dev See http://kips.klaytn.com/KIPs/kip-17-non_fungible_token
 */
contract IKIP17Enumerable is IKIP17 {
    function totalSupply() public view returns (uint256);
    function tokenOfOwnerByIndex(address owner, uint256 index) public view returns (uint256 tokenId);

    function tokenByIndex(uint256 index) public view returns (uint256);
}

interface IDSCMateName {
    
    event Set(uint256 indexed mateId, address indexed owner, string name);
    
    function tokenAmountForChanging() view external returns (uint256);
    function exists(string calldata name) view external returns (bool);
    function set(uint256 mateId, string calldata name) external;
    function recordCount(uint256 mateId) view external returns (uint256);
    function record(uint256 mateId, uint256 index) view external returns (address owner, string memory name, uint256 blockNumber);
    function getName(uint256 mateId) view external returns (string memory name);
}

interface IDSCMateFollowMe {
    
    event Set(address indexed mates, uint256 indexed mateId, address owner, uint256 indexed index, string link);
    
    function set(address mates, uint256 mateId, uint256 index, string calldata link) external;
    function followMe(address mates, uint256 mateId, uint256 index) view external returns (string memory link);
}

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