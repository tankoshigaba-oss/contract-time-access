# Time-Based Access Control Smart Contract

A Clarity smart contract for the Stacks blockchain that implements time-based access control using block heights.

## Overview

This smart contract provides functionality to control access to content based on block height windows. It allows an owner to define specific time windows during which users can access content.

## Features

- **Owner Management**: Single owner initialization system
- **Time Window Control**: Set access windows using block heights
- **Access Verification**: Check if access is currently allowed
- **View Functions**: Query current access window and status

## Contract Functions

### Administrative Functions

- `initialize-owner`: One-time function to set the contract owner
- `set-access-window`: Set the start and end block heights for access (owner only)

### Public Functions

- `access-content`: Attempt to access content within the allowed time window
- `get-access-window`: View the current access window settings
- `can-access`: Check if access is currently allowed

## Error Codes

- `ERR-NOT-AUTHORIZED (u100)`: User is not authorized to perform the action
- `ERR-NOT-IN-TIME (u101)`: Access attempt outside the allowed time window
- `ERR-INVALID-WINDOW (u102)`: Invalid time window configuration
- `ERR-ALREADY-INITIALIZED (u103)`: Owner already initialized

## Usage

1. Deploy the contract
2. Call `initialize-owner` to set the contract owner
3. Owner sets access window using `set-access-window`
4. Users can check access with `can-access` and attempt access with `access-content`

## Example

```clarity
;; Set an access window (as contract owner)
(contract-call? .contract-time-access set-access-window u100 u200)

;; Check if access is currently allowed
(contract-call? .contract-time-access can-access)

;; Attempt to access content
(contract-call? .contract-time-access access-content)
```

## Development

This contract is built using [Clarity](https://clarity-lang.org/), the smart contract language for Stacks blockchain.

To test the contract:
```bash
clarinet check
```
