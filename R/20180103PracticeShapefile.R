# load up area shape file:
library(maptools)
area <- readShapePoly("ne_10m_parks_and_protected_lands_area.shp")

# # or file.choose:
# area <- readShapePoly(file.choose())

library(RColorBrewer)
colors <- brewer.pal(9, "BuGn")

library(ggmap)

mapImage <- get_googlemap(center=c(lon = 126.993658, lat = 37.550048),
                          zoom=12, size=c(640,480),
                          maptype="roadmap")

## area를 data.frame으로 변환
area.points <- fortify(area)

ggmap(mapImage) +
  geom_polygon(aes(x = long,
                   y = lat,
                   group = group),
               data = area.points,
               color = colors[9],
               fill = colors[6],
               alpha = 0.5) +
  labs(x = "Longitude",
       y = "Latitude")
