# Node Orb  [![CircleCI Build Status](https://circleci.com/gh/CircleCI-Public/node-orb.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/CircleCI-Public/node-orb) [![CircleCI Orb Version](https://img.shields.io/badge/endpoint.svg?url=https://badges.circleci.io/orb/circleci/node)](https://circleci.com/orbs/registry/orb/circleci/node) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/circleci-public/node-orb/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)

An orb for working with Node.js on CircleCI.

## Usage

For full usage guidelines, see the [orb registry listing](http://circleci.com/orbs/registry/orb/circleci/node).

## Examples

Full usage examples can be found on the Node orb's page in the orb registry, [here](https://circleci.com/orbs/registry/orb/circleci/node#usage-examples).


### npm
```
version: 2.1

orbs:
  node: circleci/node@x.y.z

jobs:
  build:
    executor:
      name: node/default
      tag: '10.4'
    steps:
      - checkout
      - node/with-cache:
          steps:
            - run: npm install
      - run: npm run test
```

### yarn
```
version: 2.1

orbs:
  node: circleci/node@x.y.z

jobs:
  build:
    executor:
      name: node/default
      tag: '10.4'
    steps:
      - checkout
      - node/with-cache:
          steps:
            - run: yarn install
      - run: yarn test
```

## Contributing

We welcome [issues](https://github.com/CircleCI-Public/node-orb/issues) to and [pull requests](https://github.com/CircleCI-Public/node-orb/pulls) against this repository!

For further questions/comments about this or other orbs, visit [CircleCI's orbs discussion forum](https://discuss.circleci.com/c/orbs).
