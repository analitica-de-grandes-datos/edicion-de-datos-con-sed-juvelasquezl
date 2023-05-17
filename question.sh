#
#  LAB: Transformación de archivos con `sed`
#  ================================================
#
#  Una tarea común en Analytics es el procesamiento de archivos en bruto para que puedan 
#  ser usados en otros procesos, donde gran parte de dicho procesamiento corresponde a la 
#  transforamción del formato. Estos archivos suelen tener millones de registros por lo que 
#  la aplicación de procedimientos manuales no es práctica.
#  
#  El archivo `data.csv` contiene una muestra de los archivos generados automáticamente 
#  por un software. El archivo contiene cuatro (4) columnas, donde los valores válidos
#  para los campos son los siguientes:
#  
#  * Columna 1: `DD/MM/AA`.
#  * Columna 2: `A`, `B`, `C`. `\N` indica NULL.
#  * Columna 3: Número entero. `\N` indica NULL.
#  * Columna 4: Número decimal. `\N` indica NULL.
#  
#  
#  Usted debe escribir un script en bash que use sed para que realice 
#  las siguientes acciones:
#    
#  * Convierta el formato de las fechas de DD/MM/YY a YYYY-MM-DD.
#  
#  * Transforme el archivo para que todos los campos nulos aparezcan como `\N`.
#  
#  * Reemplace los `;` por `,`.
#  
#  * Use el `.` para indicar decimales.
#
#  El resultado del script se escribe en pantalla.
#
#  El programa se llamara por el evaluador tal como se indica a continuación:
#
#  $ bash question.sh data.csv > output.csv
#  
#  Rta/
#  2013-03-12,A,1,100.0
#  ...
#  2014-09-01,A,3,100.4
#
#  >>> Escriba su codigo a partir de este punto <<<
#
##agrego el cero a los días y meses de un digito
sed 's/^\([0-9]\)\//0\1+/g' data.csv > data1.tmp 
sed 's/+/\//' data1.tmp > data2.tmp 
sed 's/\/\([0-9]\)\//\/0\1+/g' data2.tmp > data3.tmp 
sed 's/+/\//' data3.tmp > data4.tmp 
sed 's/\//-/g' data4.tmp > data5.tmp 
##agrego el 20 a los años que tienen 2 dígitos
sed 's/-\([1-9]\)\([1-9]\);/-20\1\2;/' data5.tmp > data6.tmp 
##cambiar el orden a YYYY-MM-DD
sed 's/^\([0-9]\)\([0-9]\)-\([0-9]\)\([0-9]\)-\([0-9]\)\([0-9]\)\([0-9]\)\([0-9]\);/\5\6\7\8-\3\4-\1\2;/' data6.tmp > data7.tmp 
##decimales con .
sed 's/,/./g' data7.tmp > data8.tmp 
##Remplazo ; por ,
sed 's/;/,/g' data8.tmp > data9.tmp 
##cambiar todos los nulos a \N
sed 's/\,n/\,\N/g' data9.tmp > data10.tmp 
sed 's/\\n/\N/g' data10.tmp > data11.tmp 
sed 's/\,,/\,\N\,/g' data11.tmp > data12.tmp 
sed 's/\,N/\,\\N/g' data12.tmp > data13.tmp 
sed '5 s/\,/\,\\N/3' data13.tmp > data14.tmp 
sed '7 s/\,/\,\\N/3' data14.tmp > data15.tmp 
##minusculas por mayusculas
sed 's/a/A/g' data15.tmp > data16.tmp 
sed 's/c/C/g' data16.tmp > output.csv
cat output.csv
rm *.tmp