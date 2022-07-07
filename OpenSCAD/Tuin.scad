wall_height = 230;
wall_length = 500;
sidewalk_width = 118;
green_width = 127;
hedge_height = 220;

poles = 5;
pole_height = 300;
start_pole = 20;

building();
sidewalk();
grass();
hedge();
poles();
load_bearers();
roof();

module building() {
  translate([0, 0, -5])
    color("GhostWhite") cube([5, wall_length, wall_height + 5]);

  translate([0, wall_length - 5, -5])
    color("GhostWhite") cube([100, 5, wall_height + 5]);
}

module sidewalk() {
  translate([-sidewalk_width, 0, -5])
    color("Grey") cube([sidewalk_width, wall_length, 5]);

  translate([-sidewalk_width, wall_length, -5])
    color("Grey") cube([sidewalk_width + 100, sidewalk_width, 5]);
}

module grass() {
  translate([-green_width - sidewalk_width, 0, -5])
    color("Green") cube([green_width, wall_length, 5]);

  translate([-green_width - sidewalk_width, wall_length, -5])
    color("Green") cube([green_width, 200, 5]);

  translate([-green_width - sidewalk_width, wall_length, -5])
    color("Green") cube([green_width, 200, 5]);

  translate([-sidewalk_width, wall_length + sidewalk_width, -5])
    color("Green") cube([sidewalk_width + 100, 82, 5]);
}

module hedge() {
  translate([-green_width - sidewalk_width - 5, 0, -5])
    color("DarkGreen") cube([5, wall_length, hedge_height + 5]);

  translate([-green_width - sidewalk_width - 5, wall_length, -5])
    color("DarkGreen") cube([5, 200, hedge_height + 5]);
}

module poles() {
  margins = start_pole * 2;
  spread_over = wall_length - margins;
  interval = spread_over / (poles - 1);

  for (i = [0:interval:spread_over]) {
    translate([-green_width - sidewalk_width + 10, start_pole + i, -1 * (hedge_height - pole_height + 10)])
      color("Brown") cylinder(h=pole_height, r=5, center=true, $fn=25);
  }

  translate([-sidewalk_width - 10, start_pole, -1 * (hedge_height - pole_height + 10)])
    color("Brown") cylinder(h=pole_height, r=5, center=true, $fn=25);

  translate([-sidewalk_width - 10, wall_length - start_pole, -1 * (hedge_height - pole_height + 10)])
    color("Brown") cylinder(h=pole_height, r=5, center=true, $fn=25);
}

module load_bearers() {
  translate([-5, 10, wall_height - 20])
    color("Brown") cube([5, wall_length - 20, 20]);

  translate([-green_width - sidewalk_width, 10, hedge_height - 20])
    color("Brown") cube([5, wall_length - 20, 20]);

  translate([-sidewalk_width - green_width + 6, 10, wall_height - 20 - 10])
  rotate([0,-2.5,0])
    color("Blue") cube([sidewalk_width + green_width - 10, 5, 20]);

  margins = start_pole * 2;
  spread_over = wall_length - margins;
  interval = spread_over / (poles - 1);

  for (i = [start_pole + interval:interval:spread_over + interval]) {
    translate([-sidewalk_width - green_width + 6, i - (interval / 2), wall_height - 20 - 10])
    rotate([0,-2.5,0])
      color("Blue") cube([sidewalk_width + green_width - 10, 5, 20]);
  }

  translate([-sidewalk_width - green_width + 6, wall_length - 15, wall_height - 20 - 10])
  rotate([0,-2.5,0])
    color("Blue") cube([sidewalk_width + green_width - 10, 5, 20]);
}

module roof() {
  translate([-sidewalk_width - green_width, 0, wall_height - 10])
  rotate([0,-2.5,0])
    color([1,1,1,0.8]) %cube([sidewalk_width + green_width, wall_length, 2]);
}
