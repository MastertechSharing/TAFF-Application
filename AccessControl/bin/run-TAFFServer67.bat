::set path=C:\Program Files (x86)\Java\jre6\bin\
java -Xmx1024m -Xms512m -XX:NewSize=512m -XX:MaxNewSize=512m -XX:+UseParallelGC -XX:MinHeapFreeRatio=40 -XX:MaxHeapFreeRatio=70 -jar TAFFServer67.jar