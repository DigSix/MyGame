spawnTimer = global.frameRate * 0.75;

enemies = [Enemy];
colliders = [Player, Core, Wall, Enemy];

function chooseEnemy(){
    if(array_length_1d(enemies) - 1 == 0){
        return enemies[0];
    } else{
        selectedEnemy = irandom_range(0, array_length_1d(enemies) - 1);
        return enemies[selectedEnemy];
    }
}

function canSpawn(x, y, Object){
    halfWidth = Object.eWidth / 2;
    halfHeight = Object.eHeight / 2;
    
    if(BuildManager.isInsideGrid(x - halfWidth, y) || BuildManager.isInsideGrid(x + halfWidth, y) || BuildManager.isInsideGrid(x, y - halfHeight) || BuildManager.isInsideGrid(x, y + halfHeight)){
        return false;
    }
    return true;
}

function spawnEnemy(){
    if(alarm[0] <= 0){
        selectedSides = irandom(1);
    
        minWidth = Player.x - Camera.viewWidth/2;
        maxWidth = Player.x + Camera.viewWidth/2;
        minHeight = Player.y - Camera.viewHeight/2;
        maxHeight = Player.y + Camera.viewHeight/2;

        if(selectedSides == 0){
            spawnX = irandom_range(minWidth, maxWidth);
            spawnY = choose(minHeight, maxHeight);
            ChoosedEnemy = chooseEnemy();
            instance_create_layer(spawnX, spawnY, "Instances", ChoosedEnemy);
            ChoosedEnemy = instance_nearest(spawnX, spawnY, ChoosedEnemy);
            if(!canSpawn(spawnX, spawnY, ChoosedEnemy)){
                instance_destroy(ChoosedEnemy);
            }
        }else{
            spawnX = choose(minWidth, maxWidth);
            spawnY = irandom_range(minHeight, maxHeight);
            ChoosedEnemy = chooseEnemy();
            instance_create_layer(spawnX, spawnY, "Instances", ChoosedEnemy);
            ChoosedEnemy = instance_nearest(spawnX, spawnY, ChoosedEnemy);
            if(!canSpawn(spawnX, spawnY, ChoosedEnemy)){
                instance_destroy(ChoosedEnemy);
            }
        }
        alarm[0] = spawnTimer;
    }
}