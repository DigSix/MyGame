bSpeed = 5;

xySpeed = [0, 0];
dir = [0, 0];
dirSeted = false;

possiblesShooters = [Gun];
ShootedBy = noone;
colliders = [Enemy, Wall, Core];
possiblesEnemies = [Enemy];
GiveDamageAt = noone;

function checkShooters(){
    for(i = 0; i < array_length_1d(possiblesShooters); i++){
        if(instance_exists(possiblesShooters[i])){
            ShootedBy = instance_nearest(x, y, possiblesShooters[i]);
        }
    }
}

function checkEnemies(){
    for(i = 0; i < array_length_1d(possiblesEnemies); i++){
        if(instance_exists(possiblesEnemies[i])){
            GiveDamageAt = instance_nearest(x, y, possiblesEnemies[i]);
            return GiveDamageAt;
        }
    }
    return noone;
}

function setDir(){
    if(!dirSeted){
        checkShooters();
        dir[0] = mouse_x - x;
        dir[1] = mouse_y - y;
        image_angle = point_direction(x, y, mouse_x, mouse_y);
        alarm[0] = ShootedBy.range;
        dirSeted = true;
    }
}

function destruct(){
    if(alarm[0] > 0){
        if(!place_meeting(x, y, colliders)){
            x += xySpeed[0];
            y += xySpeed[1];
        }else{
            checkEnemies();
            if(GiveDamageAt != noone && place_meeting(x, y, possiblesEnemies)){
                getDamage(GiveDamageAt, ShootedBy.damage);
                instance_destroy(self);
            }else{
                instance_destroy(self);
            }
        }
    }else{
        instance_destroy(self);
    }
}

function move(){
    setDir();
    xySpeed = speedNormalized(dir, bSpeed);
    destruct();
}