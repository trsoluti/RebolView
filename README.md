RebolView
=========

An WebKit GUI for Rebol 3

This project connects a Rebol 3 interpreter to a webkit for GUI purposes.

It contains a mechanism to sync the DOM document and a Rebol variable 'document'.

This initial version runs a simple window where you can type Rebol 3 commands,
press Run, and see the output.

For example, typing:

    ?? document

will show the document tree.

Typing

    append document/children/node2/children/node3/children/node2 [attributes: [style: "color:green"]]

will set the colour of the header to green.

