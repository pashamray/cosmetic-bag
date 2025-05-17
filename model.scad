length = 220;
width = 160;
height = 35;
radius = 40;
border = 4;

$fn=300;

union () {
    *translate([-(length / 2 - radius), width / 2 - radius, -2]) {
        difference() {
            cylinder(h = height - 4, r = radius - border / 2, center = true);
            cylinder(h = height + 10, r = radius - border, center = true);
        }
    }


    difference() {
        difference () {
            union () {
                minkowski() {
                    cube([length - (radius * 2), width - (radius * 2), height / 2], center = true);
                    cylinder(h = height / 2, r = radius, center = true); 
                }
                    
                translate ([0, 0, -2]) {
                    minkowski() {
                        cube([length - (radius * 2), width - (radius * 2), height / 2], center = true);
                        cylinder(h = height / 2, r = (radius - 1 / 2) - border / 2, center = true); 
                    }
                }
            }
                
                translate ([0, 0, 2]) {
                    union () {
                        translate ([0, 0, (height / 2) - 2]) {
                            minkowski() {
                                cube([length - (radius * 2), width - (radius * 2), 4 ], center = true);
                                cylinder(h = 4, r = radius - border / 2, center = true);
                            }
                        }
                                    
                        minkowski() {
                            cube([length - (radius * 2), width - (radius * 2), height / 2 ], center = true);
                            cylinder(h = height / 2, r = radius - border, center = true);
                        }
                    }
                }
            }
        *translate([-(length / 2 - radius), width / 2 - radius, -2]) {
            cylinder(h = height + 10, r = radius - border, center = true);
        }
    }
}