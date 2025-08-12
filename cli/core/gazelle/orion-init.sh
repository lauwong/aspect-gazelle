echo "Generate base Orion repository"

# Gitignore bazel stuff
cat >.gitignore <<-EOGITIGNORE
bazel-*
*.bazel.lock
**/node_modules
EOGITIGNORE

# Overwrite the .bazelrc to a minimal version not referencing any repos
cat >.bazelrc <<-EOBAZELRC
EOBAZELRC

# Root BUILD
echo "# BLANK" >BUILD.bazel

# Stubs for bazel/ts/defs.bzl
mkdir -p bazel/ts
echo "# BLANK" >bazel/ts/BUILD.bazel
cat >bazel/ts/defs.bzl <<-EOTSDEFS
def ts_config(name, **kwargs):
    pass
def ts_project(name, **kwargs):
    pass
def ts_proto_library(name, **kwargs):
    pass
EOTSDEFS

# Empty BUILD alongside *.MODULE.bazel files
echo "# BLANK" >bazel/include/BUILD.bazel

# MODULE file
cat >MODULE.bazel <<-EOMODULE
module(name = "aspect_orion", version = "0.0.0")

bazel_dep(name = "aspect_bazel_lib", version = "2.10.0")
bazel_dep(name = "aspect_rules_js", version = "2.1.2")
bazel_dep(name = "rules_shell", version = "0.4.0")

include("//bazel/include:go.MODULE.bazel")
include("//bazel/include:proto.MODULE.bazel")
include("//bazel/include:python.MODULE.bazel")
include("//cli/core/gazelle/common/treesitter/grammars:grammars.MODULE.bazel")
EOMODULE

# None of the generated files should have changed existing files.
if [[ $(git diff) ]]; then
    echo "$0 should not change any git tracked files"
    git diff
    exit 1
fi
