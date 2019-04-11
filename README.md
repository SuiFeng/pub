Pub is the package manager for Dart.

# 移除google认证
搭建私仓，用pub publish也会用到google认证服务，由于特定原因，会卡在以下步骤：

		Pub needs your authorization to upload packages on your behalf.
	    | In a web browser, go to https://accounts.google.com/o/oauth2/auth?access_type=offline&approval_prompt=force&response_type=code&client_id=818368855108-8grd2eg9tj9f38os6f1urbcvsq399u8n.apps.googleusercontent.com&redirect_uri=http%3A%2F%2Flocalhost%3A52936&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email
	    | Then click "Allow access".
	    |
	    | Waiting for your authorization...
	    
所以为了更好发布plugin到私仓，做了以下改动：

* 添加-o, --oauth 参数，默认为false，即不开启google认证服务，可以添加该参数开启认证服务

#### 安装方法

curl -L -s https://github.com/SuiFeng/pub/releases/download/SDK-2.2.1-dev.3.0-CN/install.sh | bash -s

#### 使用方法

cnpub xxxx  后面参数通pub

# Contributing to pub

Thanks for being interested in contributing to pub! Contributing to a new
project can be hard: there's a lot of new code and practices to learn. This
document is intended to get you up and running as quickly as possible. If you're
looking for documentation on using pub, try
[dartlang.org](https://www.dartlang.org/tools/pub).

The first step towards contributing is to contact the pub dev team and let us
know what you're working on, so we can be sure not to start working on the same
thing at the same time. Just send an email to [misc@dartlang.org] letting us
know that you're interested in contributing and what you plan on working on.
This will also let us give you specific advice about where to start.

[misc@dartlang.org]: mailto:misc@dartlang.org

## Organization

Pub isn't a package, but it's organized like one. It has four top-level
directories:

* `lib/` contains the implementation of pub. Currently, it's all in `lib/src/`,
  since there are no libraries intended for public consumption.

* `test/` contains the tests for pub.

* `bin/` contains `pub.dart`, the entrypoint script that's run whenever a user
  types "pub" on the command line or runs it in the Dart editor. This is usually
  run through shell scripts in `sdk/bin` at the root of the Dart repository.

It's probably easiest to start diving into the codebase by looking at a
particular pub command. Each command is encapsulated in files in
`lib/src/command/`.

## Running pub

To run pub from the Git repository, run:

    dart bin/pub.dart

## Testing pub

Before any change is made to pub, all tests should pass. To run a pub test, run:

    dart test/path/to/pub_test.dart

To run all tests at once, run:

    pub run test

Changes to pub should be accompanied by one or more tests that exercise the new
functionality. When adding a test, the best strategy is to find a similar test
in `test/` and follow the same patterns.

Pub tests come in two basic forms. The first, which is usually used to unit test
classes and libraries internal to pub, has many tests in a single file. This is
used when each test will take a short time to run. For example,
`test/version_test.dart` contains unit tests for pub's Version class.

The other form, used by most pub tests, is usually used for integration tests of
user-visible pub commands. Each test has a file to itself, which is named after
the test description. This is used when tests can take a long time to run to
avoid having the tests time out when running on the build bots. For example,
`tests/get/hosted/get_transitive_test.dart` tests the resolution of transitive
hosted dependencies when using `pub get`.

## Landing your patch

All patches to official Dart packages, including to pub, need to undergo code
review before they're submitted. The full process for putting up your patch for
review is [documented elsewhere][contributing].

[contributing]: https://github.com/dart-lang/sdk/wiki/Contributing
