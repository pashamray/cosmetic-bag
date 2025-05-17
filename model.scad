length = 220;
width = 160;
height = 30;
radius = 40;
border = 4;

$fn=300;

difference () {
    union () {
        minkowski() {
            cube([length - (radius * 2), width - (radius * 2), height], center = true);
            cylinder(h = height, r = radius, center = true); 
        }
            
        translate ([0, 0, -2]) {
            minkowski() {
                cube([length - (radius * 2), width - (radius * 2), height], center = true);
                cylinder(h = height, r = (radius - 1 / 2) - border / 2, center = true); 
            }
        }
    }
    
    translate ([0, 0, 2]) {
        union () {
            translate ([0, 0, height - 2]) {
                minkowski() {
                    cube([length - (radius * 2), width - (radius * 2), 4 ], center = true);
                    cylinder(h = 4, r = radius - border / 2, center = true);
                }
            }
                        
            minkowski() {
                cube([length - (radius * 2), width - (radius * 2), height ], center = true);
                cylinder(h = height, r = radius - border, center = true);
            }
        }
    }
}
