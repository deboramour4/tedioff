# Tedioff
Tedioff is a simple single-view iOS app that allows you search new cool activities to do when you're super bored. The activities come from the [BoredAPI](https://www.boredapi.com/).

---

## The Repository
This repository brings together multiple versions of the same application - Tedioff - across different software architectures (usually used in iOS Development). There are four versions of the app and it can be found at different branches:
- mvc
- mvvm-closures
- mvvm-rxswift
- nubank-architecture

It's important to say that it was created with the purpose of learning. So it might be constantly updated (since I'm in continuous learning about all that). Feedbacks are always welcome 💜 Feel free to open a new **issue** if you want to tell me something.

The details of each version of the app in the description below.

### MVC Version
The Model-View-Controller version of **Tedioff** is based on [Apple's documentation](https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/Model-View-Controller/Model-View-Controller.html). Apple's version is a adaptation of the original _MVC_ created in the 1970s by Trygve Reenskaug.

To run this version of **Tedioff** you must:
1. select the branch `mvc`
1. download the ZIP file or clone the repository
1. open the *TedioffMVC.xcodeproj* file
1. run the project - *CMD + R*

### MVVM Version (with closures)
This version is inspired in Model-View-ViewModel architecture that was created in 2005 by Ken Cooper y Ted Peters, two architects of software in Microsoft. I used closures to bind data beetween _View Model_ and the _View_.

To run this version of **Tedioff** you must:
1. select the branch `mvvm-closures`
1. download the ZIP file or clone the repository
1. open the *TedioffMVVM.xcodeproj* file
1. run the project - *CMD + R*

### MVVM Version (with RxSwift)
After implementing the MVVM using Swift closures I decided to add some reactivity to the process. I used the [RxSwift framework](https://github.com/ReactiveX/RxSwift) to create the two-way data binding between the _View Model_ and the _View_.

To run this version of **Tedioff** you must:
1. select the branch `mvvm-rxswift`
1. download the ZIP file or clone the repository
1. open your console at the project's folder
1. run the command `pod install`
1. open the *TedioffMVVM-RxSwift.xcworkspace* file
1. run the project - *CMD + R*

### Nubank Architecture Version (with RxSwift)

Finally, I implemented a version of Tedioff inspired by the architecture used at [Nubank](https://nubank.com.br/). This architecture was very inspired by [The Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) from Uncle Bob, which gives the decoupling, testability and single responsibility necessary for the company. You can see more about Nubank's architecture at [this link](https://medium.com/building-nubank/ios-app-architecture-part-1-building-screens-bf8cd9a544e). This projects uses RxSwift to bind data.

To run this version of **Tedioff** you must:
1. select the branch `nubank-architecture`
1. download the ZIP file or clone the repository
1. open your console at the project's folder
1. run the command `pod install`
1. open the *TedioffNubank.xcworkspace* file
1. run the project - *CMD + R*


