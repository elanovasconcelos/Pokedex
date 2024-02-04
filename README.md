- Using MVVM-C
- The view model doesn't know about the coordinator. It uses a closure to say that some action is required.
- Using Factory to help create the screens 
- Using dependency injection to be easy to test
- The structs decoded from the JSON are transformed to the model. So the network layer could be isolated
- Added examples of unit tests, snapshot tests and UI tests 
- Using a Repository to handle the creation of Pokemon model and webhook call.
- The favorite functionality is only saved in memory, but it's calling the webhook too.

- webhook: https://webhook.site/#!/a49767a1-5da9-4783-82a2-624951394afe/08de17bf-6594-44c3-af29-326511d7827b/1
