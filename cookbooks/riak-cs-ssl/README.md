# riak-cs-ssl

## Description

Installs and configures Riak CS along with wildcard SSL certificates.

## Requirements

### Platforms

* Ubuntu 12.04 (Precise)
* Ubuntu 13.04 (Raring)
* CentOS 6.4
* CentOS 6.5

### Cookbooks

* riak-cs

### Recipes

* `recipe[riak-cs-ssl]` will configure SSL wildcard certificates and install
  Riak CS.

## Usage

Ensure that the `riak-cs-ssl` recipe replaces `riak-cs` in your run list.
