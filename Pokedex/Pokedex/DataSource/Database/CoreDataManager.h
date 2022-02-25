//
//  CoreDataManager.h
//  Pokedex
//
//  Created by Abraham Abreu on 01/02/22.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Constants.h"
#import "PokemonDisplay.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataManager : NSObject

-(void)createNewEntryWith:(PokemonDisplay*)pokemon;

@end

NS_ASSUME_NONNULL_END
