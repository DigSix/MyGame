clipSize = 20;
ammo = clipSize;
fireRate = global.frameRate / 5;
reloadTime = global.frameRate * 1.5;
range = global.frameRate * 0.9;
canShoot = true;
reloading = false;
damage = 4;
gSpeed = 0.5;

dir = [0, 0];
pos = [0, 0];
distance = 5; //Player distance;

function setDir(){
    dir[0] = mouse_x - Player.x;
    dir[1] = mouse_y - Player.y;
}

function fire(){
    if(mouse_check_button(global.mb1) && canShoot){ // fire
        if(alarm[0] <= 0 && ammo > 0){
            instance_create_layer(x, y, "Instances", Bullet);
            ammo--;
            alarm[0] = fireRate;
        }else if(ammo <= 0){
            canShoot = false;
        }
    }
    if(keyboard_check_pressed(ord(global.reloadKey))){ //stop fire to reload
        canShoot = false;
    }
}

function reload(){
    if(!canShoot){
        if(!reloading){
            alarm[1] = reloadTime;
            reloading = true;
        }else if(reloading){
            if(alarm[1] <= 0){
                ammo = clipSize;
                canShoot = true;
                reloading = false;
            }
        }
    }
}

function move(){
    setDir();   
    pos = speedNormalized(dir, distance);
    lerpX = Player.x + (pos[0] * distance)
    lerpY = Player.y + (pos[1] * distance)
    x = lerp(x, lerpX, gSpeed);
    y = lerp(y, lerpY, gSpeed);
    fire();
    reload();
}
