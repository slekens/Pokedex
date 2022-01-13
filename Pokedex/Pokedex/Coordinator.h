//
//  Coordinator.h
//  Pokedex
//
//  Created by Abraham Abreu on 12/01/22.
//

#import <Foundation/Foundation.h>
#import <UIkit/UIKit.h>

#ifndef Coordinator_h
#define Coordinator_h

@protocol Coordinator <NSObject>

@required
-(UIViewController*)start;

@end

#endif /* Coordinator_h */
