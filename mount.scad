$fn=100;
t=1.5;

the_thing(x=12, y=14, z=12, camera_x=5.5);

module the_thing(x, y, z, camera_x) {
    difference() {
        cube(size=[x, y, z]);

        translate([t, -1, t])
            cube(size=[1, y + 2, z - t * 2]);

        translate([t + (1 - 0.5), -1, -1])
            cube(size=[0.5, y + 2, t + 2]);

        translate([2 * t + 1, -1, t])
            cube(size=[x, y + 2, z]);

    }

    translate([2 * t + 1 + camera_x + 2.50, 0, 1])
    rotate([0, -100, 0])
        difference() {
            cube(size=[z, y, t]);
            translate([7.5, y / 2, -1])
                cylinder(h=6, r=7.5 / 2);
            translate([7.1, (y - 7.5) / 2, -1])
                cube(size=[x, 7.5, t + 2]);
        }
}
