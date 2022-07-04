# KeyChainManager

A simple, lightweight wrapper written in swift for performing basic keychain queries and operations for Generic Password Class.

## Usage

The Keychain manager requires a queryable object for querying the keychain. You can create a queryable object by providing service name and access group.

To share keychain items between your applications, you may specify an access group and use that same access group in each application.

``` swift
let uniqueServiceName = "customServiceName"
let uniqueAccessGroup = "sharedAccessGroupName"
let customKeychainObject = GenericPasswordQueryable(service: uniqueServiceName, accessGroup: uniqueAccessGroup)
```
This custom object can be passed while creating the keychain manager object.

``` swift
let keychainManager = KeychainManager(queryObject: customKeychainObject)
```

For writing data into keychain, you can use the setValue(_ : , for:) method. This method returns a Bool based on the success/failure of the operation

``` swift
let userEmail = "example@abc.com"
let password = "samplePassword@123"
let isPasswordSet = keychainManager.setValue(password, for: userEmail)
```

For getting data from keychain, you can use value(for:) method which returns the value (of type Any) for the supplied key or nil

``` swift
let userEmail = keychainManager.value(for: kSecAttrAccount as String) as? String
let password = keychainManager.value(for: kSecValueData as String) as? String
```

**The data is retrieved from keychain only once during the initialisation of KeychainManager object and the local values gets updated whenever the values are updated in the keychain. All the value(for:) calls gets the data from local and the keychain is not queried everytime. This improves the round trip time for a value retrieval from the keychain.**

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install KeychainManager by adding it to your `Podfile`:

``` ruby
use_frameworks!
platform :ios, '9.0'

target 'target_name' do
   pod 'KeychainManager', :git => 'https://github.com/swaminathan103/KeychainManager.git'
end
```

To use the keychain wrapper in your app, import KeychainManager into the file(s) where you want to use it.

``` swift
import KeychainManager
```


#### Manually
Download and drop ```GenericPasswordQueryable.swift```, ```KeyChainQueryable.swift```,   ```KeychainManager.swift.swift``` into your project.

Based on the tutorial -
https://www.raywenderlich.com/9240-keychain-services-api-tutorial-for-passwords-in-swift
