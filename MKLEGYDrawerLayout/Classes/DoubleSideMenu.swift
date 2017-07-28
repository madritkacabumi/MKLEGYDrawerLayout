//
//  DoubleSideMenu.swift
//  Legency
//
//  Created by Madrit Kacabumi on 20/06/2017.
//  Copyright © 2017 Madrit Kacabumi. All rights reserved.
//

import Foundation
import UIKit

public class DoubleSideMenu : UIView{
    
    
    // sizes for left and right menus, by default they are both 280 , so they will be compatible with all screen sizes
    public var leftSizeMenuWidth : CGFloat = 280;
    public var rightSizeMenuWidth : CGFloat = 280;
    
    public func setLeftMenuWidth(width : CGFloat){
        self.leftSideMenuWidthConstraint.constant = width
        self.leftSizeMenuWidth = width
    }
    
    public func setRightMenuWidth(width : CGFloat){
        self.rightSideMenuWidthConstraint.constant = width
        self.rightSizeMenuWidth = width
    }
    
    // menu checking
    
    var leftSideBarIsOpen = false;
    var rightSideBarIsOpen = false;
    
    
    var leftMenuIsEnabled = true;
    var rightMenuIsEnabled = true;
    
    // ------------------------ VIEWS ------------------------------------------------------------------------------
    // menus Constraint
    @IBOutlet weak var rightSIdeMenuConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftSideMenuConStr: NSLayoutConstraint!
    @IBOutlet var rightSideMenuWidthConstraint: NSLayoutConstraint!
    @IBOutlet var leftSideMenuWidthConstraint: NSLayoutConstraint!
    
    // containers
    
    @IBOutlet weak var MAIN_CONTAINER: UIView!
    @IBOutlet weak var rightSideMenu: UIView!
    @IBOutlet weak var leftSideMenu: UIView!
    
    
    // ------------------------ MENU DIM ------------------------------------------------------------------------------
    @IBOutlet weak var menuDim: UIButton!
    var enableDimClick : Bool = true;
    @IBAction func menuDImCLicked(_ sender: UIButton) {
        if (self.enableDimClick){
            if (leftSideBarIsOpen){
                
                closeLeftSideMenu()
                
            }else if (rightSideBarIsOpen){
                
                closeRightSideMenu()
            }
        }
    }
    
    public func setMenuDimColor(colorHexString : String?){
    self.menuDim.backgroundColor = UIColor.init(hexString: (colorHexString ?? "#000000"))
    }

    
    // ------------------------ MENUS ADD VIEWS ------------------------------------------------------------------------------
    public func setMainContentView (view : UIView, animated : Bool = false){
        attachTo(view: view, animated: animated)
    }
    
    // function to add left menu , specify the xib view to add and it will automatically add it full size using constraints
    public func addLeftMenu(view : UIView, animated: Bool = false){
        view.attachTo(view: self.leftSideMenu, animated: animated)
        
    }
    
    // function to add right menu , specify the xib view to add and it will automatically add it full size using constraints
    public func addRightMenu(view : UIView, animated: Bool = false){
        view.attachTo(view: self.rightSideMenu, animated: animated)
    }
    
    // aditional func to disable if needed any side menus
    public func disableRightMenu(){
        self.rightMenuIsEnabled = false;
    }
    
    public func disableLeftMenu(){
        self.leftMenuIsEnabled = false;
    }
    
    // func to removeLeftMenusView
    public func clearLeftMenu(){
        self.leftSideMenu.clearAllSuBViews()
        
    }
    
    // function to removeRightMenuView,
    public func clearRightMenu(){
        self.rightSideMenu.clearAllSuBViews()
    }
    
    //------------------------------MENU OPERATION (CLOSE, OPEN, etc)----------------------------------------
    public func closeAllMenus(){
        closeLeftSideMenu()
        closeRightSideMenu()
    }
    
    public func closeLeftSideMenu(){
        UIView.animate(withDuration: 0.3, animations: {
            self.menuDim.alpha = 0;
            self.leftSideMenuConStr.constant = -(self.leftSizeMenuWidth);
            self.leftSideBarIsOpen = false;
            self.layoutIfNeeded()
        })
    }
    
