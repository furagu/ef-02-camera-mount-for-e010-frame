$fn=100;

main();

module main() {
    angle = 5;
    length = 4.5;
    height = 17.5;
    thickness = 1.2;
    grip_width = 10;
    compartment_width = 13;
    compartment_back = 8;
    bar_length = 0.75;
    bar_height = 4.9;
    slit_length=0.4;

    difference() {
        union() {
            difference() {
                translate([length - thickness, (grip_width - compartment_width) / 2, 0])
                rotate([0, -angle, 0])
                    camera_compartment(
                        length=3.9,
                        width=compartment_width,
                        height=height,
                        grip_width=compartment_back,
                        thickness=thickness,
                        bottom_height=1.5,
                        sensor_width=8,
                        sensor_y_offset=2,
                        left_lip_length=1.1,
                        left_lip_width=1.2
                    );

                translate([0, -25, height - 4])
                    cube(size=[50, 50, 50]);

                translate([0, -25, -height])
                    cube(size=[50, 50, height]);
            }

            grip(
                length=length,
                width=grip_width,
                height=height,
                thickness=thickness,
                mount_width=compartment_back,
                bar_length=bar_length,
                bar_height=bar_height,
                slit_length=slit_length,
                angle=angle
            );
        }

        translate([0, 0, height - bar_height - thickness * 3])
        rotate([0, 45, 0])
            cube([thickness, grip_width * 2 + 2, thickness], center=true);
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

            translate([thickness + bar_length, 0, height - bar_height - thickness * 3])
            difference() {
                cube(size=[thickness, width, bar_height + thickness * 3]);

                cut_size = sqrt(pow(thickness, 2) * 2);

                translate([0, -1, -thickness])
                rotate([0, -45, 0])
                    cube(size=[cut_size, width + 2, cut_size]);

                translate([0, 0, -thickness])
                rotate([45, 0, 0])
                    cube(size=[thickness + 1, cut_size, cut_size]);

                translate([0, width, -thickness])
                rotate([45, 0, 0])
                    cube(size=[thickness + 1, cut_size, cut_size]);
            }

            translate([length - thickness, (width - mount_width) / 2, 0])
                difference() {
                    rotate([0, -angle, 0])
                    translate([0, 0, -5])
                    difference() {
                        gap_w = mount_width / 2 ;

                        cube(size=[thickness, mount_width, height + 10]);
                        translate([-1, (mount_width - gap_w) / 2, -1])
                            cube(size=[thickness + 2, gap_w, height + 12]);
                    }

                    translate([-height, -1, height])
                        cube(size=[50, 50, height]);

                     translate([-height, -1, -height])
                        cube(size=[50, 50, height]);
                }
        }

        translate([thickness * 2 + bar_length, -1, height])
        rotate([0, 45, 0])
            cube(size=[height, width + 2, 50]);

    }
}

module camera_compartment(length, width, height, grip_width, thickness, bottom_height, sensor_width, sensor_y_offset, left_lip_length, left_lip_width) {
    difference() {
        translate([0, 0, -bottom_height]) {
            difference() {
                hull() {
                    translate([length + thickness, 0, 0])
                        cube(size=[thickness, width, height + bottom_height + thickness]);

                    translate([0, (width - grip_width) / 2, 0])
                        cube(size=[thickness, grip_width, height + bottom_height + thickness]);
                }

                hull() {
                    back_w = grip_width / 2;

                    translate([-0.1, (width - grip_width + back_w) / 2, 0])
                        cube(size=[0.1, back_w, height + bottom_height + thickness]);

                    front_w = width / 2;

                    translate([length + thickness - 0.1, (width - front_w) / 2, 0])
                        cube(size=[0.1, front_w, height + bottom_height + thickness]);
                }
            }
        }

        translate([-1, -1 - left_lip_width, bottom_height])
            cube(size=[length + thickness + 1, width + 1, height + 1]);

        translate([-thickness - left_lip_length, -1, bottom_height])
            cube(size=[length + thickness + 1, width + 2, height + 1]);

        translate([length + thickness - 1, (width - sensor_width) / 2, bottom_height + sensor_y_offset])
            cube(size=[thickness + 2, sensor_width, height]);
    }
}
