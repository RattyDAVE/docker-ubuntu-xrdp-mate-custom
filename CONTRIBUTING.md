# Contributing

## Issues

Issues are always very welcome - after all. However, there are a couple of things you can do to make the lives of the developers _much, much_ easier:

### Tell us

* What you are doing?
  * Post a _minimal_ code sample and particular use case that reproduces the issue
  * What do you expect to happen?
  * What is actually happening?
* Which redpanda/duing version are you using?

When you post code, please use [Github flavored markdown](https://help.github.com/articles/github-flavored-markdown), in order to get proper syntax highlighting!

If you can even provide a pull request with a failing unit test, we will love you long time! Plus your issue will likely be fixed much faster.

## Pull requests

We're glad to get pull request if any functionality is missing or something is buggy. However, there are a couple of things you can do to make life easier for the maintainers:

* Explain the issue that your PR is solving - or link to an existing issue
* Make sure that all existing tests pass
* Make sure you followed [coding guidelines](https://github.com/red-panda-ci/docker-ubuntu-xrdp-mate-custom/blob/master/CONTRIBUTING.md#coding-guidelines)
* Add some tests for your new functionality or a test exhibiting the bug you are solving. Ideally all new tests should not pass _without_ your changes.

Still interested? Coolio! Here is how to get started:

### 1. Prepare your environment

Makes sure `docker` is installed.

If running on macOS, install [Docker for Mac](https://docs.docker.com/docker-for-mac/).

### 2. Run the tests

All tests scripts and jobs are located in the `test` folder, and are executed with "bin/test.sh" script within `redpandaci/duing:test` docker container

### 3. Check the documentation

Review the [README.md](duing/README.md) file and contribute with your changes. Then you can do a commit to the repository.

### 4. Commit

Red Panda `docker-ubuntu-xrdp-mate-custom` follows the [eslint Commit Message Conventions](https://github.com/willsoto/validate-commit/blob/master/conventions/eslint.md).
Example:

```sh
git commit -m "Update: Resolve some stuff"
```

Commit messages are used to automatically generate a changelog, so make sure to follow the convention.
When you commit, your commit message might be validated automatically with [validate-commit-msg](https://github.com/willsoto/validate-commit), sou you can check this [recipie](https://gist.github.com/pedroamador/6635a4912546301c6beca6efd4dc3655).

Then push and send your pull request. Happy hacking and thank you for contributing.

### Coding Guidelines

As part of the test process, all commit messages will be linted, and your PR will **not** be accepted if it does not pass linting.

## Publishing a new release

1. Ensure that latest build on master is green
1. Ensure your local code is up to date (`git pull origin master`)
1. Create a new release with git flow and the `major(X) minor(Y) patch(Z)` (`git flow release start vX.Y.Z`) (see [Semantic Versioning](http://semver.org))
1. Publish the release `git flow feature publish vX.Y.Z`

The rest of the work will be completed within Jenkins, following the `Jenkinsfile` pipeline script.
