---
title: Swift中associatedtype
date: 2021-01-26 11:35:11
tags: Swift
categories: Swift
description:
---
```
// associatedtype定义关联类型，相当于类型的占位符，让实现协议的类型来指定具体的类型

protocol Food {
    
}

protocol Animal {
    associatedtype F: Food
    func eat(_ food: F)
}

struct Meat: Food {
    
}

struct Grass: Food {
    
}

struct Tiger: Animal {
    func eat(_ food: Meat) {
        print("eat \(food)")
    }
}

struct Sheep: Animal {
    func eat(_ food: Grass) {
        print("eat \(food)")
    }
}

func test() {
    let tiger = Tiger()
    tiger.eat(Meat())

    let sheep = Sheep()
    sheep.eat(Grass())
}

/*

Protocol 'Animal' can only be used as a generic constraint because it has Self or associated type requirements
只能被用作泛型约束，不能当做独立的类型使用
 
错误代码：
func isTiger(animal: Animal) -> Bool {

}
*/

// 具有关联类型的协议类型，只能当做泛型约束使用
func isTiger<A: Animal>(animal: A) -> Bool {
    if animal is Tiger {
        return true
    } else {
        return false
    }
}

```