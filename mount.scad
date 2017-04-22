$fn=100;

main();

module main() {
    angle = 10;
    length = 12;
    height = 12;
    thickness = 1.5;
    grip_width = 8;
    compartment_width = 14;

    difference() {
        translate([length, (grip_width - compartment_width) / 2, 0])
        rotate([0, -10, 0])
            camera_compartment(
                length=4,
                width=compartment_width,
                height=height,
                thickness=thickness,
                bottom_height=2,
                sensor_width=8,
                sensor_y_offset=2,
                left_lip_length=1,
                left_lip_width=1.5
            );

        translate([0, -25, height])
            cube(size=[50, 50, 50]);
    }

    grip(
        length=length,
        width=8,
        height=height,
        thickness=thickness,
        mount_width=14,
        bar_length=1,
        bar_height=4.6,
        slit_length=0.5,
        angle=angle
    );
}

module grip(length, width, height, thickness, mount_width, bar_length, bar_width, bar_height, slit_length, angle) {
    difference() {
        union() {
            difference() {
                cube(size=[bar_length + thickness, width, height]);

                translate([thickness, -1, height - bar_height - thickness])
                    cube(size=[bar_length + 1, width + 2, bar_height]);

                translate([thickness + bar_length - slit_length, -1, -1])
                    cube(size=[thickness + slit_length + 1, width + 2, height - bar_height - thickness + 2]);
            }

            hull() {
                translate([thickness + bar_length, 0, 0])
                    cube(size=[thickness, width, height]);

                translate([length - thickness, (width - mount_width) / 2, 0])
                difference() {
                    rotate([0, -10, 0])
                    translate([0, 0, -5])
                        cube(size=[thickness, mount_width, height + 10]);

                    translate([-height, -1, height])
                        cube(size=[50, 50, height]);

                     translate([-height, -1, -height])
                        cube(size=[50, 50, height]);
               }
            }
        }

        hull() {
            translate([thickness * 2 + bar_length + 1, width - thickness, -1])
                cylinder(h=height + 2, r=1);

            translate([thickness * 2 + bar_length + 1, thickness, -1])
                cylinder(h=height + 2, r=1);

            translate([thickness * 2 + bar_length + 4, width, -1])
                cylinder(h=height + 2, r=1);

            translate([thickness * 2 + bar_length + 4, 0, -1])
                cylinder(h=height + 2, r=1);
        }
    }
}

module camera_compartment(length, width, height, thickness, sensor_width, sensor_y_offset, left_lip_length, left_lip_width) {
    difference() {
        cube(size=[length + thickness * 2, width, height + bottom_height]);

        translate([-1, -1, bottom_height])
            cube(size=[length + thickness + 1, width + 2, height + 1]);

        translate([length + thickness - 1, (width - sensor_width) / 2, bottom_height + sensor_y_offset])
            cube(size=[thickness + 2, sensor_width, height]);
    }

    translate([length + thickness - left_lip_length, width - left_lip_width, 0])
        cube(size=[left_lip_length, left_lip_width, height + bottom_height]);
}
