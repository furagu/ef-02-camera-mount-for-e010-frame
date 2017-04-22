$fn=100;

main();

module main() {
    angle = 5;
    length = 10;
    height = 15;
    thickness = 1.5;
    grip_width = 9;
    compartment_width = 14;
    compartment_back = 9;
    bar_length = 0.9;

    difference() {
        union() {
            difference() {
                translate([length - thickness, (grip_width - compartment_width) / 2, 0])
                rotate([0, -angle, 0])
                    camera_compartment(
                        length=4,
                        width=compartment_width,
                        height=height,
                        grip_width=compartment_back,
                        thickness=thickness,
                        bottom_height=2,
                        sensor_width=8.2,
                        sensor_y_offset=2,
                        left_lip_length=1.5,
                        left_lip_width=2
                    );

                translate([0, -25, height])
                    cube(size=[50, 50, 50]);

                translate([0, -25, -height])
                    cube(size=[50, 50, height]);

                translate([length + 5.4, -25, -1])
                    cube(size=[5, 50, 50]);
            }

            grip(
                length=length,
                width=grip_width,
                height=height,
                thickness=thickness,
                mount_width=compartment_back,
                bar_length=bar_length,
                bar_height=4.9,
                slit_length=0.4,
                angle=angle
            );
        }
    }
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
                    rotate([0, -angle, 0])
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
            translate([thickness * 1.5 + bar_length + 1, width - thickness * 1.2, -1])
                cylinder(h=height + 2, r=1);

            translate([thickness * 1.5 + bar_length + 1, thickness * 1.2, -1])
                cylinder(h=height + 2, r=1);

            translate([length - thickness * 2, width - thickness * 1.2, -1])
                cylinder(h=height + 2, r=1);

            translate([length - thickness * 2, thickness * 1.2, -1])
                cylinder(h=height + 2, r=1);
        }

        translate([thickness * 2 + bar_length, -1, height])
        rotate([0, 35, 0])
            cube(size=[height, width + 2, 50]);

        // hull() {
        //     translate([length, width / 2, height / 3])
        //     rotate([0, 90, 0])
        //         cylinder(h=thickness * 4, r=mount_width / 5, center=true);

        //     translate([length, width / 2, height])
        //     rotate([0, 90, 0])
        //         cylinder(h=thickness * 4, r=mount_width / 5, center=true);
        // }
    }
}

module camera_compartment(length, width, height, grip_width, thickness, bottom_height, sensor_width, sensor_y_offset, left_lip_length, left_lip_width) {
    difference() {
        translate([0, 0, -bottom_height]) {
            hull() {
                translate([length + thickness, 0, 0])
                    cube(size=[thickness, width, height + bottom_height + thickness]);

                translate([0, (width - grip_width) / 2, 0])
                    cube(size=[thickness, grip_width, height + bottom_height + thickness]);
            }
        }

        translate([-1, -1 - left_lip_width, bottom_height])
            cube(size=[length + thickness + 1, width + 1, height + 1]);

        translate([-thickness - left_lip_length, -1, bottom_height])
            cube(size=[length + thickness + 1, width + 2, height + 1]);

        translate([length + thickness - 1, (width - sensor_width) / 2, bottom_height + sensor_y_offset])
            cube(size=[thickness + 2, sensor_width, height]);
    }

    // translate([length + thickness - left_lip_length, width - left_lip_width, 0])
    //     cube(size=[left_lip_length, left_lip_width, height + thickness]);
}
