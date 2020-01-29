# Aplicaciones de los Momentos Ortogonales
En esta carpeta se incluye un ejemplo de cómo utilizar diferentes familias de momentos ortogonales discretos como descriptores de textura en imágenes. Con dichos descriptores se generarán vectores de características que funcionarán para realizar la clasificación de imágenes dentro de una base de datos.

## Momentos ortogonales discretos
Los momentos discretos son cantidades escalares que se usan para caracterizar una función (imagen) a través del cálculo de atributos significativos de ella. Matemáticamente, el momento Mpq de una Imagen ***I(x,y)*** es la proyección de la imagen sobre una base polinomial bidimensional ***r_pq*** y se define como:

<img src="https://latex.codecogs.com/gif.latex?M_{pq}&space;=&space;\sum_{x=0}^{N-1}&space;\sum_{y=0}^{M-1}&space;r_{pq}(x,y)I(x,y)" title="M_{pq} = \sum_{x=0}^{N-1} \sum_{y=0}^{M-1} r_{pq}(x,y)I(x,y)" />

entonces, el momento es la medida de correlación entre la imagen y la base polinomial.

## Polinomios ortogonales discretos 
Las bases polinomiales discretas utilizadas en este ejemplo son: Tchebichef, Krawtchouk, Dual-Hahn y Shmaliy. Las primeras tres bases son solución a la ecuación en diferencias:

<img src="https://latex.codecogs.com/gif.latex?\sigma(x)&space;\frac{1}{h}&space;\left&space;[&space;\frac{y(x&plus;h)-y(x)}{h}&space;-&space;\frac{y(x)-y(x-h)}{h}&space;\right&space;]&space;&plus;&space;\frac{\tau(x)}{2}&space;\left&space;[&space;\frac{y(x&plus;h)-y(x)}{h}&space;&plus;&space;\frac{y(x)-y(x-h)}{h}&space;\right&space;]&space;&plus;&space;\lambda&space;y(x)&space;=&space;0" title="\sigma(x) \frac{1}{h} \left [ \frac{y(x+h)-y(x)}{h} - \frac{y(x)-y(x-h)}{h} \right ] + \frac{\tau(x)}{2} \left [ \frac{y(x+h)-y(x)}{h} + \frac{y(x)-y(x-h)}{h} \right ] + \lambda y(x) = 0" />

