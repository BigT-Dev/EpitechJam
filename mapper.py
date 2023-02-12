from map import tab
import json

TABLE_FRAME_COUNT = 1
TABLE_FRAME_WIDTH = 32
TABLE_FRAME_HEIGHT = 23
BLACK_PIXEL = 1

def display_tab(tab, width, height):
    for row in range(height):
        for col in range(width):
            index = row * width + col
            if tab[index] == BLACK_PIXEL:
                print("X", end="")
            else:
                print("0", end="")
        print()
    print()

def extract_rectangles(tab, width, height):
    rectangles = []
    for row in range(height):
        start_col = None
        end_col = None
        for col in range(width):
            index = row * width + col
            if tab[index] == BLACK_PIXEL:
                tab[index] = 0
                if start_col is None:
                    start_col = col
                end_col = col
            if start_col is not None and tab[index] != BLACK_PIXEL:
                new_rectangle = {"x": start_col, "y": row, "width": end_col - start_col + 1, "height": 1}
                rectangles.append(new_rectangle)
                start_col = None
                end_col = None
    print("nb rectangles: " + str(len(rectangles)))
    return rectangles

def merge_rectangles(rectangles):
    merged_rectangles = []
    for rectangle in rectangles:
        merged = False
        for merged_rectangle in merged_rectangles:
            if rectangle["x"] == merged_rectangle["x"] and rectangle["width"] == merged_rectangle["width"] :
                if rectangle["y"] == merged_rectangle["y"] + merged_rectangle["height"]:
                    merged_rectangle["height"] += rectangle["height"]
                    merged = True
                    break
        if not merged:
            merged_rectangles.append(rectangle)
    print("len rectangles: " + str(len(rectangles)) + " len merged_rectangles: " + str(len(merged_rectangles)))
    return merged_rectangles


#write a function to merge the rectangles based on the x and with of the rectangles

def merge_rectangles_x(rectangles):
    merged_rectangles = []
    for rectangle in rectangles:
        merged = False
        for merged_rectangle in merged_rectangles:
            if rectangle["y"] == merged_rectangle["y"] and rectangle["height"] == merged_rectangle["height"] :
                if rectangle["x"] == merged_rectangle["x"] + merged_rectangle["width"]:
                    merged_rectangle["width"] += rectangle["width"]
                    merged = True
                    break
        if not merged:
            merged_rectangles.append(rectangle)
    print("len rectangles: " + str(len(rectangles)) + " len merged_rectangles: " + str(len(merged_rectangles)))
    return merged_rectangles



display_tab(tab, TABLE_FRAME_WIDTH, TABLE_FRAME_HEIGHT)

rectangles = extract_rectangles(tab, TABLE_FRAME_WIDTH, TABLE_FRAME_HEIGHT)
with open("rectangles.json", "w") as f:
    f.write(json.dumps(rectangles, indent=4))

merged_rectangles = merge_rectangles(rectangles)
merged_rectangles = merge_rectangles_x(merged_rectangles)
with open("rectangles_merged.json", "w") as f:
    f.write(json.dumps(merged_rectangles, indent=4))

# write a function to create a tab from the .json file
def create_tab_from_json(json_file):
    with open(json_file, "r") as f:
        rectangles = json.load(f)
    tab = [0] * TABLE_FRAME_WIDTH * TABLE_FRAME_HEIGHT
    for rectangle in rectangles:
        for row in range(rectangle["height"]):
            for col in range(rectangle["width"]):
                index = (rectangle["y"] + row) * TABLE_FRAME_WIDTH + rectangle["x"] + col
                tab[index] = BLACK_PIXEL
    return tab


display_tab(create_tab_from_json("rectangles.json"), TABLE_FRAME_WIDTH, TABLE_FRAME_HEIGHT)
display_tab(create_tab_from_json("rectangles_merged.json"), TABLE_FRAME_WIDTH, TABLE_FRAME_HEIGHT)