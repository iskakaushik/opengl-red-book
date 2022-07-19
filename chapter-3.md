## July 19, 2022 - Drawing with OpenGL

## OpenGL Graphics Primitives

### Points

* Single vertex - 4 dimesntional.
* Rasterization rules is to rasterize all the fragments within a fixed square centered around the point, with size as `glPointSize()`.
* `gl_PointCoord` built-in variable for sue in fragment shaders.

### Lines

* Closed is line loop, broken is line-strip.
* Rasterization rule is diamond-exit. (TODO: learn later)
* `glLineWidth()` to specify the width of a line.

### Triangles

* Collection of 3 vertices.
* Can be strips or fans.

### Polygons

* Has two sides, front and back, can be rendered differently.
* Draw mode can be GL_POINT, GL_LINE or GL_FILL to get different outputs.
* TODO - look at polygon faces in a little more details
  - glCullFace
  - GL_CW and GL_CCW

## Data in OpenGL Buffers

* First have to create a buffer object using `glCreateBuffers`, to get buffer names or ids - `GLuint` typed.
* No storage associated until `glNamedBufferStorage` is called with the id. There are several flags to indicate what the storage is meant for.
* After allocation is complete, you can then bing to a target. Example targets: GL_ARRAY_BUFFER, GL_PIXEL_PACK_BUFFER, GL_UNIFORM_BUFFER, etc. This is doing using `glBindBuffer`.
* `glNamedBufferSubData` can be used to upload part of the data. There are also `glClearNamedBufferData` and `glClearNamedBufferSubData`.
* There is also `glCopyNamedBufferSubData` to copy data from source to dest device memory.
* `glGetNamedBufferSubData`  can be used to retrieve device memory to host.

### Accessing Content of Buffers

* glNamedBufferSubdata -  copies from host to device
* glCopyNamedBufferSubData - copies from device to device
* glGetNamedBufferSubData - copy from device to host.

All the above do copies of some kind.

* `glMapBuffer` - maps device address to host, gives a pointer to the device memory to be readily consumed by host, returns NULL when OpenGL is unable to map the data.

## Vertex Specification

## OpenGL Drawing Commands
