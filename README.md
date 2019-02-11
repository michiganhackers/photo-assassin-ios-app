# Photo Assassin iOS App

This repository contains code written by the Michigan Hacker's Core iOS team during the Winter of 2019. Supports: iOS 10.x and above

## Branches:

* master - stable app releases
* develop - development branch, merge your feature branches here

## Getting Started:

#### Integrated Development Environment (IDE)
Install Xcode, the official IDE for iOS development. An IDE makes developing the application faster and easier.  
[Download](https://developer.apple.com/xcode/)

#### Git
Install git, the software our team uses for version control.  
[Download](https://git-scm.com/downloads)

#### Github Account
Create a Github account to interact with the remote repository.  
[Join](https://github.com/join)

## Dependencies:

The project is using cocoapods for managing external libraries and a Gemfile for managing the cocoapods version.

Get Bundler

```
sudo gem install bundler
```

To install the specific cocoapods version run

```
bundle install
```

Then install the pods

```
bundle exec pod install
```

### Core Dependencies

* Swiftlint - A tool to enforce Swift style and conventions.
* R.swift - Get strong typed, autocompleted resources like images, fonts and segues in Swift projects

## Project structure:

* Resources - fonts, strings, images, generated files etc.
* SupportingFiles - configuration plist files
* Models - model objects
* Modules - contains app modules (UI + Code)
* Helpers - protocols, extension and utility classes

## Contributing
We use the [GitHub Flow workflow](https://guides.github.com/introduction/flow/).  
We also use [GitHub's project boards](https://github.com/michiganhackers/photo-assassin-ios-app/projects/2) to manage this project.
If you are looking for resources to learn iOS or Swift, visit the [Michigan Hackers knowledge base](https://github.com/michiganhackers/knowledgebase/blob/master/Technologies/iOS.md).


## Contains (best practices)

* [Swiftlint](https://github.com/realm/SwiftLint) integration - A tool to enforce Swift style and conventions
* [R.swift](https://github.com/mac-cain13/R.swift) integration - strong typed, autocompleted resources like images, fonts and segues
* [Separate AppDelegate for app and tests](https://marcosantadev.com/fake-appdelegate-unit-testing-swift/)
* Dev/Staging/Prod configurations
* [Compiler performance profiling flags](https://www.jessesquires.com/blog/measuring-compile-times-xcode9/)
* [Cocoapods integration](https://cocoapods.org)
* [Gemfile for managing Cocoapods version](https://guides.cocoapods.org/using/a-gemfile.html)
* Standard Readme
* Standard project structure
* [Standard gitignore](https://github.com/github/gitignore/blob/master/Swift.gitignore)
* Base classes for handling deeplinks and notifications


## Additional configuration

You will have to manually configure the bundle id of the main target and test target.
