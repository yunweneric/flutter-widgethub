<p align="center">
  <a href="https://flutterwidgethub.com/" target="blank"><img src="https://raw.githubusercontent.com/yunweneric/flutter-widgethub/main/assets/images/fwh.png"  alt="Flutter widget landing page" /></a>
</p>
  <p align="center">Welcome to <a href="https://flutterwidgethub.com/" target="_blank"> Flutter Widget Hub </a>Build Stunning Flutter Apps with Ease</p>
    <p align="center">
<a><img alt="GitHub repo size" src="https://img.shields.io/github/repo-size/yunweneric/flutter-widgethub?color=%233867D6&style=for-the-badge"></a>
<a><img alt="GitHub issues" src="https://img.shields.io/github/issues-raw/yunweneric/flutter-widgethub?color=%233867D6&style=for-the-badge"></a>
<a href="" target="_blank"><img alt="GitHub Repo stars" src="https://img.shields.io/github/stars/yunweneric/flutter-widgethub?color=%233867D6&style=for-the-badge"></a>
<a><img alt="GitHub forks" src="https://img.shields.io/github/forks/yunweneric/flutter-widgethub?color=%233867D6&style=for-the-badge"></a>
<a><img alt="GitHub code size in bytes" src="https://img.shields.io/github/languages/code-size/yunweneric/flutter-widgethub?color=%233867D6&style=for-the-badge"></a>
<a href = "https://flutterwidgethub.com/"><img alt="Website" src="https://img.shields.io/website?color=%233867D6&style=for-the-badge&up_color=3F51B5&up_message=Visit%20us&url=https%3A%2F%2Fpayunit.net%2Fdocs%2F"></a>

</p>

From ready-to-use components and flexible layout blocks to smooth animations and striking effects, Flutter Widget Hub is a collection of some pretty UIS aimed at helping developers create beautiful, functional flutter apps quickly and efficiently.

### Features

- #### Templates

  A wide range of pre-built UI templates from app clones to demo apps all in one place

- #### Blocs

  A collection of reusable layout blocks to help you create consistent and responsive layouts

- #### Animations

  Smooth and captivating animations that can be easily applied to any element.

- #### Effects

  Visual effects ranging from shadows and gradients to more complex transformations

### Setup

- #### Version support

  FVM is compiled in flutter version **3.22.1**. You can use [FVM](https://fvm.app/) to manage your flutter version

- #### Running app

  You can find the **main_dev.dart** and **main_prod.dart** files in the lib/app/core folder. In the **.vscode** folder, you can find the launch config for dev and prod environment

  ### NB: Ensure you have an env.json or dev.env.json file out of your project in a folder called envs/fwh

- #### Building app with wasm support

```bash
flutter build web --wasm --target lib/app/core/main_dev.dart --dart-define-from-file=../envs/fwh/dev.env.json
```

```bash
flutter build web --wasm --target lib/app/core/main_prod.dart --dart-define-from-file=../envs/fwh/env.json
```

### Request New Component

If you will like the community to build a custom component tailored for a specific use case, you can [Request a component](https://github.com/yunweneric/flutter-widgethub/issues) that and label it accordingly.

### Contribution Guide

We welcome contributions from the community to make this SDK better! To contribute, follow these steps:

1. Fork the repository and clone it to your local machine:

```bash
$ https://github.com/yunweneric/flutter-widgethub
```

2. Create a new branch for your changes:

```bash
$ git checkout -b feature/your-feature-name
```

3. Make your changes and test them thoroughly.

4. Add tests for new features or changes, and ensure all tests pass:

```bash
$ flutter test
```

5. Commit your changes and push them to your fork:

```bash
$ git add .
$ git commit -m "Your descriptive commit message"
$ git push origin feature/your-feature-name
```

6. Create a pull request from your fork to the main repository.

### Code of Conduct

Please note that this project is governed by a Code of Conduct. We expect all contributors and users to adhere to it. The Code of Conduct can be found in the `CODE_OF_CONDUCT.md` file in this repository.

### License

This Library is released under the MIT License. You can find the license details in the `LICENSE` file.

### Support

For any questions, issues, or feature requests, feel free to create an issue in this repository or contact us at yunweneric@gmail.com.

### Acknowledgements

We would like to thank all contributors who have helped in making flutter widget hub project possible.
