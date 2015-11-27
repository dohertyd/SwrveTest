The App SwrveTest has two ViewControllers , one to handle the Image Url entry and Download button.
the second displays the downloaded image.

The app is a universal App for Iphone and IPad both in Portrait and Landscape

I have tested the App on a real IPhone 6 and simulators for Iphone 5,6,6+ and IPads.

I have added a simple Layer animation to the download button in the form of a red moving circle.

The background Image downloading is handled via the AFNetworking UIImage category which is handled
in the Comms class.


The image URL is persisted via the Globals singelton class and NSUserDefaults


The unit tests cover the Global data store and the Comms classes 




Given more time:

I wanted to put the first view controller in a scrollview to handle the keyboard hide/show better
The code is partially implmented

I would have added some UITests
