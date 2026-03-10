# Copyright (C) Dominik Picheta. All rights reserved.
# BSD License. Look at license.txt for more info.

{.used.}

import unittest, strutils, os
import testscommon
from nimblepkg/common import cd

suite "nimble getPaths/getPathsClause":
  test "check getPaths result":
    cd "tasks/getpaths":
      let (output, exitCode) = execNimble("echoPaths")
      check exitCode == QuitSuccess
      # Verify getPaths() returns actual dependency paths, not empty strings.
      # The output has two lines from the task: getPaths() result and getPathsClause() result.
      # getPathsClause() should contain --path: followed by an actual path to benchy/unittest2.
      check output.contains("--path:") # getPathsClause produces --path: flags
      let lines = output.strip().splitLines()
      # Find the getPathsClause line (contains --path:)
      var pathsClauseLine = ""
      for line in lines:
        if line.contains("--path:") and line.contains("pkgs2"):
          pathsClauseLine = line
          break
      check pathsClauseLine.len > 0 # getPathsClause should have actual paths
      check pathsClauseLine.contains("benchy")
      check pathsClauseLine.contains("unittest2")
