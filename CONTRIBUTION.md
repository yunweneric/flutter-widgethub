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
  - Your component folder should have the following convention
    - `data.dart` - This should be the component you will import in the exports
    - `component_widget.dart` - Your component as a widget
    - `component_code.dart` - Your component as a string
    - `component_setup` - Setup instruction for your component.
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

3. Make your changes following the project structure as mentioned above

4. Commit your changes and push them to your fork:

```bash
$ git add .
$ git commit -m "Your descriptive commit message"
$ git push origin feature/your-feature-name
```

6. Create a pull request from your fork to the main repository.
