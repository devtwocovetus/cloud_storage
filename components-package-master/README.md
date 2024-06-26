# Reusable Components Package

The "Reusable Components" package is a collection of customizable components for Flutter that can be easily integrated into any Flutter project. These components have been designed to save developers time and effort by providing pre-built solutions to common UI elements.

## Contents

- [Components](#components)
- [Usage](#usage)
- [Customization](#customization)
- [Testing](#testing)
- [Contributing](#contributing)
- [Getting Started](#getting-started)
- [Contact](#contact)

## Components

The following components are included in this package:

- MyCustomButton
- CustomCircularProgressIndicator
- CustomTextButton
- CustomTextFormField
- CustomDivider
- CustomIconButton
- CustomSearchTextField
- CustomHelper
- And others...

Each component is fully customizable, allowing developers to modify the appearance and behavior of the component to suit their needs. Additionally, all components are thoroughly tested to ensure reliable and consistent performance across different devices and platforms.

## Usage

To use the "Reusable Components" package in your Flutter project, follow these steps:

1. **Add the package to your `pubspec.yaml` file**:

```
dependencies:
    reusable_components:
    git:
      url: https://github.com/ahmedghaly15/Reusable-Components-Package
```

2. **Install dependencies**:

```
flutter pub get
```

3. **Import the package in your Dart code:**

```
import 'package:reusable_components/reusable_components.dart';
```

4. **Use the components in your Flutter widgets**

## Customization

Each component in the "Reusable Components" package can be customized using various properties. For example, the CustomButton component has properties for changing the text, backgroundColor, textStyle, and more:

```
CustomButton(
  text: 'Click me!',
  backgroundColor: Colors.blue,
  onPressed: () => print('CustomButton clicked!'),
)
```

## Testing

All components in the "Reusable Components" package are thoroughly tested using Flutter's built-in testing framework. Unit tests and widget tests are included to ensure reliable and consistent performance across different devices and platforms.

## Contributing

Contributions to this repository are always welcome! If you would like to contribute a new component or improve an existing one, please submit an issue or pull request with your proposed changes.

## Getting Started

This project is a collection of reusable components that make development easier.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Contact

If you have any questions or comments about this repository, please feel free to reach out to me at ahmedghaly0767@gmail.com. I'm always happy to hear from other developers and discuss ways to improve this project.
