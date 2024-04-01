gridWidth = 7;
gridHeight = 7;
cellSize = 32;
gridXSize = gridWidth * cellSize;
gridYSize = gridHeight * cellSize;

starterPosX = (room_width/2) - (cellSize*(gridWidth/2));
starterPosY = (room_height/2) - (cellSize*(gridHeight/2));
finalPosX = starterPosX + gridXSize;
finalPosY = starterPosY + gridYSize;

x = starterPosX;
y = starterPosY;

buildKey = global.mb1;
deleteKey = global.mb2;

isAbleToBuild = false;

possiblesInside = [Player, Enemy, Core];

buildGrid = ds_grid_create(gridWidth, gridHeight);
for(i = 0; i < gridWidth; i++){
    for(j = 0; j < gridHeight; j++){
        buildGrid[# i, j] = 0;
    }
}

function drawGrid(){
    if(global.isAbleToBuild){
        for(i = 0; i < gridWidth; i++){
            for(j = 0; j < gridHeight; j++){
                cellX = starterPosX + (i * cellSize);
                cellY = starterPosY + (j * cellSize);

                draw_rectangle(cellX, cellY, cellX + cellSize, cellY + cellSize, true);
            }
        }
    }
}

function isInsideCell(){
    for(i = 0; i < array_length_1d(possiblesInside); i++){
        if(instance_exists(possiblesInside[i])){
            if((possiblesInside[i].x >= (mouse_x - cellSize * 1.5) && possiblesInside[i].x <= (mouse_x + cellSize * 1.5)) && (possiblesInside[i].y >= (mouse_y - cellSize * 1.5) && possiblesInside[i].y <= (mouse_y + cellSize * 1.5))){
                return true;
            }
        }
    }
    return false;
}

function builder(){
    if(global.isAbleToBuild){
        mouseGridX = (mouse_x - starterPosX) div cellSize;
        mouseGridY = (mouse_y - starterPosY) div cellSize;
        if(((mouse_x - starterPosX)/cellSize) < 0){
            mouseGridX = -1;
        }
        if(((mouse_y - starterPosY)/cellSize) < 0){
            mouseGridX = -1;
        }

        if(mouseGridX >= 0 && mouseGridX < gridWidth && mouseGridY >= 0 && mouseGridY < gridHeight){
            instX = mouseGridX * cellSize + cellSize/2;
            instY = mouseGridY * cellSize + cellSize/2;

            if(buildGrid[# mouseGridX, mouseGridY] == 0){
                if(mouse_check_button_pressed(buildKey)){
                    if(!isInsideCell()){
                        instance_create_layer(instX+starterPosX, instY+starterPosY, "Instances", Wall);
                        inst = instance_nearest(instX+starterPosX, instY+starterPosY, Wall);
                        buildGrid[# mouseGridX, mouseGridY] = inst;
                    }
                }  
            }
            if(buildGrid[# mouseGridX, mouseGridY] != 0){
                if(mouse_check_button_pressed(buildKey)){
                    if(!isInsideCell()){
                        inst = buildGrid[# mouseGridX, mouseGridY];
                        if(!instance_exists(inst)){
                            instance_create_layer(instX+starterPosX, instY+starterPosY, "Instances", Wall);
                            inst = instance_nearest(instX+starterPosX, instY+starterPosY, Wall);
                            buildGrid[# mouseGridX, mouseGridY] = inst;
                        }
                    }
                }
                if(mouse_check_button_pressed(deleteKey)){
                    inst = buildGrid[# mouseGridX, mouseGridY];
                    instance_destroy(inst);
                    buildGrid[# mouseGridX, mouseGridY] = 0;
                }
            }
        }
    }
}

function isInsideGrid(x, y){
    if(x > starterPosX && x < finalPosX && y > starterPosY && y < finalPosY){
        return true;
    } return false;
}

