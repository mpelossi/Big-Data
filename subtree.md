# Vendored upstream repos (git subtree)

These folders are plain files tracked by this repo, copied from upstream with `git subtree --squash`:

| Folder | Upstream | Branch |
|---|---|---|
| `exam_docker_lab/notebooks/bigdata-exercises` | https://github.com/RumbleDB/bigdata-exercises.git | `master` |
| `exam_docker_lab/notebooks/jsoniq-tutorials` | https://github.com/RumbleDB/jsoniq-tutorials.git | `main` |

Edit and commit them like any other file. Upstream never sees your changes.

## 1. Check for upstream updates

Run from the repo root.

**Bash (Linux / Git Bash):**

```bash
check() {
  dir=$1 url=$2 branch=$3
  synced=$(git log -1 --grep="^git-subtree-dir: $dir" --format='%(trailers:key=git-subtree-split,valueonly)' | tr -d '[:space:]')
  latest=$(git ls-remote "$url" "refs/heads/$branch" | cut -f1)
  echo "$dir"; echo "  synced: $synced"; echo "  latest: $latest"
  if [ "$synced" = "$latest" ]; then echo "  up to date"; else echo "  UPDATES AVAILABLE"; fi
}
check exam_docker_lab/notebooks/bigdata-exercises https://github.com/RumbleDB/bigdata-exercises.git master
check exam_docker_lab/notebooks/jsoniq-tutorials  https://github.com/RumbleDB/jsoniq-tutorials.git  main
```

**PowerShell (Windows):**

```powershell
$subs = @{
  "exam_docker_lab/notebooks/bigdata-exercises" = @("https://github.com/RumbleDB/bigdata-exercises.git", "master")
  "exam_docker_lab/notebooks/jsoniq-tutorials"  = @("https://github.com/RumbleDB/jsoniq-tutorials.git", "main")
}
foreach ($dir in $subs.Keys) {
  $url, $branch = $subs[$dir]
  $local  = (git log -1 --grep="^git-subtree-dir: $dir" --format="%(trailers:key=git-subtree-split,valueonly)").Trim()
  $remote = ((git ls-remote $url "refs/heads/$branch") -split "\s+")[0]
  "$dir"; "  synced: $local"; "  latest: $remote"
  if ($local -eq $remote) { "  up to date" } else { "  UPDATES AVAILABLE" }
}
```

How it works: each squash commit that `git subtree` creates records the upstream commit it came from in a `git-subtree-split:` trailer. `git ls-remote` prints the upstream branch's current commit. If the two differ, upstream has moved on.

### See what changed upstream (optional)

The same commands work in Bash and PowerShell:

```bash
git fetch https://github.com/RumbleDB/bigdata-exercises.git master
git log --oneline <synced-hash>..FETCH_HEAD          # new upstream commits
git diff --stat <synced-hash> FETCH_HEAD             # files they touched
```

## 2. Pull the updates

Commit your own work first. Subtree refuses to run on a dirty working tree. The commands are identical in Bash and PowerShell:

```bash
git subtree pull --prefix=exam_docker_lab/notebooks/bigdata-exercises https://github.com/RumbleDB/bigdata-exercises.git master --squash
git subtree pull --prefix=exam_docker_lab/notebooks/jsoniq-tutorials  https://github.com/RumbleDB/jsoniq-tutorials.git  main   --squash
```

This is a normal merge: upstream changes combine with your edits. If you and upstream changed the same part of a file, resolve the conflict, then `git add` + `git commit`. For `.ipynb` files the conflicts are in JSON, so keep your own work in separate notebooks or cells where you can.

Always pass `--squash` on pull, because the subtrees were added with `--squash`.

## 3. Adding another repo the same way

```bash
git subtree add --prefix=<folder> <url> <branch> --squash
```

`<folder>` must not exist yet. Add a row to the table above, a `check` line to the Bash script and an entry to `$subs` in the PowerShell one.

## Requirements

`git subtree` comes with Git for Windows. On Arch-based distros like CachyOS it's part of the regular `git` package. Check with `git subtree` (it should print usage). On Debian/Ubuntu it may need a separate install.
