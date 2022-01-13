//
//  SceneDelegate.h
//  Pokedex
//
//  Created by Abraham Abreu on 01/12/21.
//

#import <UIKit/UIKit.h>
#import "PokemonListViewController.h"
#import "AppCoordinator.h"
#import "Constants.h"

@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>

@property(nonatomic, strong)AppCoordinator *appCoordinator;
@property(nonatomic, strong)UIWindow * window;

@end

