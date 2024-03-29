#version 440

layout(triangles) in;
layout(triangle_strip, max_vertices=6) out;

#//////////////////////////////////////////////////////////
in vec3 color[];
out vec3 frag_color;

in vec2 texture_coord_vert[];
out vec2 texture_coord_geo;

out vec3 Normal;
out vec3 fragPos;

in mat4 World[];
in mat4 View[];
in mat4 Projection[];

vec3 normal = cross((gl_in[0].gl_Position.xyz - gl_in[1].gl_Position.xyz), (gl_in[0].gl_Position.xyz - gl_in[2].gl_Position.xyz));
#//////////////////////////////////////////////////////////
void main()
{	
  for(int i=0; i<3; i++)
  {
    gl_Position = Projection[i] * View[i] * World[i] * gl_in[i].gl_Position;

	frag_color = color[i];
	fragPos = vec3(World[i] * gl_in[i].gl_Position);
	texture_coord_geo = texture_coord_vert[i];
	Normal = vec3(World[i]*vec4(normal, 1.0f));

    EmitVertex();
  }
  EndPrimitive();
}  
