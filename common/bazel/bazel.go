package bazel

import (
	"os"

	"github.com/aspect-build/aspect-gazelle/common/bazel/workspace"
)

var wkspDirectory string

func init() {
	wkspDirectory = os.Getenv("BUILD_WORKSPACE_DIRECTORY")

	if wkspDirectory == "" {
		// Support running cli via `bazel run`
		workingDirectory := os.Getenv("BUILD_WORKING_DIRECTORY")

		// Fallback to CWD
		if workingDirectory == "" {
			wd, err := os.Getwd()
			if err != nil {
				panic(err)
			}
			workingDirectory = wd
		}

		// Find the workspace from the working directory
		finder := workspace.DefaultFinder
		wr, err := finder.Find(workingDirectory)
		if err != nil {
			panic(err)
		}

		wkspDirectory = wr
	}
}

func FindWorkspaceDirectory() string {
	return wkspDirectory
}
