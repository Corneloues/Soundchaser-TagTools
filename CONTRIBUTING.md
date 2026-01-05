# Contributing to Soundchaser-TagTools

## Development Workflow

This repository contains a MediaMonkey 2024 AddOn that's distributed as an `.mmip` file via GitHub Releases. 

### Daily Development

For regular development work (bug fixes, experiments, learning JavaScript):

```bash
# Make your changes
git add . 
git commit -m "Descriptive commit message"
git push origin main
```

**What happens:**
- GitHub Actions builds the `.mmip` file automatically
- Build artifacts are stored (but not released)
- No new version is created
- Users don't get notified of updates

### Creating a Release

When you're ready to publish a new stable version to users:

#### 1. Decide on Version Type

- **Patch** (`1.0.0` → `1.0.1`): Bug fixes, small tweaks
- **Minor** (`1.0.0` → `1.1.0`): New features, new scripts
- **Major** (`1.0.0` → `2.0.0`): Breaking changes, major rewrites

#### 2. Bump the Version

Run the appropriate PowerShell script:

```powershell
# For bug fixes
./scripts/bump-patch.ps1

# For new features
./scripts/bump-minor.ps1

# For breaking changes
./scripts/bump-major.ps1
```

#### 3. Commit, Tag, and Push

```bash
# Commit the version change
git add version.txt
git commit -m "Release v1.1.0: Add new tagging feature"

# Create a version tag
git tag v1.1.0

# Push everything including the tag
git push origin main --tags
```

**What happens:**
- GitHub Actions builds the `.mmip` file
- A new GitHub Release is automatically created
- Release notes are auto-generated from commits
- The `.mmip` file is attached to the release
- Users can download or auto-update to the new version

### Version Numbering (Semantic Versioning)

This project follows [Semantic Versioning](https://semver.org/):

```
MAJOR.MINOR.PATCH
  │     │     │
  │     │     └─ Bug fixes, minor changes
  │     └─────── New features, new scripts (backward compatible)
  └───────────── Breaking changes, significant rewrites
```

### Download URLs

Once released, the latest version is always available at:

```
https://github.com/Corneloues/Soundchaser-TagTools/releases/latest/download/Soundchaser-TagTools.mmip
```

Specific versions:
```
https://github.com/Corneloues/Soundchaser-TagTools/releases/download/v1.1.0/Soundchaser-TagTools.mmip
```

### Key Principles

- ✅ **Commit frequently** - Every change should be committed
- ✅ **Release intentionally** - Only create releases for stable milestones
- ✅ **Test before releasing** - Make sure everything works before tagging
- ✅ **Version deliberately** - Choose the appropriate version bump
- ❌ **Don't auto-version** - Versions are milestones, not commits

### Files Involved

- `version.txt` - Single source of truth for version number
- `src/info.json` - Automatically updated with version during build
- `scripts/bump-*.ps1` - Helper scripts to increment version
- `.github/workflows/build-mmip.yml` - Builds and releases the AddOn

---

For instructions on creating new actions, see [README.md](README.md).
