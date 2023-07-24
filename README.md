# ActivityRadar

A mobile app for finding public sports facilities in your neighborhood

## Setup

The first point of setup is installing `flutter`. For that, consult the
[official guide](https://docs.flutter.dev/get-started/install/) for your OS.

Make sure, that everything is well installed with `flutter doctor`.

The currently required Dart sdk version is `>=3.1.0-129.0.dev <4.0.0`.
Check your current sdk version with `dart --version`. If it is too low, it might
be necessary to switch to a different release channel of flutter:

```
flutter channel beta
flutter upgrade
```

After making sure, everything is set up correctly, install the project
dependencies by running.

```
flutter pub get
```

## Run

Connect your device or start an emulator and run:

```
flutter run
```

## Deployment

We are using AWS S3 as image storage. Look into [our AWS setup](docs/aws.md) for more information on that.

## Development

We use `pre-commit` with `ggshield` as commit checker. To set up this, install `pre-commit`,
for example via `pip install pre-commit`. Then, run `pre-commit install` to set up the commit
hooks in the `.pre-commit-config.yaml` config.
As we are using `ggshield` to prevent secret leaks, create a `.env` file in the project root.
Create a `GitGuardian` account and an API key. Paste that key in the `.env` file like shown in
the `.env.example`.
Upon creating a new commit, the hooks should run and tell you if something went wrong.
