# latex-classes

## Files

- `template/` contains the class files (filename extension `.cls`) and the package files (filename extension `.sty`). Include them as desired. Note that the classes already load most of the packages, so there is generally no need to include the packages separately in your LaTeX file.
- `Makefile` is used together with GNU make to manage the compilation
- `latexmkrc` isused to tell the compiler to look for files in the `template` directory. This file is important when using this template with Overleaf. The file is automatically generated, if not present, by the commands `make`, `make debug` and `make latexmkrc`.

## Standard Usage

Rename your main LaTeX file to `index.tex`, move it to the project folder root and copy the folder `template` into the project folder root as well. In `index.tex`, load the desired class (without the path `template` and without the filename extension `.cls`). You can remove class and package files that are not needed. Be careful when removing package files, they might be required by the class in use.

### On a local computer with the GNU make

1. Copy `Makefile` to the project folder root.
2. In the copied `Makefile`, change the variable `NAME` according to the intended use. This will be the name of the output PDF file.

The `make` targets are as follows:

Command              | Result
---------------------|--------
`make`               | Compile the PDf: Create the file `latexmkrc`, a folder `target/` and a subfolder `target/default` that contains the intermediate files from the LaTeX compilation run. The resulting PDF file is copied to `target/<NAME>.pdf`, where `<NAME>` is the name specified in the `Makefile`.
`make debug`         | Compile the PDF with warnings and logs enabled: Create the file `latexmkrc`, a folder `target/` and a subfolder `target/debug` that contains the intermediate files from the LaTeX compilation run. The resulting PDF file is copied to `target/debug.pdf`.
`make clean-default` | Delete folder `target/debug`.
`make clean-debug`   | Delete folder `target/default`.
`make clean`         | Delete folders `target/debug` and `target/default`.
`make purge`         | Delete folder `target`.
`make latexmkrc`     | Generate the file `latexmkrc`.

### Together with Overleaf

1. Copy `latexmkrc` to the project folder root. Overleaf should automatically detect the classes and packages located in `template`.

## Advanced Usage

- You can manually specify the location of the main LaTeX file by changing the variable `TEX_FILE` in `Makefile` to the respective path. If the template folder is at a different location, change the variable `TEMPLATE_DIR` in `Makefile` to the according path.
