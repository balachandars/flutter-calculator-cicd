# flutter_calculator

Flutter calculator app with GitHub Actions CI/CD and committed dev/prod runtime
configuration.

## Local environments

Run the development build:

```bash
flutter run --target lib/main_dev.dart --dart-define-from-file=env/dev.json
```

Run the production build:

```bash
flutter run --target lib/main_prod.dart --dart-define-from-file=env/prod.json
```

The environment files live in `env/dev.json` and `env/prod.json`. Update the
`API_BASE_URL` values to match your real backend endpoints.

## CI pipeline

GitHub Actions CI runs on pull requests and on pushes to `main`, `develop`, and
`feature/**` branches. It performs:

- `flutter pub get`
- `flutter analyze`
- `flutter test`

## CD pipeline

GitHub Actions CD builds release Android APK artifacts for two targets:

- `develop` branch deploys the `dev` environment using `lib/main_dev.dart`
- `main` branch deploys the `prod` environment using `lib/main_prod.dart`

You can also trigger either deployment manually from the Actions tab with the
`workflow_dispatch` input.

Each deployment uploads an APK artifact to the workflow run.

## GitHub environment setup

Create GitHub Environments named `dev` and `prod` in your repository settings.
Use those environments if you want approval rules, branch restrictions, or
future secrets such as Android signing credentials.

The current Android release build uses the existing debug signing fallback from
the Gradle config. That is enough to validate the pipeline immediately. For app
store distribution, replace it with a real signing config and store the related
secrets in the matching GitHub environment.
