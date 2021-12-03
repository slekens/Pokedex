//
//  Pokemon.h
//  Pokedex
//
//  Created by Abraham Abreu on 03/12/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *url;

-(instancetype)initWithName:(NSString*)name andURL:(NSString*)url;

@end

NS_ASSUME_NONNULL_END
