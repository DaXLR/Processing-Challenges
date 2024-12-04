def parse_obj_file(file_path):
    vertices = []
    with open(file_path, "r") as file:
        for line in file:
            if line.startswith("v "):
                parts = line.split()
                vertex = (float(parts[1]), float(parts[2]), float(parts[3]))
                vertices.append(vertex)
    return vertices


def write_vertices_to_file(vertices, output_file_path):
    with open(output_file_path, "w") as file:
        file.write("float[][] vertices = {\n")
        for vertex in vertices:
            file.write(f"  {{ {vertex[0]}, {vertex[1]}, {vertex[2]} }},\n")
        file.write("};\n")


input_file_path = "input.obj"
output_file_path = "output.txt"

vertices = parse_obj_file(input_file_path)
write_vertices_to_file(vertices, output_file_path)
