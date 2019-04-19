rm(list=objects())
library("rpostgis")
library("sp")
library("rasterVis")

RPostgreSQL::dbConnect(drv = "PostgreSQL",user="guido",host="localhost",port=5432,dbname="asiispra")->asiCon
rpostgis::pgGetGeom(conn=asiCon,name=c("centraline","pm10_con_dati"))->centraline
dbDisconnect(asiCon)

RPostgreSQL::dbConnect(drv = "PostgreSQL",user="guido",host="localhost",port=5432,dbname="italia")->italiaCon
rpostgis::pgGetGeom(conn=italiaCon,name=c("vgriglia","regioni"))->regioni
rpostgis::pgGetGeom(conn=italiaCon,name=c("vgriglia","mondo"))->mondo
dbDisconnect(italiaCon)

cairoDevice::Cairo(width=14,height = 14,surface="pdf",filename="centraline.pdf")
plot(regioni,bg="#CCCCCC")
points(centraline,pch=21,bg="red",cex=0.7)
points(centraline,pch=".")
dev.off()
