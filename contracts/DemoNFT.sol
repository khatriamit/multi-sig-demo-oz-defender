// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC1155} from "@animoca/ethereum-contracts/contracts/token/ERC1155/ERC1155.sol";
import {ERC1155Mintable} from "@animoca/ethereum-contracts/contracts/token/ERC1155/ERC1155Mintable.sol";
import {ERC1155Burnable} from "@animoca/ethereum-contracts/contracts/token/ERC1155/ERC1155Burnable.sol";
import {ERC1155MetadataURIWithBaseURI} from "@animoca/ethereum-contracts/contracts/token/ERC1155/ERC1155MetadataURIWithBaseURI.sol";
import {ContractOwnership} from "@animoca/ethereum-contracts/contracts/access/ContractOwnership.sol";
import {AccessControlStorage} from "@animoca/ethereum-contracts/contracts/access/libraries/AccessControlStorage.sol";
import {ContractOwnershipStorage} from "@animoca/ethereum-contracts/contracts/access/libraries/ContractOwnershipStorage.sol";
import {Pause} from "@animoca/ethereum-contracts/contracts/lifecycle/Pause.sol";
import {PauseStorage} from "@animoca/ethereum-contracts/contracts/lifecycle/libraries/PauseStorage.sol";
import {Context} from "@openzeppelin/contracts/utils/Context.sol";
import {ERC1155Storage} from "@animoca/ethereum-contracts/contracts/token/ERC1155/libraries/ERC1155Storage.sol";

contract DemoNFT is
    ERC1155,
    ERC1155Mintable,
    ERC1155Burnable,
    Pause,
    ERC1155MetadataURIWithBaseURI
{
    bytes32 public constant SUPER_ADMIN_ROLE = "super_admin";
    bytes32 public constant ADMIN_ROLE = "admin";

    using AccessControlStorage for AccessControlStorage.Layout;
    using ERC1155Storage for ERC1155Storage.Layout;
    using PauseStorage for PauseStorage.Layout;
    using ContractOwnershipStorage for ContractOwnershipStorage.Layout;

    constructor() Pause(false) ContractOwnership(msg.sender) {
        AccessControlStorage.layout().grantRole(
            SUPER_ADMIN_ROLE,
            _msgSender(),
            _msgSender()
        );
        AccessControlStorage.layout().grantRole(
            ADMIN_ROLE,
            _msgSender(),
            _msgSender()
        );
    }

    function safeMint(
        address to,
        uint256 id,
        uint256 value,
        bytes calldata data
    ) external virtual override {
        PauseStorage.layout().enforceIsNotPaused();
        address sender = _msgSender();
        AccessControlStorage.layout().enforceHasRole(MINTER_ROLE, sender);
        ERC1155Storage.layout().safeMint(sender, to, id, value, data);
    }

    function transferOwnership(address newOwner) public virtual override {
        require(
            AccessControlStorage.layout().hasRole(
                SUPER_ADMIN_ROLE,
                _msgSender()
            ),
            "ORNF: not super admin"
        );
        ContractOwnershipStorage.layout().transferOwnership(
            _msgSender(),
            newOwner
        );
    }

    function grantAdminRole(address account) external virtual {
        address operator = _msgSender();
        require(
            AccessControlStorage.layout().hasRole(
                SUPER_ADMIN_ROLE,
                _msgSender()
            ),
            "ORNF: not super admin"
        );
        AccessControlStorage.layout().grantRole(ADMIN_ROLE, account, operator);
    }

    function grantMinterRole(address account) external virtual {
        address operator = _msgSender();
        require(
            AccessControlStorage.layout().hasRole(ADMIN_ROLE, _msgSender()),
            "ORNF: not admin"
        );
        AccessControlStorage.layout().grantRole(MINTER_ROLE, account, operator);
    }
}
