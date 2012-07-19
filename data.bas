'// id, roomId, isVisible
'// description
'// pointer to action handler
data "room.boat", 0, 1
data "Your Canoe"
data "You are in your boat on the shore. It is past midnight and there is no moon in the sky, just clouds."
data "There is nothing to explore here. You are just sitting in your boat, ready to move on with the mission."
data "scenery"
data @dummyHandler

data "bread", 0, 1
data "bread"
data "A slice of bread is by your side."
data "Looks yummy."
data "item"
data @breadHandler

data "lantern", 0, 1
data "lantern"
data "A lantern is lit and sitting next to your feet."
data "It works well."
data "item"
data @dummyHandler

data "grapling hook", 0, 1
data "grapling hook"
data "Your grapling hook is at the back of the boat."
data "Very fine craftsmanship."
data "item"
data @hookHandler

data "crossbow", 0, 1
data "crossbow"
data "Your crossbow is within reach."
data "It only has one arrow. Use it wisely."
data "item"
data @crossbowHandler

data "room.beach", 1, 1
data "The Beach"
data "You are on the cool sand of the beach."
data "You explore the area. There are a couple palm trees and some large rocks. You can see ascending cliffs in the distance northward."
data "scenery"
data @dummyHandler

data "cliff", 1, 1
data "cliff"
data "A steep, rising cliff is to the north."
data "The cliff is about three stories tall and rocky."
data "item"
data @cliffHandler

data "cliff-climbable", 1, 0
data "cliff"
data "A steep, rising cliff is to the north."
data "The cliff is about three stories tall and rocky."
data "item"
data @cliffClimbableHandler

data "cliff-passable", 1, 0
data "cliff"
data "You are atop the north cliff of the beach."
data "The cliff is about three stories tall and rocky."
data "item"
data @cliffPassableHandler

data "room.forrest", 2, 1
data "The Forest"
data "You find yourself surrounded by palm trees. You can hear the canopy gently rustle with the calm wind."
data "As dark as it is, the engulfing forest hides your surroundings. It is difficult to navigate. You can't see much, but you can here some crackling embers in the distance to the east."
data "scenery"
data @dummyHandler

data "room.river", 3, 1
data "The River"
data ""
data "The river gives off a misty glow. You can feel the chill of the cold water rush by."
data "scenery"
data @riverHandler

data "river", 3, 1
data "river"
data "There is a wide river running north to south. It poors off the southern cliff onto the beach below."
data "It is flowly swiftly. It looks very dangerous."
data "item"
data @riverHandler

data "room.campfire", 4, 1
data "Camp Ground"
data "You come to an opening. You can see footprints and other signs of people, but no one else is here at the moment but yourself."
data "You walk around the camp ground. There are some rugged blankets and pots and pans. Whoever was here might be back very soon."
data "scenery"
data @dummyHandler

data "campfire", 4, 1
data "campfire"
data "A lit campfire is at the center."
data "The whole area is lit by the fire. Anything beyond the first couple of surrounding trees is pitch black."
data "item"
data @dummyHandler

data "campfire-out", 4, 0
data "campfire"
data "The campfire, now a smoldering stack of wood, is at the center."
data "The fire is out for good. The open area is now as dark as could be."
data "item"
data @dummyHandler

data "bucket-empty", 4, 1
data "bucket"
data "There is an empty wooden bucket."
data "It's a good bucket, large enough to hold about a gallon of water. There is nothing inside."
data "item"
data @emptyBucketHandler

data "bucket-full", 4, 0
data "bucket"
data "There is a wooden bucket filled to the brim with water."
data "Besides the bucket being a little heavy from the water, there's not much to notice."
data "item"
data @fullBucketHandler

data "silver key", 4, 0
data "key"
data "A silver key glimmers from the ground."
data "It looks like real silver. This might be worth something."
data "item"
data @dummyHandler

data "shiny object", 4, 0
data "shiny object"
data "There is a shiny object amongst the smoldering embers."
data "Not sure what it is. You'll have to pick it up to get a closer look."
data "item"
data @shinyObjectHandler

data "room.lighthouse-entrance", 5, 1
data "Lighthouse Entrance"
data "You are standing infront of the lighthouse. It is made of stone masonry that rises far beyond the trees."
data "The lighthouse stands surrounded by trees. There is a lightly-traveled trail that leaves the front door and heads back south."
data "scenery"
data @dummyHandler

data "wooden-door-locked", 5, 1
data "door"
data "A wooden door grants entrance to the tower."
data "It is a square door rounded at the top."
data "item"
data @woodenDoorLockedHandler

data "wooden-door-unlocked", 5, 0
data "door"
data "A wooden door grants entrance to the tower."
data "It is a square door rounded at the top."
data "item"
data @woodenDoorUnlockedHandler

data "wooden-door-open", 5, 0
data "door"
data "The wooden door is open."
data "It is a square door rounded at the top."
data "item"
data @woodenDoorOpenHandler

data "room.lighthouse", 6, 1
data "The Lighthouse"
data "You are at the floor of the lighthouse."
data "You walk around the black and white checkered floor. A couple of pictures hang from the stone wall that circles the room."
data "scenery"
data @dummyHandler

data "spiral-staircase", 6, 1
data "staircase"
data "A staircase sprials up to the top floor."
data "The staircase is made out of old, warped wood."
data "item"
data @staircaseHandler

data "room.lantern-room", 6, 0
data "Lantern Room"
data "You are on the top floor of the light house. The light sits at the center of the room and casts its bright beam out towards the sea."
data "A large front-window lets the let escape out to the sea. There is nothing too interesting in here."
data "scenery"
data @dummyHandler

data "spiral-staircase-downward", 6, 0
data "staircase"
data "A staircase sprials leads to the floor below."
data "The staircase is made out of old, warped wood."
data "item"
data @staircaseDownwardHandler

data "man-in-cloak", 6, 0
data "man"
data "There is a man in a cloak standing in the beam of the latern. He is facing you."
data "He is waiting. He is watching."
data "item"
data @dummyHandler

data "stop"

data "......"
data "..6..."
data "..5..."
data ".324.."
data "..1..."
data "..0..."
