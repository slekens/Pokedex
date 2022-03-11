//
//  PokemonTypes.h
//  Pokedex
//
//  Created by Abraham Abreu on 09/03/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PokemonTypes : NSObject

@property(nonatomic, copy)NSString *name;

-(instancetype)initWithName:(NSString*)name;

@end

NS_ASSUME_NONNULL_END
