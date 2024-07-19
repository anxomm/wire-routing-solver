# Wire routing

## Introduction

The [Wire routing](https://www.dc.fi.udc.es/~cabalar/kr/2019/ex2.html) problem consists in joining pairs of points with a continuous line that does not intersect with lines for other pairs. This project includes an automatic solver to solve any NxM grid of this game.

## Encoder

First of all, we encode the grid defined in a text file by running the following command:

```
python3 src/encoder.py < input.txt > input.lp
```

The input must define the grid as a sequence of rows of the same dimension, each with cells that can take the value '#' for obstacles, a letter for a point of certain pair, or '.' for empty cells. The first two lines define the height and width of the grid. Some examples are provided in the [test](test/) folder.

## Solver

After encoding the grid just run the following command to generate the solution:

```
python3 src/decoder.py src/wire.lp input.lp > output.txt
```