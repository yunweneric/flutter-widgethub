# GitHub Actions Workflows

This directory contains GitHub Actions workflows for building and releasing the FlutterUI macOS app.

## Workflows

### 1. macOS Build (`macos-build.yml`)

**Triggers:**
- Push to `main` branch
- Pull requests to `main` branch

**What it does:**
1. **Test Job**: Runs code analysis and tests
2. **Build Job**: Builds the macOS app (only if tests pass)
3. **Artifacts**: Uploads the built app and build information

**Artifacts:**
- `flutterui-macos-app`: Zipped macOS app bundle
- `build-info`: Build information and pubspec.yaml
- `debug-symbols`: Debug symbols (if available)
- `test-results`: Test results (if tests fail)

### 2. Release (`release.yml`)

**Triggers:**
- Push of tags starting with `v` (e.g., `v1.0.0`)

**What it does:**
1. Builds the macOS app
2. Creates a GitHub release
3. Attaches the app bundle to the release

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

## Build Information

The workflows include:
- Flutter version: 3.24.0 (stable)
- macOS runner: `macos-latest`
- Build type: Release
- App bundle: `flutterui.app`

## Troubleshooting

### Common Issues

1. **Build fails**: Check the logs for dependency issues or code errors
2. **Tests fail**: Fix any failing tests before the build will proceed
3. **Artifacts not found**: The build may have failed - check the workflow logs

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

## Security

- The workflows only run on trusted code (main branch or PRs)
- No sensitive data is exposed in artifacts
- Debug symbols are optional and only uploaded if found 