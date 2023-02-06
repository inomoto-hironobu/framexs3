@echo off
if not [%2%]==[] (
set param="%2=%3"
)
java -jar saxon-he-10.8.jar -s:%1 -xsl:%1 -o:out/out.txt %param%