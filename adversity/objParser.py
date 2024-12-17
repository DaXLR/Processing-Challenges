import os


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


input_folder_path = "objects"
output_folder_path = "objects"

file_counter = 1

for file_name in os.listdir(input_folder_path):
    if file_name.endswith(".obj"):
        input_file_path = os.path.join(input_folder_path, file_name)
        output_file_name = f"{file_counter}.csv"
        output_file_path = os.path.join(output_folder_path, output_file_name)

        vertices = parse_obj_file(input_file_path)

        with open(output_file_path, "w", newline="") as file:
            for vertex in vertices:
                file.write(f"{vertex[0]},{vertex[1]},{vertex[2]}\n")

        file_counter += 1
