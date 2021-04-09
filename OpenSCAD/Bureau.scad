// Office

// Office Requirements
// - spot for printer/scanner/supplies (paper, toners)
// - at least desk space for 2 people, a desk is defined by:
//   - at least 2 mounted screens
//   - decent speakers
//   - small ups
//   - room to put papers
//   - in total around +- 2.5meters of horizontal space, perhaps 2m
// - standing desks
// - a place to brainstorm/place to sit with a client
// - motivational colors and decoration

ceiling_door_gap = 30;

door_trim_height = 210;
door_trim_width = 90;
door_wall_gap = 20;
toilet_wall_width = 107;
toilet_wall_length = 93;
cable_gutter_width = 21;
cable_gutter_length = 5.5;
electric_wall_width = 97;
vent_length = 56;
vent_width = 60;
side_wall_length = 450;
room_width = 285;
inner_wall_length = 303;

transfos_margin = 5;
transfos_height = 60;
transfos_width = 60;
transfos_depth = 20;
transfos_gutter = 10;

heating_depth = 31;
heating_height = 75;

edge_height = 20;
edge_depth = 25;
edge_length = 200;

side_wall_window = 52;
inner_wall_window = 76;
window_bottom = 92;
window_top = 31;

wall_height = door_trim_height + ceiling_door_gap;
room_length = side_wall_length + vent_length; // 508

stone_floor();
side_wall();
vent_wall();
inner_wall();
window_wall();

// x, y, z

module stone_floor() {
  translate([0, 0, -5])
    color("GhostWhite") cube([room_width + 5, room_length, 5]);
}

module side_wall() {
  translate([0, -5, 0])
    color("AntiqueWhite") cube([5, room_length + 5, wall_height]);
}

module vent_wall() {
  translate([5, 0, 0])
    color("Green") cube([vent_width, vent_length, wall_height]);

  translate([5, -5, 0])
    // color("AntiqueWhite") cube([vent_width + electric_wall_width + cable_gutter_width, 5, wall_height]);
    color("AntiqueWhite") cube([room_width, 5, wall_height]);

  translate([5 + vent_width + electric_wall_width, 0, 0])
    color("Silver") cube([cable_gutter_width, cable_gutter_length, wall_height]);

  translate([5 + vent_width + electric_wall_width + cable_gutter_width, 0, 0])
    color("AntiqueWhite") cube([toilet_wall_width, toilet_wall_length, wall_height]);

  translate([5 + vent_width, 0, wall_height - transfos_height - transfos_gutter - transfos_margin])
    color("Silver") cube([electric_wall_width, cable_gutter_length, transfos_gutter]);

  translate([5 + vent_width, 0, wall_height - transfos_height - transfos_margin])
    color("Gray") cube([transfos_width, transfos_depth, transfos_height]);

  translate([5 + vent_width, 0, 0])
    color("Green") cube([electric_wall_width + cable_gutter_width, heating_depth, heating_height]);
}

module inner_wall() {
  inner_wall_offset = vent_width + electric_wall_width + cable_gutter_width + toilet_wall_width;

  translate([inner_wall_offset, toilet_wall_length, 0])
    color("AntiqueWhite") cube([5, door_wall_gap, wall_height]);

  translate([inner_wall_offset, toilet_wall_length + door_wall_gap, 0])
    color("Maroon") cube([5, door_trim_width, door_trim_height]);

  translate([inner_wall_offset, toilet_wall_length + door_wall_gap, door_trim_height])
    color("AntiqueWhite") cube([5, door_trim_width, ceiling_door_gap]);

  translate([inner_wall_offset, toilet_wall_length + door_wall_gap + door_trim_width, 0])
    color("AntiqueWhite") cube([5, inner_wall_length, wall_height]);

  translate([inner_wall_offset - edge_depth, room_length - edge_length, wall_height - edge_height])
    color("AntiqueWhite") cube([edge_depth, edge_length, edge_height]);
}

module window_wall() {
  translate([5, room_length - 5, 0])
    color("AntiqueWhite") cube([side_wall_window, 5, wall_height]);

  translate([5 + side_wall_window, room_length - 5, 0])
    color("AntiqueWhite") cube([room_width - side_wall_window - inner_wall_window, 5, window_bottom]);

  translate([5 + side_wall_window, room_length - 5, wall_height - window_top])
    color("AntiqueWhite") cube([room_width - side_wall_window - inner_wall_window, 5, window_top]);

  translate([room_width - inner_wall_window, room_length - 5, 0])
    color("AntiqueWhite") cube([inner_wall_window, 5, wall_height]);

  translate([5 + side_wall_window, room_length - 5, window_bottom])
    color("Aqua") cube([room_width - side_wall_window - inner_wall_window, 5, wall_height - window_bottom - window_top]);
}
