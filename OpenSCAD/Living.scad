wall_height = 250;
door_to_window = 157;
window_width = 157;
window_height = 220;
window_to_end = 483;
wall_thickness = 10;

room_length = door_to_window + window_width + window_to_end + wall_thickness;
room_width = 320 + 120 + 82;

window_offset = door_to_window + window_width;

stone_floor();
tv_wall();
piano_wall();
garden_wall();
// kitchen_wall();
// kitchen();
furniture();

// toys(window_offset);
av(window_offset, window_to_end);

module stone_floor() {
  translate([0, 0, -5])
    color("GhostWhite") cube([room_width, room_length, 5]);
}

module tv_wall() {
  // Left Wall part
  color("AntiqueWhite") cube([wall_thickness, door_to_window, wall_height]);

  // Wall part above window
  translate([0, door_to_window, window_height])
    color("AntiqueWhite") cube([wall_thickness, window_width, 30]);

  // Big wall part
  translate([0, door_to_window + window_width, 0])
    color("AntiqueWhite") cube([wall_thickness, window_to_end, wall_height]);

  pictures(window_offset);
}

module piano_wall() {
  // Left Wall part
  translate([wall_thickness, 0, 0]) color("AntiqueWhite") cube([33, wall_thickness, wall_height]);
  translate([wall_thickness + 33, 0, 200]) color("AntiqueWhite") cube([83, wall_thickness, 50]);
  translate([wall_thickness + 33 + 83, 0, 0]) color("AntiqueWhite") cube([310, wall_thickness, wall_height]);
}

module garden_wall() {
  // Side wall part
  translate([0, door_to_window + window_width + window_to_end, 0]) color("AntiqueWhite") cube([63, wall_thickness, wall_height]);
  translate([63, door_to_window + window_width + window_to_end, window_height]) color("AntiqueWhite") cube([320, wall_thickness, 30]);
  translate([63 + 320, door_to_window + window_width + window_to_end, 0]) color("AntiqueWhite") cube([120, wall_thickness, wall_height]);
}

module kitchen_wall() {
  // Back wall
  translate([wall_thickness + 33 + 83 + 310, 0, 0]) color("AntiqueWhite") cube([85, door_to_window + window_width + window_to_end - 370, wall_height]);
}

module kitchen() {
  // Kitchen
  translate([wall_thickness + 33 + 83 + 310 + 30, door_to_window + window_width + window_to_end - 370, 0]) color("AntiqueWhite") cube([85 - 30, 370 - 97, 93]);
  translate([wall_thickness + 33 + 83 + 310, door_to_window + window_width + window_to_end - 370, 93 - 4]) color("AntiqueWhite") cube([30, 370 - 97, 4]);
  translate([wall_thickness + 33 + 83 + 310, door_to_window + window_width + window_to_end - 97 - 4, 0]) color("AntiqueWhite") cube([30, 4, 93]);
}

module pictures(start) {
  picture_height = 60;
  picture_width = 80;
  picture_floor = 146;
  picture_window = 53;

  // Left Picture Frame
  translate([wall_thickness, start + picture_window, picture_floor]) {
    color("DimGray") cube([5, picture_width, picture_height]);

    // Right Picture Frame
    translate([0, picture_width + 32, 0])
      color("DimGray") cube([5, picture_width, picture_height]);
  }
}

module furniture() {
  // Drinks
  translate([wall_thickness + 33 + 83 + 310 - 122, wall_thickness, 0]) color("DarkGoldenrod") cube([122, 50, 170]);

  // Piano
  translate([wall_thickness + 33 + 83 + 310 - 122 - 140 - 5, wall_thickness, 0]) color("Black") cube([140, 50, 90]);

  // Stuff
  translate([wall_thickness + 33 + 83 + 310 - 50, 100, 0]) color("DarkGoldenrod") cube([50, 240, 85]);

  // Table
  translate([200, 150, 0]) {
    color("Wheat") cube([95, 165, 78]);

    // Chairs
    translate([95, 10, 0]) color("Burlywood") cube([60, 50, 100]);
    translate([95, 165 - 10 - 50, 0]) color("Burlywood") cube([60, 50, 100]);

    translate([-60, 10, 0]) color("Burlywood") cube([60, 50, 100]);
    translate([-60, 165 - 10 - 50, 0]) color("Burlywood") cube([60, 50, 100]);
  }
}

module toys(start) {
  mat_width = 200;
  mat_height = 5;
  mat_depth = 100;

  ikea_part_width = 31;
  ikea_depth = 43;
  ikea_total = ikea_part_width * 3;

