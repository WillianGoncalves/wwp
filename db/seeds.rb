color_list = [
  ["red", "#D32F2F"],
  ["pink", "#F06292"],
  ["purple", "#9C27B0"],
  ["deep_purple", "#5E35B1"],
  ["indigo", "#1A237E"],
  ["blue", "#1976D2"],
  ["light_blue", "#4FC3F7"],
  ["teal", "#00796B"],
  ["green", "#388E3C"],
  ["light_green", "#9CCC65"],
  ["yellow", "#FFEB3B"],
  ["amber", "#FFC400"],
  ["orange", "#EF6C00"],
  ["brown", "#5D4037"]
]

color_list.each do |name, code|
  Color.create(name: name, code: code)
end
