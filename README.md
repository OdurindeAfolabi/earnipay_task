# earnipay_task

A mobile development task for earnipay

## Getting Started

To run this application : 
1. Install the attached apk in the mail OR
2. Clone the attached repository link on android studio or visual studio code and run either on an ios simulator or android emulator

To run the tests:
1. Open the test directory in a terminal and run flutter test component_test.dart(to test some important components)
2. Open the test directory in a terminal and run flutter test service_test.dart(to test the app service, asynchronous code & error handling)

IMPLEMENTATION METHODOLOGY
I utilised the provider package for state management and the dio package in combination with retrofit for network requests.
I utilised the clean architecture pattern(A four layer architecture containing the application, data, domain & presentation layers) for this task,
Clean Architecture promotes a clear separation of concerns by dividing the codebase into distinct layers. This separation helps in isolating and managing different responsibilities, making the codebase easier to understand and modify. Clean architecture also improves testability, code reusability, scalability, maintainability, flexibility and so on.
I also utilised the dependecy injection mechanism which is a design pattern and technique that helps manage the dependencies of your application. It allows you to decouple your code, improve testability, and promote code reuse.
I also made use of a few responsiveness algorithms to ensure the app is responsive and does not overflow in any case or break because of unrestrictede or uncontrollable data length from network responses.

PEFORMANCE OPTIMIZATION TECHNIQUES
I utilised the following optimization processes:
1. I implemented lazy loading for images to improve initial loading speed by using the cached_network_image flutter package which allows you to load images from remote URLs and automatically handles caching, loading indicators, and error handling. It provides the necessary functionality to implement lazy loading by loading images on-demand as they become visible within the viewport. I used it in combination with a gridview.builder widget which efficiently builds a scrollable list of items by lazily instantiating and disposing of widgets as they come into and out of view.
2. I used a caching mechanism to reduce network requests and improve offline experience. I implemented a caching algorithm that stores a finite amount of photos in local storage and expires after some minutes, this helps facilitate offline experience and reduce network requests.
3. I also optimized widget rendering by utilising consts and stateless widgets where necessary hence, widgets that don't depend on dynamic data can be rendered as a compile-time constant, reducing the need for unnecessary rebuilds.

# earnipay_task
