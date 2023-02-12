from map import tab
import json

TABLE_FRAME_COUNT = 1
TABLE_FRAME_WIDTH = 32
TABLE_FRAME_HEIGHT = 23
BLACK_PIXEL = 1


class PiskelMapToJSOn:

    def __init__(self, tab, width, height):
        self.tab = tab
        self.width = width
        self.height = height

    def display_tab(self):
        for row in range(self.height):
            for col in range(self.width):
                index = row * self.width + col
                if self.tab[index] == BLACK_PIXEL:
                    print("X", end="")
                else:
                    print("0", end="")
            print()
        print()

    def extract_rectangles(self):
        rectangles = []
        for row in range(self.height):
            start_col = None
            end_col = None
            for col in range(self.width):
                index = row * self.width + col
                if self.tab[index] == BLACK_PIXEL:
                    self.tab[index] = 0
                    if start_col is None:
                        start_col = col
                    end_col = col
                if start_col is not None and self.tab[index] != BLACK_PIXEL:
                    new_rectangle = {"x": start_col, "y": row, "width": end_col - start_col + 1, "height": 1}
                    rectangles.append(new_rectangle)
                    start_col = None
                    end_col = None
        print("Number of rectangle found during extraction : " + str(len(rectangles)))
        return rectangles

    def merge_rectangles(self, rectangles):
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
        print("Number of rectangle before the merge : " + str(len(rectangles)) + " number of rectangle after : " + str(len(merged_rectangles)))
        return merged_rectangles

    def merge_rectangles_x(self, rectangles):
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
        print("Number of rectangle before second merge : " + str(len(rectangles)) + " number of rectangle after : " + str(len(merged_rectangles)))
        return merged_rectangles

    def write_json(self, rectangles):
        with open("rectangles.json", "w") as f:
            json.dump(rectangles, f, indent=4)

    def run(self):
        rectangles = self.extract_rectangles()
        rectangles = self.merge_rectangles(rectangles)
        rectangles = self.merge_rectangles_x(rectangles)
        self.write_json(rectangles)


if __name__ == "__main__":
    extractor = PiskelMapToJSOn(tab, TABLE_FRAME_WIDTH, TABLE_FRAME_HEIGHT)
    extractor.run()
