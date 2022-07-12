# July 12, 2022 - Shader Fundamentals

## Shaders and OpenGL - 1:16

* GLSL is the shading language fro OpenGL
* CPU code is written in C++ (or some other cpu programming lang)
* GPU code is written in GLSL.

## OpenGL's Programmable Pipeline - 4:17

* Vertex Shading Stage : Vertex Data
* Tessellation Shading : Attaches additional geometry
* Geometry Shading : Modifies the geometry (can also discard)
* Fragment Shading : Looks at fragments which are interpolated and attaches color.
* Compute Shading : Generic programs that can operate on any stage's outputs.

## An Overview of the Shading Language - 8:14

* Some language constructs shared between multiple stages.
* Some seem to be unique to a specific shading stage.

### GLSL Language Characteristics

1. Typed language, naming convention similar to C.
2. Basic Types are transparent, code can assume the data layout of types.
3. Additional opaque types can also exist
  * sampler types
  * image types
  * atomic counter types
4. Variables are scoped
5. Variables can be initialized when declared. Support octal, decimal and hex
values. Floats MUST include a decimal point.
6. No implicit type conversions like C++, need to call ctor.
7. Aggregate types exist, vec4, mat4, etc.
8. Accessing elements is done through index or component accessor:

```
vec4 color = vec3(12.0, 14.0, 12.0, 0.8);

// valid accessor methods
vec3 luminance = color.rrr;
vec4 color = = color.abgr;

// invalid
vec4 color = othercolor.rgx; // z is in a different accessor group.
```

8. The language has support for structures as well.
```
struct Particle {
  float lifetime;
  vec3 position;
  vec3 velocity;
  float coeff[3]; // supports array types.
}
```

9. Storage qualifiers, const, in, out, uniform, buffer, shared.
10. Operators are overloaded for common basic and aggregate types.
11. if/else, switch and loops are supported.
12. Additional control flow: `break`, `continue`, `return` and `discard`.
13. Extensions can enhance opengl. Vendors may choose to include these.
```
// extension directives

#extensions <ext_name>: <directive>
#extensions all: <directive>

// directives : require, enable, warn, disable,
```

### Computational Invariance - 24:26

* Computations done twice may result in difference of results.
* This might be a problem to multi-pass algorithms.
* `invariant` and `precise` qualifiers exist to avoid this behavior.
* `invariant` can be applied to output variables to guarantee precision.
* `#pragma STDGL invariant(all)` can be useful to impose invariance on all
variables in a shader.
* `precise` similar to invariant but can be applied to any computed variable or return value.
* Guaranteed reproducibility, but time penality.


## Interface Blocks - 30.45

* Blocks are useful to share information between app <-> shaders or shaders <-> shaders.
* Important to be aware of the data layouts.


```
#version 440

layout (std140) uniform b {
    float size;                    // starts at byte 0, by default
    layout(offset=32) vec4 color;  // starts at byte 32
    layout(align=1024) vec4 a[12]; // starts at the next multiple
                                   // of 1024
    vec4 b[12];                    // assigned next offset after a[12]
} buf;

```

## Compiling Shaders - 40:00

### Shader Compilation Pipeline:

**Compilation**

1. Create a shader object
2. Compile the source into the object
3. Verity that the compilation is successful.

**Linking**

1. Create a shader program (different from shader object)
2. Attach shader objects to the shader program.
3. Link the shader program.
4. Verify link success.
5. *PROFIT*


* Shader sources can be re-used across shader programs.
* This is to improve compilation times.

## Shader Subroutines - 44:09

* Similar to function pointers, you can switch calls on `if` or pass the right function pointer.
* Shader subroutines are meant to be used dynamically.
* define a fn with `subroutine` keyword.

```
subroutine vec4 LightFunc(vec3); // takes vec3, returns vec4

subrouting (LightFunc) vec4 ambient(vec3 n) {
  return Materials.ambient;
} 

subrouting (LightFunc) vec4 diffuse(vec3 n) {
  return Materials.diffuse * max(dot(normalize(n),...));
}

// this uniform can be set in the CPU code to be either ambient or diffuse.
// letting us control the `LightFunc` dynamically. 
subrouting uniform LightFunc materialShader; 
```

## Separate Shader Objects - 50:00

* In earlier versons only a single shader program can be bound at one time.
* Inconvenient if app used multiple frag shaders that all used same vertex shader. 
* Instead of linking all the shader sources to a monolith program,
you can have a program pipeline object. This allows changing shaders
to arbitrary program bound to the pipeline.

* shader-pipeline: collection of shader programs all linked.
* multiple pipelines can exist, as of separate shaders being allowed.

## SPIR-V - 59:10

* Alternative way of distributing shaders.
* Rather than GLSL sources, we can distribute SPIR-V output a.k.a generated SPIR-V.
* This is a serializable format, of 32-bit words.
* Can reside in memory or disk.
* It's simple binary form, loses very little information during front-end compilation.

### SPIR-V modules

* Contain multiple entry points.
* Each entry-point knows what OpenGL pipeline stage it belongs to.
* Each entry points must form a single, complete OpenGL pipeline stage.
* These are fully linked programs, that are done by a front-end compiler from a lang such as GLSL.

### Reasons to choose SPIR-V

* Better portability, GLSL is too vague, platform impls chanege widely.
* Language choice. Use GLSL or Metal or other.
* Smaller size.
* Obfuscation, GLSL needs to be sources distributed.

## References

1. [Red Book](https://www.oreilly.com/library/view/opengl-programming-guide/9780134495514/)
2. [ARB_separate_shader_objects](https://www.khronos.org/registry/OpenGL/extensions/ARB/ARB_separate_shader_objects.txt)

