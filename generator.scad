$fa = 5;

filename = "input";
file = filename;
mirrored = true;

h_inner = 12;
base_offset = 2;


outer_gap = .5;
is_rounded = true;


inner = str(file, ".svg");
filled = str(file, "-fill.svg");

module import_svg(file) {
    scale([mirrored ? -1 : 1, 1, 1])
    import(file, center = true, $fa = 5);
}


module offsetFilled(off) {
    offset(off)
    import_svg(filled);
}

module offsetThin(off, thickness) {
    difference() {
       offsetFilled(off + thickness);
       offsetFilled(off);
    }
}

/*********/
/* INNER */
/*********/
handle_radius = 12;
handle_depth = h_inner / 2 - 2;

module inner_base() {
    union() {
        difference() {
            linear_extrude(h_inner / 2)
                offsetFilled(base_offset);
            translate([0, 0, -0.001])
            cylinder(
                handle_depth,
                handle_radius,
                handle_radius / 1.5
            );
        }
        translate([0, 0, handle_depth / 2])
            cube([
                handle_radius*2,
                2,
                handle_depth
            ], center = true);
   }
}

module inner() {
    union() {
        // detail
        translate([0,0, h_inner / 2.5 - 0.001])
            linear_extrude(h_inner / 2.5)
            offset(r = 0.01)
            import_svg(inner);

        // base
        inner_base();
    }
}

/*********/
/* Outer */
/*********/
gap = outer_gap + base_offset;
handle_height = 2 * h_inner / 3;

module outer() {
    union() {
        // cutter
        linear_extrude(handle_height * 1.8)
            offsetThin(gap, .5);

        // handle
        linear_extrude(handle_height / 2)
            offsetThin(gap, 3);

        // rounded handle
        if (is_rounded) {
            for (i = [0:0.1:1.4]) {
                translate([0, 0, handle_height / 2 + i])
                    linear_extrude(.5)
                    offsetThin(gap, 3 - i*i);
            }
        } else {
            translate([0, 0, handle_height / 2])
                linear_extrude(1.4)
                offsetThin(gap, 3);
        }
    }
}

inner();
outer();

