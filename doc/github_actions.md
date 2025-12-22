# GitHub Actions Workflows Documentation

This document provides a comprehensive overview of all GitHub Actions workflows used in the robotology-superbuild project.

## Table of Contents

1. [CI Workflow](#ci-workflow)
2. [Pixi CI Workflow](#pixi-ci-workflow)
3. [Generate Conda Packages](#generate-conda-packages)
4. [Generate Non-Periodical Conda Packages](#generate-non-periodical-conda-packages)
5. [Build Docker Images](#build-docker-images)
6. [MATLAB One-line Installation Test](#matlab-one-line-installation-test)
7. [Update Latest Releases](#update-latest-releases)
8. [Update Pixi Lock File](#update-pixi-lock-file)
9. [Release Workflow](#release-workflow)

---

## CI Workflow

**File:** [.github/workflows/ci.yml](.github/workflows/ci.yml)

### Purpose
Main continuous integration workflow that tests the superbuild across multiple platforms, operating systems, and project tag configurations.

### Triggers
- Manual dispatch (`workflow_dispatch`)
- Push to `master` branch and `releases/**` branches
- Tags matching `v*`
- Pull requests
- Release publications
- Scheduled runs (nightly at 2 AM UTC)

### Jobs

#### 1. `conda-build`
Tests the superbuild using conda-based dependencies.

**Matrix Strategy:**
- **Operating Systems:** Ubuntu (latest), macOS Intel (15), macOS ARM (14), Windows (2022)
- **Build Types:** Release
- **Project Tags:** Default, Unstable, LatestReleases

**Key Steps:**
- Sets up Miniforge3 conda environment
- Installs MATLAB compilation files for MEX support across platforms
- Installs comprehensive dependencies (ACE, Eigen, VTK, OpenCV, Qt, Python packages, etc.)
- Configures with CMake using platform-specific generators (Ninja for Linux/macOS, Visual Studio for Windows)
- Builds the superbuild
- Validates Python package metadata (except on Apple Silicon)

**Platform-Specific Notes:**
- Linux: Uses additional dependencies including Gazebo, mold linker, and X11 libraries
- Windows: Removes Strawberry Perl to avoid pkg-config conflicts
- macOS ARM: Sets `QT_HOST_PATH` workaround for Qt6 issues

#### 2. `docker-build`
Tests the superbuild in clean Docker containers.

**Matrix Strategy:**
- **Docker Images:** Ubuntu 22.04, Ubuntu 24.04
- **Build Types:** Debug
- **Project Tags:** Default, Unstable
- **CMake Generator:** Ninja

**Key Steps:**
- Frees disk space by removing unnecessary GitHub Actions tools
- Installs Debian-based dependencies
- Configures and builds the superbuild
- Disables Gazebo Classic support on Ubuntu 24.04 (no binaries available)

#### 3. `normal-build`
Tests the superbuild without using conda, directly with system dependencies.

**Matrix Strategy:**
- **Operating Systems:** Ubuntu 22.04, Windows 2022
- **Build Types:** Release
- **Project Tags:** Default, Unstable, LatestReleases

**Key Steps:**
- Linux: Uses installation scripts in `.ci/install_debian.sh`
- Windows: Downloads pre-compiled vcpkg dependencies archive
- Configures with MATLAB support on Linux
- On Windows, builds both Debug and Release configurations for releases
- Generates Windows installers (full and dependencies-only) on release events
- Uploads installers as release assets

**Windows-Specific Features:**
- Moves source to C:\ drive to avoid path length limitations
- Disables Git symlinks
- Uses vcpkg toolchain for dependency management
- Disables unsupported options (TELEOPERATION, MUJOCO, GZ)

---

## Pixi CI Workflow

**File:** [.github/workflows/pixi-ci.yml](.github/workflows/pixi-ci.yml)

### Purpose
Tests the superbuild using Pixi package manager for dependency management.

### Triggers
- Manual dispatch with option to delete `pixi.lock`
- Pull requests
- Scheduled runs (twice weekly: Tuesday and Friday at 2 AM UTC)

### Matrix Strategy
- **Operating Systems:** Ubuntu 22.04, Ubuntu 24.04 ARM, macOS Intel (15), macOS ARM (14), Windows 2022
- **Build Types:** Release
- **Pixi Tasks:** `build-all`, `build-ros2`
- **Exclusions:** Windows + `build-ros2` (due to CI-specific path length issues)

### Key Steps
- Optionally deletes `pixi.lock` on scheduled runs or manual trigger to test against latest dependencies
- Sets up Pixi environment
- Uses ccache for faster compilation
- Configures Git user for YCM compliance
- On Windows, explicitly runs configuration tasks before build
- Runs specified Pixi build task

---

## Generate Conda Packages

**File:** [.github/workflows/generate-conda-packages.yaml](.github/workflows/generate-conda-packages.yaml)

### Purpose
Automatically generates and uploads conda packages for all components in the robotology-superbuild.

### Triggers
- Manual dispatch with options:
  - `upload_conda_binaries`: Controls whether to upload packages (default: true)
  - `test_metapackages_generation`: Tests metapackage generation without upload
- Scheduled weekly (Tuesdays at midnight UTC)
- Release publications

### Jobs

#### 1. `get-conda-build-number`
Reads the `CONDA_BUILD_NUMBER` from the master branch regardless of trigger branch.

#### 2. `generate-conda-packages`
Builds conda packages for each platform.

**Matrix Strategy:**
- **Platforms:** Ubuntu 22.04 (linux-64), macOS 14 (osx-arm64), Windows 2022 (win-64)

**Key Steps:**
- Sets up Miniforge3 and installs build tools (rattler-build, anaconda-client, pixi)
- Installs MATLAB MEX compilation files for each platform
- Configures CMake with `ROBOTOLOGY_GENERATE_CONDA_RECIPES=ON`
- On releases, also generates robotology-distro metapackages
- Builds packages using `rattler-build` with conda-forge pinning
- Uploads to both Anaconda Cloud and prefix.dev (robotology channel)
- Temporarily excludes robot-log-visualizer package

#### 3. `bump-conda-build-number`
Automatically increments `CONDA_BUILD_NUMBER` in master branch after successful uploads.

---

## Generate Non-Periodical Conda Packages

**File:** [.github/workflows/generate-non-periodical-conda-package.yaml](.github/workflows/generate-non-periodical-conda-package.yaml)

### Purpose
Generates conda packages for components that don't follow the regular periodic release schedule. See `doc/conda-recipe-generation.md` for details.

### Triggers
- Manual dispatch with `upload_conda_binaries` option

### Matrix Strategy
- **Platforms:** Ubuntu 22.04 (linux-64), macOS 14 (osx-arm64), Windows 2022 (win-64)

### Key Steps
- Uses `rattler-build` to build packages from `non_periodical_recipes/` directory
- Uploads to both Anaconda Cloud and prefix.dev when triggered

---

## Build Docker Images

**File:** [.github/workflows/build-docker-images.yml](.github/workflows/build-docker-images.yml)

### Purpose
Triggers Docker image builds in the `icub-tech-iit/docker-deployment-images` repository when a new release is published.

### Triggers
- Release publications only

### Workflow
1. Extracts version number from release tag
2. Obtains GitHub App token for cross-repository access
3. Dispatches `release_trigger` event to docker-deployment-images repository with version payload

---

## MATLAB One-line Installation Test

**File:** [.github/workflows/matlab-one-line-install-test.yml](.github/workflows/matlab-one-line-install-test.yml)

### Purpose
Tests the one-line MATLAB/Simulink installation script across multiple MATLAB versions and platforms.

### Triggers
- Manual dispatch for version tags
- Scheduled runs (twice weekly: Tuesday and Friday at 2 AM UTC)

### Matrix Strategy
- **Operating Systems:** Ubuntu 24.04, macOS 13, Windows latest
- **MATLAB Versions:** R2022a, R2023a, R2024a, latest

### Key Steps
- Installs specified MATLAB version using official GitHub Action
- Runs `install_robotology_packages()` script
- On Ubuntu, sets `LD_PRELOAD` to avoid libstdc++ incompatibilities
- Tests that packages are correctly installed by creating iDynTree and YARP objects

---

## Update Latest Releases

**File:** [.github/workflows/update-latest-releases.yml](.github/workflows/update-latest-releases.yml)

### Purpose
Automatically updates the `releases/latest.releases.yaml` file with the latest release versions of all tracked repositories. See `doc/developer-faqs.md` for more information.

### Triggers
- Manual dispatch
- Scheduled weekly (Sundays at midnight UTC)

### Workflow
1. Installs `yq` tool for YAML manipulation
2. Downloads all repository sources using CMake update targets
3. Runs `robotologyUpdateLatestReleases.sh` script to detect latest releases
4. Creates a pull request with updates
5. PR requires manual review and re-opening to trigger CI (GitHub Actions limitation)

---

## Update Pixi Lock File

**File:** [.github/workflows/pixi-update-lock.yml](.github/workflows/pixi-update-lock.yml)

### Purpose
Updates the `pixi.lock` file to latest dependency versions.

### Triggers
- Manual dispatch only

### Workflow
1. Deletes existing `pixi.lock`
2. Runs `pixi install` to generate new lock file with latest versions
3. Creates pull request with updated lock file
4. Automated with GitHub bot author

---

## Release Workflow

**File:** [.github/workflows/release.yml](.github/workflows/release.yml)

### Purpose
Automates the creation of a new robotology-superbuild release branch and initial release tag.

### Triggers
- Manual dispatch with required input:
  - `superbuild_year_month_prefix`: Release version (format: YYYY.MM, e.g., 2021.11)

### Workflow Steps

1. **Create Release YAML**
   - Copies `releases/latest.releases.yaml` to `releases/YYYY.MM.0.yaml`
   - Commits to master branch

2. **Create Release Branch**
   - Creates `releases/YYYY.MM` branch
   - Updates `RobotologySuperbuildOptions.cmake`:
     - Sets `ROBOTOLOGY_PROJECT_TAGS` to "Custom"
     - Sets `ROBOTOLOGY_PROJECT_TAGS_CUSTOM_FILE` to release YAML
   - Updates `packaging/windows/CMakeLists.txt` with installer version
   - Updates `conda/cmake/CondaGenerationOptions.cmake` with conda version

3. **Create Release Tag**
   - Creates and pushes `vYYYY.MM.0` tag on release branch

---

## Common Patterns

### Secrets Used
- `GITHUB_TOKEN`: Standard GitHub Actions token
- `ACCESS_TOKEN`: Enhanced permissions for release asset uploads
- `ANACONDA_API_TOKEN`: Upload to Anaconda Cloud
- `PREFIX_DEV_TOKEN`: Upload to prefix.dev
- `ICUB_TECH_IIT_APP_KEY` & `ICUB_TECH_IIT_APP_ID`: GitHub App credentials for cross-repo triggers

### MATLAB MEX Compilation
Multiple workflows download pre-built MATLAB SDK packages to enable MEX file compilation without full MATLAB installation:
- Linux: R2020b (mexa64)
- macOS Intel: R2020a (mexmaci64)
- macOS ARM: R2023b (mexmaca64)
- Windows: R2020a (mexw64)

### Caching Strategies
- Conda packages use built-in conda cache
- Pixi builds use ccache with platform/task-specific keys
- Windows vcpkg uses pre-compiled dependency archives

### Build Artifacts
- Windows installers (on releases)
- Conda packages (uploaded to Anaconda and prefix.dev)
- Docker image triggers (external repository)

---

## Maintenance Notes

### Updating Dependencies
- Conda dependencies are specified in workflow YAML files
- Pixi dependencies are managed via `pixi.toml` and `pixi.lock`
- vcpkg dependencies are managed externally in `robotology-superbuild-dependencies-vcpkg`

### Adding New Platforms
When adding support for a new OS or platform:
1. Update matrix strategies in CI workflows
2. Add platform-specific dependency installation steps
3. Update MATLAB MEX file handling if needed
4. Consider ccache or other caching strategies

### Release Process
The standard release process involves:
1. Running "Update Latest Releases" workflow
2. Reviewing and merging the generated PR
3. Manually triggering "Create a new release" workflow with version number
4. Verifying CI passes on new release branch
5. GitHub creates release which triggers installer builds and Docker images
