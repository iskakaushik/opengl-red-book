# July 11, 2022 - Chapter 1: Introduction to OpenGL

### Starting Point

* We have a scene description
  - How do you describe the scene
* Convert the scene description into pixels
  - How do you do it efficiently

### Client vs Server

* Code we write is the client
* Manufacturer of the hardware implements the server (black-box)
* Host (CPU) vs Device (GPU)

### Rendering Stages

1. Vertex Data
  - i/o: named buffer arrays
2. Vertex Shader
  - i: vertex structures
  - o: shaded vertex structures, shaded meaning some function is applied per vertex.
  - note: only one vertex shader can be active at any given time.
3. Tessellation Control Shader
4. Tessellation Evaluation Shader
  - i: shaded vertex structures
  - o: tesselated structures a.k.a geometric structs
  - Notes:
    * looks like this stage is to improve the appearance of the models.
    * TODO: not really clear, something patched geometries
5. Geometry Shader
  - i: tessellated structures / geom structs
  - o: shaded geom structs
6. Primitive Setup / Assembly
  - i: shaded geom structs
  - o: grouped geom structs (spatially) to make clipping easier
7. Clipping and Culling
  - i: grouped geom structs
  - o: clipped geom structs
  - notes:
    * viewport is whats visible to the user
    * things failling outside of viewport aren't permitted to be drawn.
    * i.e, things are clipped.
8. Rasterization
  - i: clipped geom structs
  - o: fragment data
    * fragment is a "candidate pixel"
    * interpolated based on the fragment shader? variables in fragment shader are interpolated.
    * Is rasterization aware of the fragment shader?
    * Interpolation is platform dependent.
9. Fragment Shader
  - i: fragment data
  - o: colored fragments

> “A helpful way of thinking about the difference between shaders that
deal with vertices and fragment shaders is this: vertex shading (including
tessellation and geometry shading) determines where on the screen a primitive
is, while fragment shading uses that information to determine what color that
fragment will be.”

10. Per-Fragment Operations
  - i: colored fragments
  - o: pixel data stored to a texture
  - notes:
    * depth testing a.k.a z-buffering
    * stencil testing
    * blending

### Example (unclear if this is true)

```
Stage 1:

[
  {1, 2},
  {4, 5},
  {9, 10}
]

Stage 2:

shader_fn : f(x, y) = (x^2 + 1, y^2 + 1)

[
  {2, 5},
  {17, 28},
  {82, 101},
]

Stage 3,4:

t(x, y) = [ (x - 1, y - 1), (x, y), (x + 1, y + 1) ]

[
  [
    {1, 4},
    {2, 5},
    {3, 6}
  ],
  [...],
  [...]
]

Stage 5:

g([(x_i, y_i)]) = [ cyclical sum with next index ] 

[
  [
    {3, 9},
    {5, 11},
    {4, 10}
  ],
  [...],
  [...]
]

Stage 9:

give color to pixels
    
```


# Resources

1. [Red Book](https://www.oreilly.com/library/view/opengl-programming-guide/9780134495514/)

