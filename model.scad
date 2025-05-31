/**
 * Cosmetic bag 
 *
 * Author:  Pavlo Shamrai
 * Email:   pashamray@gmail.com
 * Date:    17.05.2025
 * Update:  31.05.2025
 * License: MIT
**/

width = 220;
depth = 160;
height = 50;
radius = 40;
wall = 4;
bottom = 2;
tolerance = 0.5;

$fn=300;

module main() {
    difference() {
        minkowski() {
            cylinder(h = height, r = radius, true);
            cube([width - radius * 2, depth - radius * 2, height], center = true);
        }
        translate([0, 0, bottom]) {
            minkowski() {
                cube([width - radius * 2, depth - radius * 2, height - bottom], center = true);
                cylinder(h = height, r = radius - wall, true);
            }
        }
        translate([0, 0, height / 2 - bottom / 2]) {
            minkowski() {
                cube([width - radius * 2, depth - radius * 2, bottom], center = true);
                cylinder(h = bottom, r = radius - wall / 2, true);
            }
        }
    }
}

module top() {
    difference() {
        middle();
        translate([-(width - radius * 2) / 2, (depth - radius * 2) / 2, -bottom]) {
            cylinder(h = height + bottom, r = radius - wall , center = true);
            
        }
    }
}

module middle() {
    union() {
        main();      
        translate([0, 0, -(height / 2 + bottom)]) {
            minkowski() {
                cube([width - radius * 2, depth - radius * 2, bottom], center = true);
                cylinder(h = bottom, r = (radius - wall / 2) - tolerance / 2, true);
            }
        }
        translate([-(width - radius * 2) / 2, (depth - radius * 2) / 2, 0]) {
            difference() {
            cylinder(h = height - bottom * 2, r = radius - wall / 2, center = true);
            cylinder(h = height - bottom * 2, r = radius - wall , center = true);
            }
        }
    }
}

module bottom() {
    main();
}

translate([0, 0, (height + 2) * 2]) {
    top();
}
translate([0, 0, height + 2]) {
    middle();
}
bottom();