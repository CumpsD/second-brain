// all in cm
spacer = 5;

toilet_wall_width = 107;
green_box_width = 175;
green_box_thickness = spacer * 4;
max_depth = 40;

room_width = toilet_wall_width + green_box_width;
room_length = 508;
room_height = 241;

metal_bars_width = 8;
wood_thickness = 2;
metal_thickness = 4;

stone_floor();
toilet_wall();
green_box();
furniture();

// x, y, z
module stone_floor() {
  translate([0, 0, -spacer])
    color("GhostWhite") cube([room_width, room_length, spacer]);
}

module green_box() {
  translate([0, -spacer, 0])
    color("Silver") cube([green_box_width, green_box_thickness, room_height]);
}

module toilet_wall() {
  translate([green_box_width, -spacer, 0])
    color("Silver") cube([toilet_wall_width, max_depth + green_box_thickness, room_height]);
}

module furniture() {
  floor_furniture_spacing = 11;
  furniture_width = green_box_width;
  furniture_right = furniture_width / 3 * 1;
  furniture_left = furniture_width / 3 * 2;
  furniture_height = room_height - floor_furniture_spacing;

  pilar1 = furniture_left - (metal_bars_width / 2);
  pilar2 = furniture_right - (metal_bars_width / 2);

  vertical_frame(pilar1, furniture_height);
  vertical_frame(pilar2, furniture_height);

  furniture_start = floor_furniture_spacing;
  row1 = 64 + metal_thickness + wood_thickness;
  row2 = 34 + metal_thickness + wood_thickness;
  row3 = 84 + metal_thickness + wood_thickness;

  shelf(
    furniture_width,
    furniture_start,
    pilar1, pilar2);

  shelf(
    furniture_width,
    furniture_start + row1,
    pilar1, pilar2);

  shelf(
    furniture_width,
    furniture_start + row1 + row2,
    pilar1, pilar2);

  shelf(
    furniture_width,
    furniture_start + row1 + row2 + row3,
    pilar1, pilar2);

  bolts(furniture_start, pilar1, pilar2);
}

module vertical_frame(start, height) {
    // max_depth
  translate([start, green_box_thickness - spacer, 0])
    color("Black") cube([metal_bars_width, metal_bars_width, height]);

  translate([start, green_box_thickness - spacer + max_depth - metal_bars_width, 0])
    color("Black") cube([metal_bars_width, metal_bars_width, height]);

  translate([start, green_box_thickness - spacer, height])
    color("Black") cube([metal_bars_width, max_depth, metal_bars_width]);

  translate([start, green_box_thickness - spacer, 0])
    color("Black") cube([metal_bars_width, max_depth, metal_bars_width]);
}

module shelf(width, height, pilar1, pilar2) {
  height = height + metal_thickness;

  translate([0, green_box_thickness - spacer, height - metal_thickness])
    color("Black") cube([width, max_depth, metal_thickness]);

  translate([0, green_box_thickness - spacer, height])
    color("OrangeRed") cube([pilar2, max_depth, wood_thickness]);

  translate([pilar2, green_box_thickness - spacer + metal_bars_width, height])
    color("OrangeRed") cube([metal_bars_width, max_depth - (metal_bars_width * 2), wood_thickness]);

  translate([pilar2 + metal_bars_width, green_box_thickness - spacer, height])
    color("OrangeRed") cube([pilar1 - pilar2 - metal_bars_width, max_depth, wood_thickness]);

  translate([pilar1, green_box_thickness - spacer + metal_bars_width, height])
    color("OrangeRed") cube([metal_bars_width, max_depth - (metal_bars_width * 2), wood_thickness]);

  translate([pilar1 + metal_bars_width, green_box_thickness - spacer, height])
    color("OrangeRed") cube([width - pilar1 - metal_bars_width, max_depth, wood_thickness]);
}

module bolts(start, pilar1, pilar2) {
  bolt_row(pilar1 + (metal_bars_width / 2), start);
  bolt_row(pilar2 + (metal_bars_width / 2), start);
}

module bolt_row(left, start) {
  bar = (metal_thickness / 2);
  height = 10;

  for (i=[0:22]) {
    bolt(left, start + (i * height) + bar);
  }
}

module bolt(left, bottom) {
  translate([left, max_depth + green_box_thickness - spacer, bottom])
  rotate([90, 0, 0]) color("SlateGray") cylinder(h=0.5, r=0.6, center=true);
}
