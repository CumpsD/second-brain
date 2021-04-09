// all in cm
spacer = 5;

toilet_wall_width = 107;
hole_width = 178;
green_box_width = 60;
small_hole_width = hole_width - green_box_width;
max_depth = 45;

room_width = toilet_wall_width + hole_width;
room_length = 508;
room_height = 241;

stone_floor();
hole();
toilet_wall();
green_box();
beams();

// x, y, z

module stone_floor() {
  translate([0, 0, -spacer])
    color("GhostWhite") cube([room_width, room_length, spacer]);
}

module green_box() {
  translate([0, -spacer, 0])
    color("Green") cube([green_box_width, spacer * 4, room_height]);
}

module hole() {
  translate([green_box_width, -spacer, 0])
    color("Gray") cube([small_hole_width, spacer, room_height]);
}

module toilet_wall() {
  translate([hole_width, -spacer, 0])
    color("Silver") cube([toilet_wall_width, max_depth + (spacer * 4), room_height]);
}

module beams() {
  translate([green_box_width + 5, spacer * 2, 0])
    color("Aqua") cube([small_hole_width - 10, 5, 5]);

  translate([green_box_width + 5, spacer * 2, room_height - 5])
    color("Aqua") cube([small_hole_width - 10, 5, 5]);

  translate([green_box_width, spacer * 2, 0])
    color("DarkGoldenrod") cube([5, 5, room_height]);

  translate([green_box_width + (small_hole_width / 2), spacer * 2, 5])
    color("DarkGoldenrod") cube([5, 5, room_height - 10]);

  translate([hole_width - 5, spacer * 2, 0])
    color("DarkGoldenrod") cube([5, 5, room_height]);
}
