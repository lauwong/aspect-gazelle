{
  "$schema": "https://raw.githubusercontent.com/bazel-contrib/rules_multitool/main/lockfile.schema.json",
  "gazelle": {
    "binaries": [
      . | rtrimstr("
") | split("
") | .[] | capture("(?<sha256>[a-f0-9]{64})[ ]+assets/gazelle-(?<platform>[^ ]+)") | {
        "kind": "file",
        "url": "https://github.com/aspect-build/aspect-gazelle/releases/download/\($tag)/gazelle-\(.platform)",
        "sha256": .sha256,
        "os": (
          if .platform | startswith("linux_") then "linux"
          elif .platform | startswith("darwin_") then "macos"
          elif .platform | startswith("windows_") then "windows"
          else error("unknown platform")
          end
        ),
        "cpu": (
          if .platform | endswith("_amd64_cgo") then "x86_64"
          elif .platform | endswith("_arm64_cgo") then "arm64"
          else error("unknown cpu")
          end
        )
      }
    ]
  }
}
