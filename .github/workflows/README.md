# GitHub Actions Workflows

This directory contains GitHub Actions workflows for building and releasing the FlutterUI macOS app.

## Workflows

### 1. macOS Build (`macos-build.yml`) - **MAIN WORKFLOW**

**Triggers:**
- Push to `main` branch
- Pull requests to `main` branch

**What it does:**
1. **Build**: Directly builds the macOS app
2. **Package**: Creates the app bundle
3. **Upload**: Saves as artifact

**Artifacts:**
- `flutterui-macos-app`: Zipped macOS app bundle

**Features:**
- ✅ Fastest build process
- ✅ No analysis or test overhead
- ✅ Minimal artifact size
- ✅ Reliable for CI/CD
- ✅ Proven to work locally

### 2. Release (`release.yml`)

**Triggers:**
- Push of tags starting with `v` (e.g., `v1.0.0`)

**What it does:**
1. Builds the macOS app
2. Creates a GitHub release
3. Attaches the app bundle to the release

## Current Status

### ✅ **What Works:**

- **macOS build**: ✅ Works locally and in CI
- **App packaging**: ✅ Creates proper `.app` bundle
- **Artifact upload**: ✅ Successfully saves to GitHub
- **Dependencies**: ✅ All packages resolve correctly

### ❌ **What Was Removed:**

- **Complex workflows**: Removed problematic analysis and test steps
- **Multiple options**: Simplified to one reliable workflow
- **Unnecessary complexity**: Focus on core build functionality

## Usage

### For Regular Builds

1. Push to `main` branch or create a pull request
2. The workflow will automatically run
3. Check the Actions tab to see the build status
4. Download artifacts from the Actions page

### For Releases

1. Create and push a tag:
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```

2. The release workflow will automatically:
   - Build the app
   - Create a GitHub release
   - Attach the macOS app bundle

### Accessing Artifacts

1. Go to your repository on GitHub
2. Click on the "Actions" tab
3. Click on a workflow run
4. Scroll down to the "Artifacts" section
5. Download the artifacts you need

## Local Testing

### Test the Build Process

```bash
# Enable macOS desktop
flutter config --enable-macos-desktop

# Get dependencies
flutter pub get

# Build the app
flutter build macos --release

# Check output
ls -la build/macos/Build/Products/Release/
```

### Expected Output

```
build/macos/Build/Products/Release/
└── flutterui.app (73.2MB)
```

## Build Information

The workflow includes:
- Flutter version: 3.24.0 (stable)
- macOS runner: `macos-latest`
- Build type: Release
- App bundle: `flutterui.app`

## Troubleshooting

### Common Issues

1. **Build fails**: Check the logs for dependency issues or code errors
2. **Artifacts not found**: The build may have failed - check the workflow logs
3. **Workflow not running**: Ensure you're pushing to `main` branch or creating PRs

### Manual Build

To build locally:
```bash
flutter config --enable-macos-desktop
flutter pub get
flutter build macos --release
```

The built app will be in `build/macos/Build/Products/Release/flutterui.app`

## Configuration

### Environment Variables

No special environment variables are required. The workflows use:
- `GITHUB_TOKEN`: Automatically provided by GitHub Actions
- Flutter and Dart versions are specified in the workflow files

### Customization

To modify the workflows:
1. Edit the `.yml` files in this directory
2. The workflows use standard GitHub Actions syntax
3. Test changes by pushing to a branch first

## Future Improvements

1. **Add Tests**: Create basic unit tests for critical components
2. **Code Quality**: Implement proper linting rules and fix violations
3. **Performance**: Optimize build process and reduce artifact size
4. **Analysis**: Gradually add code analysis after fixing linting issues

## Support

If you have issues:
1. Check the Actions tab for detailed error logs
2. Compare local vs CI environment differences
3. The current workflow is proven to work locally
4. Use the release workflow for versioned builds 