  // wall_offset = wall_thickness;
  wall_offset = 200;

  // Play mat
  translate([wall_offset, start, 0])
    color("SeaGreen") cube([mat_depth, mat_width, mat_height]);

  // Ikea speelgoed
  translate([wall_offset, start + mat_width - ikea_total, mat_height]) {
    union() {
      color("Goldenrod") cube([ikea_depth, ikea_part_width, 40]);

      translate([0, ikea_part_width, 0])
        color("Goldenrod") cube([ikea_depth, ikea_part_width, 65]);

      translate([0, ikea_part_width * 2, 0])
        color("Goldenrod") cube([ikea_depth, ikea_part_width, 90]);
    }
  }
}

module av(start, available) {
  speaker_depth = 46;
  speaker_width = 33;
  speaker_height = 116;

  subwoofer_depth = 53;
  subwoofer_width = 43;
  subwoofer_height = 55;

  tv_depth = 35;
  tv_width = 150;
  tv_height = 85;

  lp_depth = 40;
  lp_width = 48;
  lp_height = 20;

  preamp_depth = 16;
  preamp_width = 20;
  preamp_height = 6;

  av_depth = 40;
  av_width = 44;
  av_height = 20;

  center_depth = 40;
  center_width = 75;
  center_height = 23;

  ps_depth = 30;
  ps_width = 32;
  ps_height = 6;

  nuc_depth = 24;
  nuc_width = 17;
  nuc_height = 6;

  eye_height = 97.5;
  tv_center = tv_height / 2;
  tv_floor = eye_height - tv_center;

  safety_depth = 20;
  furniture_depth = safety_depth + max(
    av_depth,
    center_depth,
    lp_depth,
    preamp_depth,
    ps_depth,
    nuc_depth);

  safety_height = 5;
  audio_width = center_width + av_width + 30;
  audio_height = safety_height + max(center_height, av_height);

  metal_bars_width = 8;
  furniture_width = max(
    20 + tv_width + 60 + lp_width + 20 + preamp_width + 20,
    audio_width)
    - metal_bars_width
    - metal_bars_width;

  floor_furniture_spacing = 11;

  furniture_center = furniture_depth / 2;
  furniture_height = max(
    tv_floor,
    audio_height) - floor_furniture_spacing;

  total_width =
    speaker_width + 10 + furniture_width + 10 + subwoofer_width + 5 + speaker_width;

