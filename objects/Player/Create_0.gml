life = 10;
pSpeed = 3;
lerpSpeed = 0.5;
xySpeed = [0, 0];
pWidth = sprite_width;
pHeight = sprite_height;

upKey = "W";
downKey = "S";
leftKey = "A";
rightKey = "D";

dir = [0, 0];

colliders = [Enemy, Core, Wall];

gunSpawned = false;

function setDir(){
    dir[0] = (keyboard_check(ord(rightKey)) - keyboard_check(ord(leftKey)));
    dir[1] = (keyboard_check(ord(downKey)) - keyboard_check(ord(upKey)));
}

function teleport() {
    halfWidth = pWidth / 2;
    halfHeight = pHeight / 2;

    if (x - halfWidth + xySpeed[0] < 0) {
        x = room_width - pWidth;
    }
    if (x + halfWidth + xySpeed[0] > room_width) {
        x = pWidth;
    }
    if (y - halfHeight + xySpeed[1] < 0) {
        y = room_height - pHeight;
    }
    if (y + halfHeight + xySpeed[1] > room_height) {
        y = pHeight;
    }
}

function move(){
    setDir();
    xySpeed = speedNormalized(dir, pSpeed);
    teleport();
    x = moveX(x, y, xySpeed[0], dir[0], colliders);
    y = moveY(x, y, xySpeed[1], dir[1], colliders);
}

function spawnGun(){
    if(global.isAbleToCombat && !gunSpawned){
        gunSpawned = true;
        instance_create_layer(Player.x, Player.y, "Instances", Gun);
    }else{
        if(!global.isAbleToCombat && gunSpawned){
            gunSpawned = false;
            instance_destroy(Gun);
        }
    }
}