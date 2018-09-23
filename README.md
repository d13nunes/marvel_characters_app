# Marvel Characters App

Small application that displayes all the marvel characters and shows some details of them

# Before running the project


Open  **Environment.swift** file (or compile the project and open the error), uncomment the code bellow and define the public and private key for the Marvel API access

``` swift

//    static let current = Environment(baseURL: "https://gateway.marvel.com",
//                                     privateKey: "----PRIVATE-KEY----",
//                                     publicKey: "----PUBLIC-KEY----")

```

# Architecture Used

The chosen architecture for this project as ***MVVM***.

The application is divided in 4 main layers:

 - UI Layer
- ViewModels Layer
- Business Layer
- WebServices Layer

## UI Layer
Is responsible for the UI of the application 

## ViewModels Layer
It is an bridging layer between  *UI Layer* and the *Business Layer* providing and representation of the View and translation user interaction to the *Business Layer*  

## Business Layer
All the logic that is needed in order to run the application

## WebServices Layer
Does the comunication with the external world (e.g. Marvel API)



