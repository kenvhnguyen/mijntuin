# mijn_tuin

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Enable web:
$ flutter channel master (stable channel doesn't have web so have to switch to master!)
$ flutter upgrade (to install latest version from master channel)
$ flutter config --enable-web (this will create a device called chrome, run flutter devices to see it)
$ cd <into project directory>
$ flutter create . (this to add web support for current project)
$ flutter run -d chrome

Might not work for project with lots of dependency which are not available for web
e.g:
You have a dependency on `path_provider` which is not supported for flutter_web tech preview. See https://flutter.dev/web for more details.
