//
//  TypeMO.h
//  Pokedex
//
//  Created by Abraham Abreu on 11/03/22.
//

#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface TypeMO : NSManagedObject

@property(nonatomic, assign)NSInteger idType;
@property(nonatomic, strong)NSString* name;

@end

NS_ASSUME_NONNULL_END
