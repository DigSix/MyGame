life = 10;
eSpeed = Player.pSpeed/2;
xySpeed = [0, 0];
eWidth = sprite_width;
eHeight = sprite_height;

dir = [0, 0];
chasing = "none";

colliders = [Player, Enemy, Core, Wall];
enemies = [Enemy];

function setDir(){
    pDirX = Player.x - x;
    pDirY = Player.y - y;
    chasing = "player";

    if(instance_exists(Core)){
        cDirX = Core.x - x;
        cDirY = Core.y - y;
        pDistance = sqr(sqr(pDirX) + sqr(pDirY));
        cDistance = sqr(sqr(cDirX) + sqr(cDirY));
        
        if(pDistance < cDistance){
            dir[0] = pDirX;
            dir[1] = pDirY;
            chasing = "player";
        }else{  
            dir[0] = cDirX;
            dir[1] = cDirY;
            chasing = "core";
        } 

    }else{
        dir[0] = pDirX;
        dir[1] = pDirY;
    }
}

function teleport() {
    if(chasing == "player"){
        minWidth = Player.x - Camera.viewWidth/2;
        maxWidth = Player.x + Camera.viewWidth/2;
        minHeight = Player.y - Camera.viewHeight/2;
        maxHeight = Player.y + Camera.viewHeight/2;

        border = 64;
        halfBorder = border / 2;

        if (x < minWidth - border) {
            inst = instance_place(maxWidth - halfBorder, y, colliders);
            if(inst != noone && !BuildManager.isInsideGrid(maxWidth, y)){
                x = maxWidth - halfBorder;
            }
        }
        if (x > maxWidth + border) {
            inst = instance_place(minWidth + halfBorder, y, colliders);
            if(inst != noone && !BuildManager.isInsideGrid(minWidth, y)){
                x = minWidth + halfBorder;
            }
        }
        if (y < minHeight - border) {
            inst = instance_place(x, maxHeight - halfBorder, colliders);
            if(inst != noone && !BuildManager.isInsideGrid(x, maxHeight)){
                y = maxHeight - halfBorder;
            }
        }
        if (y > maxHeight + border) {
            inst = instance_place(x, minHeight + halfBorder, colliders);
            if(inst != noone && !BuildManager.isInsideGrid(x, minHeight)){
                y = minHeight + halfBorder;
            }
        }
    }
}

function checkDie(){
    if(life <= 0){
        instance_destroy(self);
        return true;
    } return false;
}

function move(){
    setDir();
    xySpeed = speedNormalized(dir, eSpeed);
    teleport();
    x = moveX(x, y, xySpeed[0], dir[0], colliders);
    y = moveY(x, y, xySpeed[1], dir[1], colliders);
    checkDie();
    checkInst(x, y, enemies, self);
}