### Polinomios de Tchebichef
Los polinomios discretos de [Tchebichef](https://ieeexplore.ieee.org/document/1315694) de orden ***n*** se definen como:

<img src="https://latex.codecogs.com/gif.latex?t_n(x)&space;=&space;(1-N)_n&space;{}_3F_2(-n,&space;-x,1&plus;n;1,1-N;1)," title="t_n(x) = (1-N)_n {}_3F_2(-n, -x,1+n;1,1-N;1)," />

donde ***x,n = { 0,1,2, ..., N-1}***. La función hipergeométrica se establece como:

<img src="https://latex.codecogs.com/gif.latex?{}_3F_2(a_1,a_2,a_3;b_1,b_2;z)&space;=&space;\sum_{k=0}^{\infty}&space;\frac{(a_1)_k&space;(a_2)_k&space;(a_3)_k}{(b_1)_k&space;(b_2)_k}&space;\frac{z^k}{k!}," title="{}_3F_2(a_1,a_2,a_3;b_1,b_2;z) = \sum_{k=0}^{\infty} \frac{(a_1)_k (a_2)_k (a_3)_k}{(b_1)_k (b_2)_k} \frac{z^k}{k!}," /> 

donde el símbolo de Pochhammer es:

<img src="https://latex.codecogs.com/gif.latex?(a)_k&space;=&space;a(a&plus;1)&space;\cdots&space;(a&plus;k-1)&space;=&space;\frac{\Gamma(a&plus;k)}{\Gamma(a)},&space;\text{&space;donde&space;}&space;\Gamma&space;(n)=&space;(n-1)!." title="(a)_k = a(a+1) \cdots (a+k-1) = \frac{\Gamma(a+k)}{\Gamma(a)}, \text{ donde } \Gamma (n)= (n-1)!." />

### Polinomios de Krawtchouk
 La definición de los polinomios clásicos de [Krawtchouk](https://ieeexplore.ieee.org/document/1240103) de orden ***n*** es:
 <img src="https://latex.codecogs.com/gif.latex?K_n(x;p,N)&space;=&space;\sum_{k=0}^N&space;a_{k,n,p}x^k&space;=&space;{}_2F_1(-n,-x;-N;\frac{1}{p})," title="K_n(x;p,N) = \sum_{k=0}^N a_{k,n,p}x^k = {}_2F_1(-n,-x;-N;\frac{1}{p})," />

<img src="https://latex.codecogs.com/gif.latex?\text{donde&space;}&space;x,n&space;=&space;\left\lbrace&space;0,1,2,&space;\ldots,&space;N,&space;N>0&space;\right\rbrace&space;$&space;,&space;$p&space;\>&space;\in&space;\>&space;(0,1)." title="\text{donde } x,n = \left\lbrace 0,1,2, \ldots, N, N>0 \right\rbrace $ , $p \> \in \> (0,1)." />

La función hipergeométrica se define como:

<img src="https://latex.codecogs.com/gif.latex?{}_2F_1(a,b;c;z)&space;=&space;\sum_{k=0}^{\infty}&space;\frac{(a)_k&space;(b)_k}{(c)_k}\frac{z^k}{k!}" title="{}_2F_1(a,b;c;z) = \sum_{k=0}^{\infty} \frac{(a)_k (b)_k}{(c)_k}\frac{z^k}{k!}" />

### Polinomios Dual Hahn

Los polinomios [dual Hahn](https://www.sciencedirect.com/science/article/pii/S0167865507001341) de orden ***n*** se definen de la siguiente manera:

<img src="https://latex.codecogs.com/gif.latex?w_n&space;(s,a,b,c)&space;=&space;\frac{(a-b&plus;1)_n&space;(a&plus;c&plus;1)_n}{n!}&space;{&space;}_3F_2(-n,&space;a-s,a&plus;s&plus;1;a-b&plus;1,a&plus;c&plus;1;1)," title="w_n (s,a,b,c) = \frac{(a-b+1)_n (a+c+1)_n}{n!} { }_3F_2(-n, a-s,a+s+1;a-b+1,a+c+1;1)," />
 
 La función general hipergeométrica dada por:

<img src="https://latex.codecogs.com/gif.latex?{}_3F_2(a_1,a_2,a_3;b_1,b_2;z)&space;=&space;\sum^{\infty}_{k=0}&space;\frac{(a_1)_k&space;(a_2)_k&space;(a_3)_k}{(b_1)_k&space;(b_2)_k}&space;\frac{z^k}{k!}." title="{}_3F_2(a_1,a_2,a_3;b_1,b_2;z) = \sum^{\infty}_{k=0} \frac{(a_1)_k (a_2)_k (a_3)_k}{(b_1)_k (b_2)_k} \frac{z^k}{k!}." />

### Polinomios de Shmaliy

Shmaliy desarrolló los polinomios discretos de respuesta finita al impulso no sesgado (UFIRs) de un parámetro para filtros FIR basados en FIRs predictivos de un paso. Después, Morales-Mendoza muestran que los UFIRs conforman una nueva familia de polinomios ortogonales discretos que también dependen de la longitud ***N*** de los datos, como único parámetro para su expansión. 
Los polinomios [Shmaliy](https://www.sciencedirect.com/science/article/pii/S016516841300039X) de grado ***p*** se definen como:

<img src="https://latex.codecogs.com/gif.latex?h_p&space;(n,N)&space;=&space;\sum^p_{i=0}&space;a_{ip}(N)&space;n^i,&space;\text{&space;donde&space;}&space;p&space;=&space;\left\lbrace&space;0,1,&space;\ldots&space;N-1\right\rbrace" title="h_p (n,N) = \sum^p_{i=0} a_{ip}(N) n^i, \text{ donde } p = \left\lbrace 0,1, \ldots N-1\right\rbrace" />

y los coeficientes son:

<img src="https://latex.codecogs.com/gif.latex?a_{ip}(N)&space;=&space;(-1)^i&space;\frac{M_{(i&plus;1),1}^{(p)}&space;(N)}{\vert&space;H_p&space;(N)&space;\vert},&space;\text{&space;donde&space;}&space;\vert&space;H_p&space;(N)&space;\vert&space;\text{&space;es&space;el&space;determinante&space;y&space;}&space;M_{(i&plus;1),1}^{(p)}&space;(N)&space;\text{&space;es&space;el&space;menor&space;de&space;la&space;matriz&space;de&space;Hankel&space;}&space;H_p&space;(N)" title="a_{ip}(N) = (-1)^i \frac{M_{(i+1),1}^{(p)} (N)}{\vert H_p (N) \vert}, \text{ donde } \vert H_p (N) \vert \text{ es el determinante y } M_{(i+1),1}^{(p)} (N) \text{ es el menor de la matriz de Hankel } H_p (N):" /> 

<img src="https://latex.codecogs.com/gif.latex?H_p&space;(N)&space;=&space;\begin{bmatrix}&space;c_0&space;&&space;c_1&space;&&space;\cdots&space;&&space;c_p&space;\\&space;c_1&space;&&space;c_2&space;&&space;\cdots&space;&&space;c_{p&plus;1}&space;\\&space;\vdots&space;&&space;\vdots&space;&&space;\ddots&space;&&space;\vdots&space;\\&space;c_p&space;&&space;c_{p&plus;1}&space;&&space;\cdots&space;&&space;c_{2p}&space;\end{bmatrix}." title="H_p (N) = \begin{bmatrix} c_0 & c_1 & \cdots & c_p \\ c_1 & c_2 & \cdots & c_{p+1} \\ \vdots & \vdots & \ddots & \vdots \\ c_p & c_{p+1} & \cdots & c_{2p} \end{bmatrix}." />

Los elementos de la matriz de Hankel son series de potencias:

<img src="https://latex.codecogs.com/gif.latex?c_k&space;(N)&space;=&space;\sum^{N-1}_{i=0}&space;i^k&space;=&space;\frac{1}{k&plus;1}&space;(B_{k&plus;1}&space;(N)&space;-&space;B_{k&plus;1})," title="c_k (N) = \sum^{N-1}_{i=0} i^k = \frac{1}{k+1} (B_{k+1} (N) - B_{k+1})," />

donde ***Bk(x)*** es el polinomio de Bernoulli y ***Bk(0)*** es el número de Bernoulli. Sustituyendo, obtenemos un polinomio de variable discreta n es:

<img src="https://latex.codecogs.com/gif.latex?h_p&space;(n,N)&space;=&space;\sum_{i=0}^{p}&space;(-1)^i&space;\frac{M_{(i&plus;1),1}^{(p)}&space;(N)}{\vert&space;H_p&space;(N)&space;\vert}&space;n^i." title="h_p (n,N) = \sum_{i=0}^{p} (-1)^i \frac{M_{(i+1),1}^{(p)} (N)}{\vert H_p (N) \vert} n^i." />

## Descripción de textura con momentos ortogonales discretos

La base polinomial actúa como el filtro en la descripción basada con Momentos Ortogonales Discretos. EL valor del momento es mayor si las variaciones son similares a los valores de la base polinomial en las direcciones X y Y. Esta característica es importante para el análisis de textura porque la textura es definida como la repetición espacial de patrones en escala de gris en una región dentro de la imagen. Por lo tanto, es posible obtener una descripción de la textura cuando el momento de orden ***s*** es evaluado. La descripción está relacionada con las respuestas en frecuencia de la base polinomial. Entonces, las características de textura ***M(s)*** basada en momentos ortogonales discretos se calcula de la siguiente manera:

<img src="https://latex.codecogs.com/gif.latex?M(s)&space;=&space;\sum_{s=m&plus;n}&space;|H_{mn}|,&space;\text{&space;con&space;}&space;s=0,1,&space;\ldots,&space;2N-2." title="M(s) = \sum_{s=m+n} |H_{mn}|, \text{ con } s=0,1, \ldots, 2N-1." />

El cálculo de los polinomios ortogonales discretos es susceptible a la inestabilidad numérica conforme el orden aumenta. Es por ello, que se propone utilizar una descripción basada en ventanas cuadradas traslapadas que recorren la imagen, y así evitar el cálculo de polinomios y momentos de orden alto para mantener la estabilidad numérica de la descripción. Resulta evidente que el uso de las ventanas traslapadas genera una sobredescricpión de la imagen, por eso se calcula el promedio, la desviación estándar y la curtosis de los vectores obtenidos de todas las ventanas de cada imagen.

El vector estadístico de textura ***t***, basado en la descripción de textura ***M(s)***, es calculado para cada ventana donde ***i*** es la posición de la ventana, que se desplaza de izquierda a derecha y de arriba hacia abajo. El vector ***t*** se contruye de la siguiente manera:

<img src="https://latex.codecogs.com/gif.latex?t&space;=&space;\left[&space;\mu(M_i(0)),&space;\sigma(M_i(0)),&space;\kappa&space;(M_i(0)),&space;\ldots,&space;\mu(M_i(2N-2)),&space;\sigma(M_i(2N-2)),&space;\kappa&space;(M_i(2N-2))&space;\right]," title="t = \left[ \mu(M_i(0)), \sigma(M_i(0)), \kappa (M_i(0)), \ldots, \mu(M_i(2N-2)), \sigma(M_i(2N-2)), \kappa (M_i(2N-2)) \right]," />

El esquema general  de clasificación indica que se calcula una firma estadística de textura para cada imagen del conjunto de entrenamiento. Una vez calculadas las características, entran al clasificador que se encargará de generar una regla con la que posteriormente las características calculadas para el conjunto de validación serán clasificadas. En la 

![Figura] (images/texturaestadisticas.png) 

se muestra el esquema general de la clasificación con firmas de textura estadísticas. 
