# FlickrAPI
Present the list of 20 images from search keyword using Flickr API

## Requrements
iOS >= 8.0

## Libraries & Frameworks:
*SDWebImage* : used for image caching

*SVProgressHUD* : used for 'Loading' progress bars

*AFNetworking* : to request the Flickr APIs

*Realm* : to store the latest search keyword

### [Data & Models]
*GlobalVars* : store global variables using singleton pattern

*JK_FlickrPhoto* : data model for each photo's information

*JK_FlickrData* : Realm object to store the latest search keyword

### [View]
*ViewController* : Root view which handle other subviews

*HudViewController* : Hud View handler (About / Search Keyword / Search Textfield...)

*JK_CollectionViewController* : Customized UICollectionViewController

*JK_CollectionViewCell* : Customized UICollectionViewCell

*FullscreenViewController* : Fullscreen Image handler & Blur backgrounds

*AboutViewController* : About page [Left side of the root view] frame & animation handler

### [Controllers]
*JK_PendingOperations* : Image download operation - pending handler

*JK_FlickrImageDownloader* : Image download operation handler
