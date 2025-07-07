# Quick Start Guide: FlutterUI Migration Phase 1

## 🚀 Get Started in 30 Minutes

This guide helps you begin implementing Phase 1 of the FlutterUI migration to shadcn/ui-style architecture.

## Prerequisites

- Flutter SDK 3.0+
- Dart SDK 3.0+
- Git

## Step 1: Create CLI Tool (15 minutes)

### 1.1 Create CLI Project

```bash
# Create new CLI project
mkdir flutterui-cli
cd flutterui-cli
dart create --template=package-simple .

# Install dependencies
dart pub add args path yaml http archive file cli_util pub_semver
dart pub add --dev test lints
```

### 1.2 Create Basic CLI Structure

```bash
# Create directory structure
mkdir -p lib/commands lib/services lib/models lib/api
mkdir -p test bin
```

### 1.3 Implement Core Files

Copy the following files from `PHASE_1_IMPLEMENTATION_GUIDE.md`:

1. `bin/flutterui.dart` - Main CLI entry point
2. `lib/commands/base_command.dart` - Base command class
3. `lib/commands/install_command.dart` - Install command
4. `lib/services/component_service.dart` - Component management
5. `lib/services/project_service.dart` - Project utilities
6. `lib/models/component.dart` - Component data model

### 1.4 Test Basic CLI

```bash
# Make CLI executable
chmod +x bin/flutterui.dart

# Test installation
dart run bin/flutterui.dart --help
dart run bin/flutterui.dart install --help
```

## Step 2: Set Up Component Registry (10 minutes)

### 2.1 Create Registry Structure

```bash
# Create registry directory
mkdir -p registry/components
```

### 2.2 Create Registry JSON

Create `registry/registry.json` with the structure from the implementation guide.

### 2.3 Add Sample Component

Create a sample component entry in the registry for testing.

## Step 3: Prepare Migration Script (5 minutes)

### 3.1 Create Migration Directory

```bash
mkdir -p scripts
```

### 3.2 Create Migration Script

Copy the migration script from the implementation guide to `scripts/migrate_components.dart`.

## 🎯 Immediate Next Actions

### Today

1. ✅ Set up CLI tool structure
2. ✅ Test basic CLI functionality
3. ✅ Create component registry
4. ✅ Prepare migration script

### This Week

1. **Complete CLI Implementation**

   - Implement all commands (list, search, update, remove, validate)
   - Add error handling and validation
   - Create comprehensive tests

2. **Set Up Component Registry**

   - Create API endpoints for registry access
   - Add local fallback mechanism
   - Implement component search functionality

3. **Create Migration Infrastructure**
   - Test migration script with existing components
   - Create component manifest templates
   - Set up new project structure

### Next Week

1. **Migrate First Components**

   - Start with simple components (buttons, cards)
   - Create component manifests
   - Test CLI installation

2. **Documentation & Testing**
   - Complete CLI documentation
   - Create user guides
   - Set up CI/CD for CLI tool

## 🔧 Development Commands

### CLI Development

```bash
# Run CLI locally
dart run bin/flutterui.dart

# Run tests
dart test

# Format code
dart format .

# Analyze code
dart analyze
```

### Component Testing

```bash
# Test component installation
dart run bin/flutterui.dart install --component test_component

# Validate component structure
dart run bin/flutterui.dart validate --component test_component

# List available components
dart run bin/flutterui.dart list
```

## 📁 Project Structure After Phase 1

```
flutterui/
├── components/           # New flat-file structure
│   ├── animations/
│   ├── blocks/
│   ├── effects/
│   └── templates/
├── flutterui-cli/        # CLI tool
│   ├── bin/
│   ├── lib/
│   └── test/
├── registry/             # Component registry
│   ├── registry.json
│   └── components/
├── scripts/              # Migration scripts
└── docs/                 # Documentation
```

## 🚨 Common Issues & Solutions

### CLI Not Found

```bash
# Add to PATH
export PATH="$PATH:$HOME/.pub-cache/bin"
# Or use local execution
dart run bin/flutterui.dart
```

### Component Not Found

- Check registry.json exists
- Verify component name spelling
- Ensure registry URL is accessible

### Migration Errors

- Backup existing components first
- Test migration script on sample components
- Check file permissions

## 📞 Getting Help

1. **Check Documentation**: `PHASE_1_IMPLEMENTATION_GUIDE.md`
2. **Review Migration Plan**: `MIGRATION_PLAN.md`
3. **Component Export System**: `COMPONENT_EXPORT_SYSTEM.md`

## 🎉 Success Metrics

Phase 1 is complete when:

- [ ] CLI tool installs and runs without errors
- [ ] Component registry is accessible
- [ ] Migration script works for existing components
- [ ] At least 5 components are migrated to new structure
- [ ] CLI can install components into test projects

---

**Ready to start?** Begin with Step 1 and you'll have a working CLI tool in 15 minutes!
