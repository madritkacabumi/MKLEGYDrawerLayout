# MKLEGYDrawerLayout

[![CI Status](http://img.shields.io/travis/devMadrit/MKLEGYDrawerLayout.svg?style=flat)](https://travis-ci.org/devMadrit/MKLEGYDrawerLayout)
[![Version](https://img.shields.io/cocoapods/v/MKLEGYDrawerLayout.svg?style=flat)](http://cocoapods.org/pods/MKLEGYDrawerLayout)
[![License](https://img.shields.io/cocoapods/l/MKLEGYDrawerLayout.svg?style=flat)](http://cocoapods.org/pods/MKLEGYDrawerLayout)
[![Platform](https://img.shields.io/cocoapods/p/MKLEGYDrawerLayout.svg?style=flat)](http://cocoapods.org/pods/MKLEGYDrawerLayout)

## MKLEGYDrawerLayout

A Double side menu for iOS like android DrawerLayout , simple to use and customisable . Just download it and it is ready to use 
everything is built using panGesture recogniser;

!["Click to see image"](https://user-images.githubusercontent.com/30524631/28723648-a9a6998e-73b7-11e7-9742-6258a0e08468.gif)

## Features

- [x] Double side menu (left and right)
- [x] Enable or disable one of menus (or both)
- [x] add content (both menus) with just one line of code (constraints auto added)
- [x] change size , colors , dim colors etc
- [x] Movements offset
## Requirements
1
## Installation

MKLEGYDrawerLayout is available through [CocoaPods](https://cocoapods.org/pods/MKLEGYDrawerLayout). To install
it, simply add the following line to your Podfile:

```ruby
pod "MKLEGYDrawerLayout"
```
## Usagge :
1. import library
`import MKLEGYDrawerLayout`
2.Declare variable (better optional)
`var sideMenu : DoubleSideMenu?`
 // by default menus are both enabled

3.You need to create this as a view (steps for doing it in viewdidLoad)
  1. declare bundle 
  `let bundle = Bundle(identifier: "org.cocoapods.MKLEGYDrawerLayout")`
  2. create view 
  ``
  sideMenu = UIView.createView(attachTo: self.view, fromBundle: bundle) 
  // self.view for all the view controller container or into another view 
  ``
  3. add view into it now (create a xib or a view controller in the story board add it into the main container or side menus ( they are just views)
  ```
     I   sideMenu.setMainContentView (view : UIView, animated : Bool = false)
     //no need to add constraints , they are automatically added
     II   sideMenu.addLeftMenu(view : UIView, animated: Bool = false) 
     III    sideMenu.addRightMenu(view : UIView, animated: Bool = false)
  ```
  4. ENJOY !

## Customisation :

1. width by default is 280 , but you can change it for both of them
  `sideMenu?.setLeftMenuWidth(width : CGFloat)`
  `sideMenu?.setRightMenuWidth(width : CGFloat)`
  // do not use negative values as the will go back to default : 280

 2. every time you open one of menus lets suppose the left one , the Main Cointainer will have a black color with alpha 0.3 (Dim), to change the color simply 
   `sideMenu?.setMenuDimColor(colorHexString : "#BBBBBB")`

 3. if you need to disable any menu and leave only one simply  
 ```
    sideMenu?.disableRightMenu()
    //  OR  
     sideMenu?.disableLeftMenu()
    //  OR  both of them :D
 ```

 4. if during app running you need to change content then 
 ```
    sideMenu?.clearLeftMenu()
     //OR  

     sideMenu?. clearRightMenu() 
     //OR 
     // both of them :D   and anything else again
     ```

 5. if you need to open or close programatically menus then 
 ```
    sideMenu?.closeAllMenus()
    sideMenu?.closeRightSideMenu()
    sideMenu?.closeLeftSideMenu()

    -- to open them --
    sideMenu?.openLeftSideMenu()
    sideMenu?.openRightSideMenu()

    ```

  6. additional data only for check , NOTE : use only for  direct check NOT changing !!
  ```
     sideMenu?.leftSideBarIsOpen : Bool
     sideMenu?.rightSideBarIsOpen : Bool

     sideMenu?.leftMenuIsEnabled : Bool
     sideMenu?.rightMenuIsEnabled : Bool
     ```

## Author

Madrit Kacabumi (Mobile Developer), dev.madrit.kacabumi@gmail.com or madrit.kacabumi@gmail.com

## License

MKLEGYDrawerLayout is available under the GPL license , free for everyone to use  :) 
