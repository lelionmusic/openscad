caps_width = 76;
inner_length = 233;
inner_width = 81;
inner_height = 10.5;
inner_delta = inner_width - caps_width;
total_h = 18.5;
bot_h = 2;
plate_h = 1.6;

side_border = 3;
top_border = 12;
bottom_border = 6;

hug = 2.5;
tolerance = 1;

length = inner_length + 2*side_border;
width = inner_width + top_border + bottom_border;
height = inner_height + 7;

min_h = 1; //thinnest point inside corner near bottom/front. in reality is around 2mm

angle = 8;

module keycaps() {
    color("Linen")
    for (i = [0 : 11]) {
        translate([i*19,0,0])
        rotate(angle, [1,0])
        translate([15,37+38,20])
        rotate(90, [1,0])
        import("1x1 R3.stl", convex=5);
    }

    color("Linen")
    for (i = [0 : 11]) {
        translate([i*19,0,0])
        rotate(angle, [1,0])
        translate([15,37+19,20])
        rotate(90, [1,0])
        import("1x1 R2.stl", convex=5);
    }

    color("Linen")
    for (i = [0 : 11]) {
        translate([i*19,0,0])
        rotate(angle, [1,0])
        translate([15,37,20])
        rotate(90, [1,0])
        import("1x1 R1.stl", convex=5);
    }

    color("Linen")
    for (i = [0 : 4]) {
        translate([i*19,0,0])
        rotate(angle, [1,0])
        translate([148,18,20])
        rotate(90, [1,0])
        import("1x1 R1.stl", convex=5);
    }

    color("Linen")
    for (i = [0 : 4]) {
        translate([i*19,0,0])
        rotate(angle, [1,0])
        translate([15,18,20])
        rotate(90, [1,0])
        import("1x1 R1.stl", convex=5);
    }

    color([0.91,0.769,0.722])
    translate([i*19,0,0])
    rotate(angle, [1,0])
    translate([119.5,18,20])
    rotate(90, [1,0])
    import("1x2 R1.stl", convex=5);
}

module guidelines() {
    color("Gray")
    rotate(angle, [1,0])
    translate([side_border, bottom_border, min_h])
    translate([length-2*side_border,width-top_border-bottom_border])
    rotate(180, [0,0,1])
    %import("lo-pro-bottom.stl", convexity=10);

    color("Silver")
    rotate(angle, [1,0])
    translate([side_border+2.5, bottom_border+2.4, min_h+inner_height+0.95])
    translate([0,76,0.03])
    rotate(-90, [1,0])
    rotate(180, [1,0,0])
    translate([43.6046,0,125.939])
    import("hi-pro-plate-mx.stl", convexity=10);
}

module cut_inner() {
    rotate(angle, [1,0])
    translate([side_border, bottom_border, min_h])
    cube([inner_length, inner_width, inner_height+3-bot_h+plate_h]);

    rotate(angle, [1,0])
    translate([side_border+hug, bottom_border+hug, min_h+5])
    cube([inner_length-hug*2, inner_width-hug*2, inner_height*2]);

    rotate(angle, [1,0])
    translate([37,inner_width, 1])
    cube([13, 100, 10]);

    // Screw holes
    rotate(angle, [1,0]) {
        translate([3,inner_width+bottom_border+top_border-3, -height+3.5])
        cylinder(height+bot_h+min_h, 0.75);
        translate([inner_length+side_border,inner_width+bottom_border+top_border-3, -height+3.5])
        cylinder(height+bot_h+min_h, 0.75);
        translate([3,3, -1])
        cylinder(8, 0.75);
        translate([inner_length+side_border,3, -1])
        cylinder(8, 0.75);
    }
}


module top_piece() {
    difference() {
        translate([0,0,bot_h+2])
        rotate(angle, [1,0])
        cube([length, width, total_h-bot_h]);
        /* translate([0,0,bot_h+2]) */
        cut_inner();
    }
}

module bottom_piece() {
    difference() {

        difference() {
            // bottom
            translate([0,0,-total_h])
                translate([0,0,total_h+bot_h+2])
                rotate(angle, [1,0])
                translate([0,0,-total_h-bot_h-2])
                    cube([length, width, total_h+bot_h+2]);
            cut_inner();
        }

        // cut below xy-plane
        translate([-length/2,-width/2,-total_h*2])
            cube([length*2,2*width,total_h*2]);
    }
}

guidelines();
color([0.337,0.322,0.306])
top_piece();
color([0.91,0.769,0.722])
bottom_piece();
keycaps();
/* %cut_inner(); */

