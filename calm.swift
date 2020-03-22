#!/usr/bin/swift sh

import ArgumentParser // apple/swift-argument-parser == 0.0.2
import ShellKit // https://gitlab.com/thecb4/shellkit.git  == 2630153a
import Version // mxcl/Version == 2.0.0

// import SigmaSwiftStatistics evgenyneu/SigmaSwiftStatistics == master

let env = ["PATH": "/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"]

extension Version: ExpressibleByArgument {}

extension ParsableCommand {
  static func run(using arguments: [String] = []) throws {
    let command = try parseAsRoot(arguments)
    try command.run()
  }
}

extension CommandConfiguration: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    self.init(abstract: value)
  }
}

struct Calm: ParsableCommand {
  static var configuration = CommandConfiguration(
    abstract: "A utility for performing command line work",
    subcommands: [
      Test.self,
      Hygene.self,
      LocalIntegration.self,
      ContinuousIntegration.self,
      Save.self,
      Release.self,
      Documentation.self
    ],
    defaultSubcommand: Hygene.self
  )
}

extension Calm {
  struct Hygene: ParsableCommand {
    static var configuration = "Perform hygene activities on the project"

    func run() throws {
      try ShellKit.validate(Shell.exists(at: "commit.yml"), "You need to add a commit.yml file")
      try ShellKit.validate(!Shell.git_ls_untracked.contains("commit.yml"), "You need to track commit file")
      try ShellKit.validate(Shell.git_ls_modified.contains("commit.yml"), "You need to update your commit file")
    }
  }

  struct Test: ParsableCommand {
    static var configuration = "Run tests"

    func run() throws {
      try Shell.swiftTestGenerateLinuxMain(environment: env)
      try Shell.swiftFormat(version: "5.1", environment: env)

      var arguments = [
        "--parallel",
        "--xunit-output Tests/Results.xml",
        "--enable-code-coverage"
      ]

      #if os(Linux)
        arguments += ["--filter \"^(?!.*MacOS).*$\""]
      #endif

      try Shell.swiftTest(arguments: arguments)
    }
  }

  struct Save: ParsableCommand {
    static var configuration = "git commit activities"

    func run() throws {
      try Hygene.run()
      try Shell.changelogger(arguments: ["log"])
      try Shell.git(arguments: ["add", "-A"])
      try Shell.git(arguments: ["commit", "-F", "commit.yml"])
    }
  }

  struct LocalIntegration: ParsableCommand {
    static var configuration = "Perform local integration"

    @Flag(help: "Save on integration completion")
    var save: Bool

    func run() throws {
      try Hygene.run()
      try Test.run()
      if save { try Save.run() }
    }
  }

  struct ContinuousIntegration: ParsableCommand {
    static var configuration = "Perform continous integration"

    func run() throws {
      try Test.run()
    }
  }

  struct Documentation: ParsableCommand {
    static var configuration = "Generate Documentation"

    func run() throws {
      try Shell.swiftDoc(
        name: "ShellKit",
        output: "docs",
        author: "Cavelle Benjamin",
        authorUrl: "https://thecb4.io",
        twitterHandle: "_thecb4",
        gitRepository: "https://github.com/thecb4/ShellKit"
      )
    }
  }
}

extension Calm {
  struct Release: ParsableCommand {
    static var configuration = CommandConfiguration(
      abstract: "Release of work",
      subcommands: [
        New.self,
        Prepare.self,
        Publish.self
      ],
      defaultSubcommand: New.self
    )
  }
}

extension Calm.Release {
  struct New: ParsableCommand {
    static var configuration = "creates new release (tag)"
    // TO-DO: move to an option group
    @Argument(help: "version for the release")
    var version: Version

    func run() {
      print("new release \(version)")
    }
  }

  struct Prepare: ParsableCommand {
    static var configuration = "prepare the current release"

    @Argument(help: "summary of the release to prepare")
    var summary: String

    @Argument(help: "version for the release")
    var version: Version

    func run() throws {
      let files = try Shell.git(arguments: ["status", "--untracked-files=no", "--porcelain"])
      try ShellKit.validate(files.out == "", "Dirt repository. Clean it up before preparing your release")

      try Shell.changelogger(arguments: ["release", "\"\(summary)\"", "--version-tag", version.description], environment: env)
      try Shell.changelogger(arguments: ["markdown"])

      try Shell.git(arguments: ["add", "-A"])
      try Shell.git(arguments: ["commit", "-F", "commit.yml"])
    }
  }

  struct Publish: ParsableCommand {
    @Argument(help: "version for the release")
    var version: Version

    func run() {
      print("new release \(version)")
    }
  }
}

Calm.main()
