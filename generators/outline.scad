$fa = 5;

filename = "input";
file = filename;
mirrored = true;

h_inner = 12;

is_rounded = true;

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
/* Outer */
/*********/
gap = 0;
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

outer();

