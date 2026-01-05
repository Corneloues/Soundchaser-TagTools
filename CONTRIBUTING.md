# Contributing to Soundchaser-TagTools

## Build and Release States

This project uses different workflows depending on your intent:

### 1. Development Builds (No Release)

**Use case:** Daily development, experiments, testing locally

**How:**
- Just commit and push to `main`
- No tag needed

**What happens:**
- ✅ Workflow builds the `.mmip` file
- ✅ Uploaded as a workflow artifact (available for 90 days)
- ❌ No GitHub Release created
- ❌ Users don't see it

**Download:** Go to Actions tab → Click workflow run → Download artifact

---

### 2. Pre-Release (Beta/Alpha Testing)

**Use case:** Share with testers before official release

**Version format:** `v1.0.0-beta.1`, `v1.0.0-alpha.1`, `v1.0.0-rc.1`

**How to create via GitHub Actions:**
1. Go to **Actions** → **Bump Version**
2. Click **Run workflow**
3. Select version type (`patch`, `minor`, `major`)
4. Select pre-release type (`alpha`, `beta`, or `rc`)
5. Enter pre-release number (e.g., `1`)
6. Click **Run workflow**

**What happens:**
- ✅ Creates a GitHub Release
- ⚠️ Marked as "Pre-release" (orange badge)
- ❌ NOT marked as "Latest Release"
- ✅ Can be downloaded from Releases page
- ✅ Testers know it's not stable

---

### 3. Stable Release (Production)

**Use case:** Official, production-ready version for all users

**Version format:** `v1.0.0` (no suffix)

**How to create via GitHub Actions:**
1. Go to **Actions** → **Bump Version**
2. Click **Run workflow**
3. Select version type (`patch`, `minor`, `major`)
4. Leave pre-release type empty
5. Click **Run workflow**

**What happens:**
- ✅ Creates a GitHub Release
- ✅ Marked as "Latest Release" (green badge)
- ✅ Shown on repository homepage
- ✅ Available at stable URL: `/releases/latest/download/...`

---

### Version Numbering

Follows [Semantic Versioning](https://semver.org/):

```
MAJOR.MINOR.PATCH[-prerelease.number]
  │     │     │         │
  │     │     │         └─ Pre-release identifier (optional)
  │     │     └─────────── Bug fixes
  │     └────────────────── New features (backward compatible)
  └──────────────────────── Breaking changes
```

**Examples:**
- `1.0.0` - Stable release
- `1.1.0-beta.1` - Beta pre-release
- `1.1.0-beta.2` - Second beta
- `1.1.0-rc.1` - Release candidate
- `1.1.0` - Final stable after testing

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

For information on creating releases, see the [Build and Release States](#build-and-release-states) section above.

When you're ready to publish a new version to users:

#### Using GitHub Actions (Recommended)

1. Go to the **Actions** tab in GitHub
2. Click on the **Bump Version** workflow
3. Click the **Run workflow** dropdown button
4. Choose the version type:
   - **patch** (`1.0.0` → `1.0.1`): Bug fixes, small tweaks
   - **minor** (`1.0.0` → `1.1.0`): New features, new scripts
   - **major** (`1.0.0` → `2.0.0`): Breaking changes, major rewrites
5. (Optional) Select pre-release type for beta/alpha/rc releases
6. Click **Run workflow**

**What happens automatically:**
- Updates `version.txt` with the new version
- Commits the version change
- Creates and pushes a version tag
- Triggers the build workflow
- Creates a GitHub Release with the `.mmip` file

#### Using Local Scripts (Alternative)

If you prefer to work locally with PowerShell:

```powershell
# 1. Manually update version.txt (e.g., 1.1.0 or 1.1.0-beta.1)
# Edit version.txt

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
- Pre-release status is detected from tag name (if it contains alpha/beta/rc)

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
