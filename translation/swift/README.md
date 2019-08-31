# Cloud Translation gRPC Swift Sample

This app demonstrates how to make gRPC connections to the [Cloud Translation API](https://cloud.google.com/translate) to get the translated text.

To call the APIs from iOS, you need to provide authorization tokens with each request for authentication. To get this token, this sample uses a Firebase Function (in Node.js) to generate these tokens on the behalf of a service account.

## Prerequisites

- An OSX machine or emulator
- [Xcode 10][xcode] or higher
- [Cocoapods][cocoapods] 

## Setup

- Create a project (or use an existing one) in the [Google Cloud Console][cloud-console]
- [Enable billing][billing] and the
- [Translate API](https://console.cloud.google.com/apis/library/translate.googleapis.com)
- [IAM Service Account Credentials API](https://console.cloud.google.com/apis/library/iamcredentials.googleapis.com).
- [Create a Service account](https://cloud.google.com/iam/docs/creating-managing-service-accounts) with the following IAM role: `Cloud Translation API Editor`. Example name: `translate-client`. ([For more info on: how to add roles to a Service Account](https://cloud.google.com/iam/docs/granting-roles-to-service-accounts#granting_access_to_a_service_account_for_a_resource))

###  Setup the app
- Clone this repository `git clone https://github.com/GoogleCloudPlatform/ios-docs-samples.git` 
- `cd ios-docs-samples/translation/` 
- Run `./INSTALL-COCOAPODS` to install app dependencies (this can take few minutes to run). When it finishes, it will open the SpeechtoSpeech workspace in Xcode. Since we are using Cocoapods, be sure to open the `Translation.xcworkspace` and not `Translation.xcodeproj`.
- In Xcode's Project Navigator, open the `ApplicationConstants.swift` file within the `Translation` directory.
- Find the line where the `projectID` is set. Replace the `your-project-identifier` string with the identifier for your Google Cloud Project.
- Go to the project editor for your target and then click on the Capabilities tab. Look for Push Notifications and toggle its value to ON

###  Setup Firebase on the application:

- Complete the steps for [Add Firebase to your app](https://firebase.google.com/docs/ios/setup#add_firebase_to_your_app) and expand the "Create a Firebase project" section for instructions on how to add project to your Firebase console. Note: No need to complete any other sections, they are already done. 
- Complete the steps to [Configuring APNs with FCM](https://firebase.google.com/docs/cloud-messaging/ios/certs).
- Use `iOS bundle ID` which has push notifications enabled and select your development team in 'General->Signing' before building the application in an iOS device.
Note: as we were going to get the token in notifications, Please run the sample in iOS device instead of running it in the simulator. 
- In the [Firebase console][Firebase], open the "Authentication" section under Develop.
- On the **Sign-in Methods** page, enable the **Anonymous** sign-in method.

###  Setup and Deploy the Firebase Function 
The Firebase Function provides auth tokens to your app, You'll be using a provided sample function to be run with this app.

- Follow the steps in this [guide](https://firebase.google.com/docs/functions/get-started) for: 
- "1. Set up Node.js and the Firebase CLI"
- "2. Initialize Firebase SDK for Cloud Functions". 
- Replace `index.js` file with the [provided index.js](https://github.com/GoogleCloudPlatform/nodejs-docs-samples/blob/master/functions/tokenservice/functions/index.js).
- Open `index.js`, go to function "generateAccessToken", and replace “SERVICE-ACCOUNT-NAME@YOUR_PROJECT_ID.iam.gserviceaccount.com” with your Service account name (`dialogflow-client`) and project id. 
- Deploy getOAuthToken method by running command:
```
firebase deploy -—only functions
```
- For your "App Engine Default Service Account" add the following IAM role: `Service Account Token Creator` . ([For more info on: how to add roles to a Service Account](https://cloud.google.com/iam/docs/granting-roles-to-service-accounts#granting_access_to_a_service_account_for_a_resource))

- For more info please refer (https://firebase.google.com/docs/functions/get-started).

## Run the app

- You are now ready to build and run the project. In Xcode you can do this by clicking the 'Play' button in the top left. This will launch the app on the simulator or on the device you've selected. Be sure that the 'Translation' target is selected in the popup near the top left of the Xcode window. 


[cloud-console]: https://console.cloud.google.com
[git]: https://git-scm.com/
[xcode]: https://developer.apple.com/xcode/
[billing]: https://console.cloud.google.com/billing?project=_
[cocoapods]: https://cocoapods.org/
[Firebase]: https://console.firebase.google.com/

