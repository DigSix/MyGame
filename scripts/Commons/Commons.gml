global.frameRate = 60;

global.mb1 = mb_left;
global.mb2 = mb_right;
global.reloadKey = "R";
global.changeModeKey = "Q";
global.moreZoomKey = vk_add;
global.lessZoomKey = vk_subtract;
global.isAbleToBuild = false;
global.isAbleToCombat = true;

function speedNormalized(dir, oSpeed){
    if(dir[0] != 0 || dir[1] != 0){
        length = sqrt(sqr(dir[0]) + sqr(dir[1]));
        dir[0] /= length;
        dir[1] /= length;
    }
    xySpeed[0] = dir[0] * oSpeed;
    xySpeed[1] = dir[1] * oSpeed;
    return xySpeed;
}

function moveX(funcX, funcY, xSpeed, dirX, colliders){
    if(!place_meeting(funcX+xSpeed, funcY, colliders)){
        funcX += xSpeed;
        return funcX;
    }else{
        if(!place_meeting(funcX+dirX, funcY, colliders)){
            funcX += dirX;
            return funcX;
        }
    }
    return funcX;
}

function moveY(funcX, funcY, ySpeed, dirY, colliders){
    if(!place_meeting(funcX, funcY+ySpeed, colliders)){
        funcY += ySpeed;
        return funcY;
    }else{
        if(!place_meeting(funcX, funcY+dirY, colliders)){
            funcY += dirY;
            return funcY;
        }
    }
    return funcY;
}

function changeMode(){
    if(keyboard_check_pressed(ord(global.changeModeKey))){
        if(global.isAbleToBuild){
            global.isAbleToBuild = false;
        } else{
            global.isAbleToBuild = true;
        }
        if(global.isAbleToCombat){
            global.isAbleToCombat = false;
        } else{
            global.isAbleToCombat = true;
        }
    }
}

function getDamage(Object, damage){
    Object.life -= damage;
}

function getHeal(life, heal){
    life += heal;
}