    public func openLeftSideMenu(){
        if (rightSideBarIsOpen){
            closeRightSideMenu()
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.menuDim.alpha = 0.4;
            self.leftSideMenuConStr.constant = 0;
            self.leftSideBarIsOpen = true;
            self.layoutIfNeeded()
        })
    }
    
    public func openRightSideMenu(){
        if (leftSideBarIsOpen){
            closeLeftSideMenu()
        }
        UIView.animate(withDuration: 0.3) {
            self.menuDim.alpha = 0.4;
            self.rightSIdeMenuConstraint.constant = 0;
            self.rightSideBarIsOpen = true;
            self.layoutIfNeeded()
        }
    }
    
    public func closeRightSideMenu(){
        UIView.animate(withDuration: 0.3) {
            self.menuDim.alpha = 0;
            self.rightSIdeMenuConstraint.constant = -(self.rightSizeMenuWidth);
            self.rightSideBarIsOpen = false;
            self.layoutIfNeeded()
        }
    }
    

    
    //------------------------------GESTURE RECOGNISER----------------------------------------
    var initialiTranslation : CGFloat = 0;
    var toMove : Int = 0;
    
    @IBAction func moveSideBar(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
            
            
        case .changed:
            if (initialiTranslation == 0){
                if (self.frame.size.width/2 >= sender.location(in: self).x){
                    initialiTranslation = self.leftSideMenuConStr.constant;
                    toMove = 1;
                }else{
                    initialiTranslation = self.rightSIdeMenuConstraint.constant;
                    toMove = -1;
                }
                // checking for opened sidebars
                
                if (leftSideBarIsOpen){
                    toMove = 1;
                    initialiTranslation = self.leftSideMenuConStr.constant;
                }else if (rightSideBarIsOpen){
                    toMove = -1;
                    initialiTranslation = self.rightSIdeMenuConstraint.constant;
                }
                
                // checking for disabled menus
                
                if (!leftMenuIsEnabled && !rightMenuIsEnabled){
                    toMove = 0;
                }else if (!leftMenuIsEnabled && rightMenuIsEnabled){
                    toMove = -1;
                }else if (leftMenuIsEnabled && !rightMenuIsEnabled){
                    toMove = 1;
                }
            }
            
            let translation = sender.translation(in: self)
            var move  : CGFloat = 0;
            if (toMove == 1){
                move = initialiTranslation + translation.x;
            }else if (toMove == -1){
                move = initialiTranslation + (-translation.x);
            }
            
            // checking for menu dim;
            var menuDim : CGFloat = -1;
            
            if (toMove == -1){
                
                menuDim = (1 - (move) / (-(self.rightSizeMenuWidth))) * 0.3;
                
            }else if (toMove == 1){
                
                menuDim = (1 - (move) / (-(self.rightSizeMenuWidth))) * 0.3;
                
            }
            
            
            if (menuDim <= 0.4 && menuDim >= 0 && toMove != 0){
                self.menuDim.alpha = menuDim;
            }
            
            if (toMove == 1){
                if (move < 0 && move > -(self.leftSizeMenuWidth)){
                    self.leftSideMenuConStr.constant = move;
                }else if (move > 0){
                    openLeftSideMenu()
                }else{
                    closeLeftSideMenu()
                }
            }else{
                if (move < 0 && move > -(self.rightSizeMenuWidth)){
                    self.rightSIdeMenuConstraint.constant = move;
                }else if (move > 0){
                    openRightSideMenu()
                }else{
                    closeRightSideMenu()
                }
                
            }
            
            break;
            
        case .ended:
            initialiTranslation = 0;
            if (toMove == 1){
                if (leftSideMenuConStr.constant > (-(self.leftSizeMenuWidth)/2)){
                    openLeftSideMenu()
                }else{
                    closeLeftSideMenu()
                }
            }else if (toMove == -1){
                if (rightSIdeMenuConstraint.constant > (-(self.rightSizeMenuWidth)/2)){
                    openRightSideMenu()
                }else{
                    closeRightSideMenu()
                }
            }
            break;
        default:
            print("break");
            break
        }
    }
}
