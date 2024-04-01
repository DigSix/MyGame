colliders = [Enemy, Player, Core];
image_alpha = 0;

function place(){
    if(!checkInst(x, y, colliders, self)) image_alpha = 1;

}