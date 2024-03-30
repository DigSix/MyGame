resoWidth = 1280;
resoHeight = 720;
resoScale = 2;
viewWidth = resoWidth / resoScale;
viewHeight = resoHeight / resoScale;
window_set_size(resoWidth, resoHeight);
surface_resize(application_surface, resoWidth, resoHeight);
display_set_gui_size(viewWidth, viewHeight);
alarm[0] = 1;

Target = Player;
viewSpeed = 0.2;

function changeZoom(){
    if(keyboard_check_pressed(global.moreZoomKey) && resoScale < 4){
        resoScale++;
        viewWidth = resoWidth / resoScale;
        viewHeight = resoHeight / resoScale;
        display_set_gui_size(viewWidth, viewHeight);
    }
    if(keyboard_check_pressed(global.lessZoomKey) && resoScale > 2){
        resoScale--;
        viewWidth = resoWidth / resoScale;
        viewHeight = resoHeight / resoScale;
        display_set_gui_size(viewWidth, viewHeight);
    }
}

function followPlayer(){
    if(instance_exists(Target)){
        targetX = Target.x - viewWidth / 2;
        targetY = Target.y - viewHeight / 2;

        targetX = clamp(targetX, 0 - viewWidth/2, room_width + viewWidth/2);
        targetY = clamp(targetY, 0 - viewHeight/2, room_height + viewHeight/2);

        camX = camera_get_view_x(view_camera[0]);
        camY = camera_get_view_y(view_camera[0]);

        camera_set_view_pos(view_camera[0], lerp(camX, targetX, viewSpeed), lerp(camY, targetY, viewSpeed));
    }
}