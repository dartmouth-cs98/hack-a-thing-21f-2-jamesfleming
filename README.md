# Hack Technology / Project Attempted


## What you built? 

I build a very basic AR app that allows you to place 3d models into the world.

I did it in Swift us RealityKit and ARKit 

Videos:
[Shoe on horizontal plane works, clock on vertical fails](https://drive.google.com/file/d/1pdD7nnzvwjiHxxt4u3xRQZv20kBcIwpV/view?usp=sharing)
[Clock on vertical works, shoes on horizontal then fails](https://drive.google.com/file/d/1PsOp5BbrqzKwV9TV895ocBZhxes7EqqH/view?usp=sharing)

## Who Did What?
Solo project

## What you learned
I had never used swift before so I spent some time reading basic syntax tutorials. I found the way they deal with "null safety" very interesting. I had never seen variables that need to be "unwrapped".


At first I tried one tutorial but it was not nearly descriptive enough and started from what seemed like an already complex demo that not knowing swift and never doing AR on iphone I couldn't follow very well.

So then I found another tutorial that started from scratch and I found much more useful showing how one sets up an AR environment in the first place.
I enjoyed follow the tutorial and adding little extra things such as allowing the user to scale objects placed and then I tried adding support for placing a different object on a vertical plane. This did not work so well. When I placed a shoe on the horizontal plane and then tried to place a clock on a vertical plane it just placed a shoe but gave it a clock texture (which is super weird). Likewise if I placed a clock on a vertical face first it worked fine, but then if I placed a shoe on a horizontal plane after that it would be a clock with a shoe texture!! I tried to figure out why this might happen but none of the code I wrote even reference the textures of the object so I have no idea why the textures could ever dissociate from their geometry... 


Overall it was cool how quickly Swift ArKit and reality kit lets you get an AR experience running. As more and more people are able to scan virtual items these apps will become even more useful. 

However with my iphone 7 i noticed that adding pretty low poly models caused the app to pause for a little bit (Models can be loaded synchronously to fix this) and that it took a decent amount of moving the camera around for the algorithms to find vertical or horizontal planes. I assume on the brand new phones this all works much more smoothly and looks a lot better.

I would love to do more work with AR Swift development. I think a really cool project would involve multi user AR experiences. 


## Acknowledgments

The tutorial I was successful in following: https://www.youtube.com/watch?v=8l3J9lwaecY

The tutorial I failed to follow because it didn't mention like half the code that needed to be written https://www.toptal.com/swift/ios-arkit-tutorial-drawing-in-air-with-fingers

Swift Syntax that I tried to learn https://www.tutorialspoint.com/swift/swift_arrays.htm 




