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

When you're ready to publish a new stable version to users, you have two options:

#### Option A: Using GitHub Actions (Recommended)

1. Go to the **Actions** tab in GitHub
2. Click on the **Bump Version** workflow
3. Click the **Run workflow** dropdown button
4. Choose the version type:
   - **patch** (`1.0.0` → `1.0.1`): Bug fixes, small tweaks
   - **minor** (`1.0.0` → `1.1.0`): New features, new scripts
   - **major** (`1.0.0` → `2.0.0`): Breaking changes, major rewrites
5. Click **Run workflow**

**What happens automatically:**
- Updates `version.txt` with the new version
- Commits the version change
- Creates and pushes a version tag
- Triggers the build workflow
- Creates a GitHub Release with the `.mmip` file

#### Option B: Using Local Scripts

If you prefer to work locally with PowerShell:

```powershell
# 1. Bump the version
./scripts/bump-patch.ps1    # For bug fixes
./scripts/bump-minor.ps1    # For new features
./scripts/bump-major.ps1    # For breaking changes

# 2. Commit the version change
git add version.txt
git commit -m "Release v1.1.0: Add new tagging feature"

# 3. Create and push the tag
git tag v1.1.0
git push origin main --tags
```

**What happens:**
- GitHub Actions builds the `.mmip` file
- A new GitHub Release is automatically created
- Release notes are auto-generated from commits
- The `.mmip` file is attached to the release

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
