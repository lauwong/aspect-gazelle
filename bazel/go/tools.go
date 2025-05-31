package gotools

import (
	// used as a bazel/go target dep
	_ "golang.org/x/tools/go/analysis"

	// used by go proto targets
	_ "google.golang.org/genproto/googleapis/api"
)