  // Possible furniture
  translate([wall_thickness, start + available / 2 - total_width / 2 + speaker_width + 10, 0]) {
    start_av_pieces = floor_furniture_spacing + furniture_height / 2 - audio_height / 2;
    top_height = start_av_pieces - floor_furniture_spacing;
    wood_height = top_height / 8 * 3;
    metal_height = top_height / 8 * 5;

    lp_start = 20;
    av_start = lp_start + lp_width / 2 - av_width / 2;

    door_depth = 4;
    door_open = true;
    $t = 0; // This is passed in from AutoCad 0-1
    door_percentage_open = $t * 100;
    spacer_width = 5;
    union () {
      spacer_start = round((furniture_width - metal_bars_width - metal_bars_width) / 100 * 40);
      door_width = spacer_start - metal_bars_width + spacer_width;

      // Now 58
      echo ("Meubel Width: ", furniture_width, ", Meubel Height: ", furniture_height + floor_furniture_spacing, "Meubel Depth: ", furniture_depth);
      echo ("Height plate: ", top_height);
      echo ("Height wood plate: ", wood_height);
      echo ("Height metal plate: ", metal_height);
      echo ("Metal width: ", metal_bars_width);
      echo ("Furniture width - metal: ", furniture_width - metal_bars_width - metal_bars_width);

      echo ("AV width: ", spacer_start);
      echo ("Spacer width: ", spacer_width);
      echo ("Speaker width: ", furniture_width - metal_bars_width - metal_bars_width - spacer_start - spacer_width);
      echo ("Door width: ", door_width);
      echo ("Door depth: ", door_depth);

      color("OrangeRed") {
        translate([0, metal_bars_width, floor_furniture_spacing + metal_height]) cube([furniture_depth, furniture_width - metal_bars_width - metal_bars_width, wood_height]);
        translate([0, metal_bars_width, start_av_pieces]) cube([20, furniture_width - metal_bars_width - metal_bars_width, furniture_height - top_height - top_height]);
        translate([0, 0, start_av_pieces + audio_height + metal_height]) cube([furniture_depth, furniture_width, wood_height]);

        translate([0, spacer_start, start_av_pieces]) cube([furniture_depth - door_depth, spacer_width, furniture_height - top_height - top_height]);
      }

      if (!door_open) {
        color("OrangeRed")
        translate([furniture_depth - door_depth, metal_bars_width, start_av_pieces])
        cube([door_depth, door_width, furniture_height - top_height - top_height]);
      }

      if (door_open) {
        color("OrangeRed")
        translate([furniture_depth - door_depth, metal_bars_width + ((door_width - spacer_width) / 100 * door_percentage_open), start_av_pieces])
        cube([door_depth, door_width, furniture_height - top_height - top_height]);
      }

      echo ("Spacing floor: ", floor_furniture_spacing);
      echo ("Audio Space: ", audio_height);

      color("Black") {
        translate([0, 0, 0]) cube([furniture_depth, metal_bars_width, furniture_height + floor_furniture_spacing - top_height]);
        translate([0, furniture_width - metal_bars_width, 0]) cube([furniture_depth, metal_bars_width, furniture_height + floor_furniture_spacing - top_height]);

        translate([0, 0, start_av_pieces + audio_height]) cube([furniture_depth, furniture_width, metal_height]);
        translate([0, metal_bars_width, floor_furniture_spacing]) cube([furniture_depth, furniture_width - metal_bars_width - metal_bars_width, metal_height]);
      }
    }

    // Left Speaker
    translate([furniture_center - speaker_depth / 2, -speaker_width - 10, 0])
      color("SaddleBrown") cube([speaker_depth, speaker_width, speaker_height]);

    // Subwoofer
    translate([furniture_center - subwoofer_depth / 2, furniture_width + 10, 0])
      color("Snow") cube([subwoofer_depth, subwoofer_width, subwoofer_height]);

    // Right Speaker
    translate([furniture_center - speaker_depth / 2, furniture_width + 10 + subwoofer_width + 5, 0])
      color("SaddleBrown") cube([speaker_depth, speaker_width, speaker_height]);

    // TV should not be higher than this line
    translate([-20, 0, tv_floor - 5])
      color("Red") cube([5, furniture_width, 5]);

    // TV
    tv_start = furniture_width - tv_width - 20;
    translate([furniture_center - tv_depth / 2, tv_start, furniture_height + floor_furniture_spacing])
      color("Gold") cube([tv_depth, tv_width, tv_height]);

    // Record Player
    translate([furniture_center - lp_depth / 2, lp_start, furniture_height + floor_furniture_spacing])
      color("Maroon") cube([lp_depth, lp_width, lp_height]);

    // Phono Preamp
    translate([furniture_center - preamp_depth / 2, lp_start + lp_width + 5, furniture_height + floor_furniture_spacing])
      color("Sienna") cube([preamp_depth, preamp_width, preamp_height]);

    // AV Receiver
    translate([furniture_depth - av_depth - door_depth, av_start, start_av_pieces])
      color("Silver") cube([av_depth, av_width, av_height]);

    // Center Speaker
    translate([furniture_depth - center_depth - door_depth, tv_start + tv_width / 2 - center_width / 2, start_av_pieces])
      color("Snow") cube([center_depth, center_width, center_height]);

    // NUC Stand
    ps_spacer_width = 1.5;
    ps_spacing_top = 3;
    union () {
      translate([0, av_start + av_width + 5, start_av_pieces])
        color("OrangeRed") cube([furniture_depth - door_depth, ps_spacer_width, ps_height + ps_spacing_top + ps_spacer_width]);

      translate([0, av_start + av_width + 5 + ps_spacer_width + 2 + ps_width + 2, start_av_pieces])
        color("OrangeRed") cube([furniture_depth - door_depth, ps_spacer_width, ps_height + ps_spacing_top + ps_spacer_width]);

      translate([0, av_start + av_width + 5 + ps_spacer_width, start_av_pieces + ps_height + ps_spacing_top])
        color("OrangeRed") cube([furniture_depth - door_depth, 2 + ps_width + 2, ps_spacer_width]);
    }

    // Playstation
    translate([furniture_depth - ps_depth - door_depth, av_start + av_width + 5 + ps_spacer_width + 2, start_av_pieces])
      color("Crimson") cube([ps_depth, ps_width, ps_height]);

    // NUC
    translate([furniture_depth - nuc_depth - door_depth, av_start + av_width + 5 + ps_spacer_width  + ((2 + ps_width + 2) / 2) - (nuc_width / 2), start_av_pieces + ps_height + ps_spacing_top + ps_spacer_width])
      color("Indigo") cube([nuc_depth, nuc_width, nuc_height]);
  }
}
