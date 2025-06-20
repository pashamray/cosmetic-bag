/**
 * Cosmetic bag 
 *
 * Author:  Pavlo Shamrai
 * Email:   pashamray@gmail.com
 * Date:    17.05.2025
 * Update:  31.05.2025
 * License: MIT
**/

include <BOSL2/std.scad>

$fn = 300;

size      = [220, 160, 50]; 
corner_r  = 40;           
tex       = texture("diamonds");       
tex_h     = 2;          
tile_xy   = [10, 25];      

wall = 2;
bottom = 2;
tolerance = 0.3;

module body()
{
    linear_sweep(
        rect([size.x, size.y], rounding = corner_r),
        h          = size.z,
        center     = true,
        texture    = tex,
        tex_size   = tile_xy,  
        tex_depth  = tex_h,
        caps       = true
    );
    down(size.z / 2 + bottom / 2) cuboid([size.x - wall * 2 - tolerance, size.y - wall * 2 - tolerance, bottom], rounding = corner_r - wall - tolerance / 2, edges=[LEFT+FRONT, LEFT+BACK, RIGHT+FRONT, RIGHT+BACK]);
}

module cup()
{
    up(size.z + bottom / 2 * 2) {
        up((size.z / 2)) left(size.x / 2 - corner_r) back(size.y / 2 - corner_r) tube(h=(size.z - bottom) * 2, or=corner_r - wall * 2 - 0.1, wall=corner_r - wall * 2 - 0.1);
    }
}

module top() {
    difference() {
        middle();
        left(size.x / 2 - corner_r) back(size.y / 2 - corner_r) tube(h=size.z + bottom * 4, or=corner_r - wall * 2, wall=corner_r - wall * 2);
        
    }
    *cuboid([size.x, wall * 2, size.z - bottom * 2]);
}


module middle() {
    diff() {
        body();
        tag("remove") {
            up(bottom) {
                cuboid([size.x - wall * 2, size.y - wall * 2, size.z], rounding = corner_r - wall, edges=[LEFT+FRONT, LEFT+BACK, RIGHT+FRONT, RIGHT+BACK, LEFT+BOTTOM, RIGHT+BOTTOM, FRONT+BOTTOM, BACK+BOTTOM]);
                
            }
            left(size.x / 2 - corner_r) back(size.y / 2 - corner_r) tube(h=size.z - bottom * 2, or=corner_r - wall * 2, wall=corner_r - wall * 2);
        }
        tag("keep") {
            left(size.x / 2 - corner_r) back(size.y / 2 - corner_r) tube(h=size.z - bottom * 2, or=corner_r - wall, wall=wall);
        }
    }
}

module bottom() {
    diff() {
        body();
        tag("remove") {
            up(bottom) {
                cuboid([size.x - wall * 2, size.y - wall * 2, size.z], rounding = corner_r - wall, edges=[LEFT+FRONT, LEFT+BACK, RIGHT+FRONT, RIGHT+BACK, LEFT+BOTTOM, RIGHT+BOTTOM, FRONT+BOTTOM, BACK+BOTTOM]);
            }
        }
    }
}

*cup();
up((size.z + bottom / 2) * 2) {
    top();
}
up(size.z + bottom / 2) {
    middle(); 
}
bottom();