<p align="center">
  <a href="https://flutterwidgethub.com/" target="blank"><img src="https://raw.githubusercontent.com/yunweneric/flutter-widgethub/main/assets/images/fwh.png"  alt="Flutter widget landing page" /></a>
</p>

### Contribution Guide

We welcome contributions from the community to make this Library better!

## Project Structure:

This project has been divided into 2 sections `lib/app` and `lib/components`

- `lib/app` includes all the source code of FWH components and UIs. If there is a bug fix or improvement to the library, this is where you will mostly find yourself.

- `lib/components` contains all the components that individuals have contributed to the library. If you are looking to add a component, this is where you will do that.
  - This section is divided into the major sections depending on what you are building, you will have to add your code to either
    - `presentation/animations`
    - `presentation/blocks`
    - `presentation/effects`
    - `presentation/templates`
  - In these folders, you can add your code as a folder named with the title of the component in `snake case`.
  - Finally, head to `presentation/export/store.dart` and add your component in the list. Restart the app and your component will automatically appear in the app.

To contribute, follow these steps:

1. Fork the repository and clone it to your local machine:

```bash
$ https://github.com/yunweneric/flutter-widgethub
```

2. Create a new branch for your changes:

```bash
$ git checkout -b feature/your-feature-name
```

3. Make your changes

- Navigate to

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
