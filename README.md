# DoggoApp

This app fetches dog breeds from https://dog.ceo/dog-api/documentation/ and displays them using a TableView. It uses an **MVP** pattern and focuses on TDD. User is able to browse a list of breeds and see them in more detail by selecting them. Inside the detail section they are also able to see images as well as the ability to favorite a breed. 

The project was developed using a test drive development approach. It mocks out the network, persistence and UI by conserving business logic inside the presenters and modules. This allows for faster testing and can drastically improve build times during CI pipelines. 

The MVP pattern was chosen mainly due to the app's simplicity while focusing on a 'hexagonal architecture' approach. Presenters do most of the heavy lifting for the views and a DogInformationService for modularity. This means that presenters arnt actually doing any of the fetching and the views are kept "passive". 
This type of decoupling also makes it easier to change the fetching behavior i.e replacing the service object with a Kotlin service module. This allows to simplify the presenter so that it follows the single responsibility principle as best as it can.

Although MVP was chosen for speed purposes, as with any design pattern there are drawbacks with this one too. The main one with MVP as well as the viper pattern is the one-to-one mapping with the view and presenter. MVVM overcomes this as you are able to have multiple view models being used on a single view. 

The network client is set so that a JSON can be passed in through converting it in to a data object. This allows for a mock network object to be passed in with some sample data which  tests the coding and decoding behavior. Another advantage this has is that it allows wide range unit tests. These can be extremely beneficial especially when you have a lot of test doubles and controllable doubles already set up as it reduces time to set up unit tests. 

Some future improvements could be made to the app itself such as: 
- Un-favouriting on the favorites screen **(currently this is only possible on the details screen)**
- Callbacks don’t take take in to consideration edge error cases 
- Handling of loading 
- offline mode using core data
- Extracting colors in to asset colors for easier rebranding updates
- Strings in to separate files for applying translations easily 
