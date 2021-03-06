;;;;;;; JUGADOR DE 4 en RAYA ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;; Version de 4 en raya clásico: Tablero de 6x7, donde se introducen fichas por arriba
;;;;;;;;;;;;;;;;;;;;;;; y caen hasta la posicion libre mas abajo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;; Hechos para representar un estado del juego

;;;;;;; (Turno M|J)   representa a quien corresponde el turno (M maquina, J jugador)
;;;;;;; (Tablero Juego ?i ?j _|M|J) representa que la posicion i,j del tablero esta vacia (_), o tiene una ficha propia (M) o tiene una ficha del jugador humano (J)

;;;;;;;;;;;;;;;; Hechos para representar estado del analisis
;;;;;;; (Tablero Analisis Posicion ?i ?j _|M|J) representa que en el analisis actual la posicion i,j del tablero esta vacia (_), o tiene una ficha propia (M) o tiene una ficha del jugador humano (J)
;;;;;;; (Sondeando ?n ?i ?c M|J)  ; representa que estamos analizando suponiendo que la ?n jugada h sido ?i ?c M|J
;;;

;;;;;;;;;;;;; Hechos para representar una jugadas

;;;;;;; (Juega M|J ?columna) representa que la jugada consiste en introducir la ficha en la columna ?columna 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; INICIALIZAR ESTADO


(deffacts Estado_inicial
(Tablero Juego 1 1 _) (Tablero Juego 1 2 _) (Tablero Juego 1 3 _) (Tablero Juego  1 4 _) (Tablero Juego  1 5 _) (Tablero Juego  1 6 _) (Tablero Juego  1 7 _)
(Tablero Juego 2 1 _) (Tablero Juego 2 2 _) (Tablero Juego 2 3 _) (Tablero Juego 2 4 _) (Tablero Juego 2 5 _) (Tablero Juego 2 6 _) (Tablero Juego 2 7 _)
(Tablero Juego 3 1 _) (Tablero Juego 3 2 _) (Tablero Juego 3 3 _) (Tablero Juego 3 4 _) (Tablero Juego 3 5 _) (Tablero Juego 3 6 _) (Tablero Juego 3 7 _)
(Tablero Juego 4 1 _) (Tablero Juego 4 2 _) (Tablero Juego 4 3 _) (Tablero Juego 4 4 _) (Tablero Juego 4 5 _) (Tablero Juego 4 6 _) (Tablero Juego 4 7 _)
(Tablero Juego 5 1 _) (Tablero Juego 5 2 _) (Tablero Juego 5 3 _) (Tablero Juego 5 4 _) (Tablero Juego 5 5 _) (Tablero Juego 5 6 _) (Tablero Juego 5 7 _)
(Tablero Juego 6 1 _) (Tablero Juego 6 2 _) (Tablero Juego 6 3 _) (Tablero Juego 6 4 _) (Tablero Juego 6 5 _) (Tablero Juego 6 6 _) (Tablero Juego 6 7 _)
(Jugada 0)
)

(defrule Elige_quien_comienza
=>
(printout t "Quien quieres que empieze: (escribre M para la maquina o J para empezar tu) ")
(assert (Turno (read)))
)

;;;;;;;;;;;;;;;;;;;;;;; MUESTRA POSICION ;;;;;;;;;;;;;;;;;;;;;;;
(defrule muestra_posicion
(declare (salience 10))
(muestra_posicion)
(Tablero Juego 1 1 ?p11) (Tablero Juego 1 2 ?p12) (Tablero Juego 1 3 ?p13) (Tablero Juego 1 4 ?p14) (Tablero Juego 1 5 ?p15) (Tablero Juego 1 6 ?p16) (Tablero Juego 1 7 ?p17)
(Tablero Juego 2 1 ?p21) (Tablero Juego 2 2 ?p22) (Tablero Juego 2 3 ?p23) (Tablero Juego 2 4 ?p24) (Tablero Juego 2 5 ?p25) (Tablero Juego 2 6 ?p26) (Tablero Juego 2 7 ?p27)
(Tablero Juego 3 1 ?p31) (Tablero Juego 3 2 ?p32) (Tablero Juego 3 3 ?p33) (Tablero Juego 3 4 ?p34) (Tablero Juego 3 5 ?p35) (Tablero Juego 3 6 ?p36) (Tablero Juego 3 7 ?p37)
(Tablero Juego 4 1 ?p41) (Tablero Juego 4 2 ?p42) (Tablero Juego 4 3 ?p43) (Tablero Juego 4 4 ?p44) (Tablero Juego 4 5 ?p45) (Tablero Juego 4 6 ?p46) (Tablero Juego 4 7 ?p47)
(Tablero Juego 5 1 ?p51) (Tablero Juego 5 2 ?p52) (Tablero Juego 5 3 ?p53) (Tablero Juego 5 4 ?p54) (Tablero Juego 5 5 ?p55) (Tablero Juego 5 6 ?p56) (Tablero Juego 5 7 ?p57)
(Tablero Juego 6 1 ?p61) (Tablero Juego 6 2 ?p62) (Tablero Juego 6 3 ?p63) (Tablero Juego 6 4 ?p64) (Tablero Juego 6 5 ?p65) (Tablero Juego 6 6 ?p66) (Tablero Juego 6 7 ?p67)
=>
(printout t crlf)
(printout t ?p11 " " ?p12 " " ?p13 " " ?p14 " " ?p15 " " ?p16 " " ?p17 crlf)
(printout t ?p21 " " ?p22 " " ?p23 " " ?p24 " " ?p25 " " ?p26 " " ?p27 crlf)
(printout t ?p31 " " ?p32 " " ?p33 " " ?p34 " " ?p35 " " ?p36 " " ?p37 crlf)
(printout t ?p41 " " ?p42 " " ?p43 " " ?p44 " " ?p45 " " ?p46 " " ?p47 crlf)
(printout t ?p51 " " ?p52 " " ?p53 " " ?p54 " " ?p55 " " ?p56 " " ?p57 crlf)
(printout t ?p61 " " ?p62 " " ?p63 " " ?p64 " " ?p65 " " ?p66 " " ?p67 crlf)
(printout t  crlf)
)


;;;;;;;;;;;;;;;;;;;;;;; RECOGER JUGADA DEL CONTRARIO ;;;;;;;;;;;;;;;;;;;;;;;
(defrule mostrar_posicion
(declare (salience 9999))
(Turno J)
=>
(assert (muestra_posicion))
)

(defrule jugada_contrario
?f <- (Turno J)
=>
(printout t "en que columna introduces la siguiente ficha? ")
(assert (Juega J (read)))
(retract ?f)
)

(defrule juega_contrario_check_entrada_correcta
(declare (salience 1))
?f <- (Juega J ?c)
(test (and (neq ?c 1) (and (neq ?c 2) (and (neq ?c 3) (and (neq ?c 4) (and (neq ?c 5) (and (neq ?c 6) (neq ?c 7))))))))
=>
(printout t "Tienes que indicar un numero de columna: 1,2,3,4,5,6 o 7" crlf)
(retract ?f)
(assert (Turno J))
)

(defrule juega_contrario_check_columna_libre
(declare (salience 1))
?f <- (Juega J ?c)
(Tablero Juego 1 ?c ?X) 
(test (neq ?X _))
=>
(printout t "Esa columna ya esta completa, tienes que jugar en otra" crlf)
(retract ?f)
(assert (Turno J))
)

(defrule juega_contrario_actualiza_estado
?f <- (Juega J ?c)
?g <- (Tablero Juego ?i ?c _)
(Tablero Juego ?j ?c ?X) 
(test (= (+ ?i 1) ?j))
(test (neq ?X _))
=>
(retract ?f ?g)
(assert (Turno M) (Tablero Juego ?i ?c J))
)

(defrule juega_contrario_actualiza_estado_columna_vacia
?f <- (Juega J ?c)
?g <- (Tablero Juego 6 ?c _)
=>
(retract ?f ?g)
(assert (Turno M) (Tablero Juego 6 ?c J))
)


;;;;;;;;;;; ACTUALIZAR  ESTADO TRAS JUGADA DE CLISP ;;;;;;;;;;;;;;;;;;

(defrule juega_clisp_actualiza_estado
?f <- (Juega M ?c)
?g <- (Tablero Juego ?i ?c _)
(Tablero Juego ?j ?c ?X) 
(test (= (+ ?i 1) ?j))
(test (neq ?X _))
=>
(retract ?f ?g)
(assert (Turno J) (Tablero Juego ?i ?c M))
)

(defrule juega_clisp_actualiza_estado_columna_vacia
?f <- (Juega M ?c)
?g <- (Tablero Juego 6 ?c _)
=>
(retract ?f ?g)
(assert (Turno J) (Tablero Juego 6 ?c M))
)

;;;;;;;;;;; CLISP JUEGA SIN CRITERIO ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule elegir_jugada_aleatoria
(declare (salience -9998))
?f <- (Turno M)
=>
(assert (Jugar (random 1 7)))
(retract ?f)
)

(defrule comprobar_posible_jugada_aleatoria
?f <- (Jugar ?c)
(Tablero Juego 1 ?c M|J)
=>
(retract ?f)
(assert (Turno M))
)

(defrule clisp_juega_sin_criterio
(declare (salience -9999))
?f<- (Jugar ?c)
=>
(printout t "JUEGO en la columna (sin criterio) " ?c crlf)
(retract ?f)
(assert (Juega M ?c))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;  Comprobar si hay 4 en linea ;;;;;;;;;;;;;;;;;;;;;

(defrule cuatro_en_linea_horizontal
(declare (salience 9999))
(Tablero ?t ?i ?c1 ?jugador)
(Tablero ?t ?i ?c2 ?jugador) 
(test (= (+ ?c1 1) ?c2))
(Tablero ?t ?i ?c3 ?jugador)
(test (= (+ ?c1 2) ?c3))
(Tablero ?t ?i ?c4 ?jugador)
(test (= (+ ?c1 3) ?c4))
(test (or (eq ?jugador M) (eq ?jugador J) ))
=>
(assert (Cuatro_en_linea ?t ?jugador horizontal ?i ?c1))
)

(defrule cuatro_en_linea_vertical
(declare (salience 9999))
?f <- (Turno ?X)
(Tablero ?t ?i1 ?c ?jugador)
(Tablero ?t ?i2 ?c ?jugador)
(test (= (+ ?i1 1) ?i2))
(Tablero ?t ?i3 ?c  ?jugador)
(test (= (+ ?i1 2) ?i3))
(Tablero ?t ?i4 ?c  ?jugador)
(test (= (+ ?i1 3) ?i4))
(test (or (eq ?jugador M) (eq ?jugador J) ))
=>
(assert (Cuatro_en_linea ?t ?jugador vertical ?i1 ?c))
)

(defrule cuatro_en_linea_diagonal_directa
(declare (salience 9999))
?f <- (Turno ?X)
(Tablero ?t ?i ?c ?jugador)
(Tablero ?t ?i1 ?c1 ?jugador)
(test (= (+ ?i 1) ?i1))
(test (= (+ ?c 1) ?c1))
(Tablero ?t ?i2 ?c2  ?jugador)
(test (= (+ ?i 2) ?i2))
(test (= (+ ?c 2) ?c2))
(Tablero ?t ?i3 ?c3  ?jugador)
(test (= (+ ?i 3) ?i3))
(test (= (+ ?c 3) ?c3))
(test (or (eq ?jugador M) (eq ?jugador J) ))
=>
(assert (Cuatro_en_linea ?t ?jugador diagonal_directa ?i ?c))
)

(defrule cuatro_en_linea_diagonal_inversa
(declare (salience 9999))
?f <- (Turno ?X)
(Tablero ?t ?i ?c ?jugador)
(Tablero ?t ?i1 ?c1 ?jugador)
(test (= (+ ?i 1) ?i1))
(test (= (- ?c 1) ?c1))
(Tablero ?t ?i2 ?c2  ?jugador)
(test (= (+ ?i 2) ?i2))
(test (= (- ?c 2) ?c2))
(Tablero ?t ?i3 ?c3  ?jugador)
(test (= (+ ?i 3) ?i3))
(test (= (- ?c 3) ?c3))
(test (or (eq ?jugador M) (eq ?jugador J) ))
=>
(assert (Cuatro_en_linea ?t ?jugador diagonal_inversa ?i ?c))
)

;;;;;;;;;;;;;;;;;;;; DESCUBRE GANADOR
(defrule gana_fila
(declare (salience 9999))
?f <- (Turno ?X)
(Cuatro_en_linea Juego ?jugador horizontal ?i ?c)
=>
(printout t ?jugador " ha ganado pues tiene cuatro en linea en la fila " ?i crlf)
(retract ?f)
(assert (muestra_posicion))
) 

(defrule gana_columna
(declare (salience 9999))
?f <- (Turno ?X)
(Cuatro_en_linea Juego ?jugador vertical ?i ?c)
=>
(printout t ?jugador " ha ganado pues tiene cuatro en linea en la columna " ?c crlf)
(retract ?f)
(assert (muestra_posicion))
) 

(defrule gana_diagonal_directa
(declare (salience 9999))
?f <- (Turno ?X)
(Cuatro_en_linea Juego ?jugador diagonal_directa ?i ?c)
=>
(printout t ?jugador " ha ganado pues tiene cuatro en linea en la diagonal que empieza la posicion " ?i " " ?c   crlf)
(retract ?f)
(assert (muestra_posicion))
) 

(defrule gana_diagonal_inversa
(declare (salience 9999))
?f <- (Turno ?X)
(Cuatro_en_linea Juego ?jugador diagonal_inversa ?i ?c)
=>
(printout t ?jugador " ha ganado pues tiene cuatro en linea en la diagonal hacia arriba que empieza la posicin " ?i " " ?c   crlf)
(retract ?f)
(assert (muestra_posicion))
) 


;;;;;;;;;;;;;;;;;;;;;;;  DETECTAR EMPATE

(defrule empate
(declare (salience -9999))
(Turno ?X)
(Tablero Juego 1 1 M|J)
(Tablero Juego 1 2 M|J)
(Tablero Juego 1 3 M|J)
(Tablero Juego 1 4 M|J)
(Tablero Juego 1 5 M|J)
(Tablero Juego 1 6 M|J)
(Tablero Juego 1 7 M|J)
=>
(printout t "EMPATE! Se ha llegado al final del juego sin que nadie gane" crlf)
)

;;;;;;;;;;;;;;;;;;;;;; CONOCIMIENTO EXPERTO ;;;;;;;;;;

;;;;; Reglas para deducir la posición siguiente en horizontal, vertical y diagonal.
;;;;; Para cada dirección posible se comprueba que existe otra casilla en la fila/columna
;;;;; posterior (comprobando que la fila/columna del primero más uno es igual a la fila/columna
;;;;; del segundo).

;;;;; Se comprueba que existe una casilla en la columna siguiente.
;;;;; Si es para J, sería: J J

(defrule siguiente_horizontal 
(Tablero Juego ?i ?j ?turno)
(Tablero Juego ?i ?c ?turno)
(test (= (+ 1 ?j) ?c) )
=>
(assert (siguiente ?i ?j h ?i ?c))
) 

;;;;; Se comprueba que existe una casilla en la fila y columna siguiente.
;;;;; Si es para J, sería: J _
;;;;;                      _ J

(defrule siguiente_diagonal_directa
(Tablero Juego ?i ?j ?turno)
(Tablero Juego ?f ?c ?turno)
(test (and (= (+ 1 ?i) ?f) (= (+ 1 ?j) ?c) ) )
=>
(assert (siguiente ?i ?j d1 ?f ?c))
)

;;;;; Se comprueba que existe una casilla en la fila anterior y columna siguiente.
;;;;; Si es para J, sería: _ J
;;;;;                      J _

(defrule siguiente_diagonal_inversa
(Tablero Juego ?i ?j ?turno)
(Tablero Juego ?f ?c ?turno)
(test (and (= (- ?i 1) ?f) (= (+ 1 ?j) ?c) ) )
=>
(assert (siguiente ?i ?j d2 ?f ?c))
)

;;;;; Se comprueba que existe una casilla en la fila siguiente.
;;;;; Si es para J, sería: J
;;;;;                      J
;;;;; (Como el número de fila del tablero sube hacia abajo, este
;;;;; siguiente significa encontrar la casilla justo por debajo)

(defrule siguiente_vertical 
(Tablero Juego ?i ?j ?turno)
(Tablero Juego ?f ?j ?turno)
(test (= (+ 1 ?i) ?f) )
=>
(assert (siguiente ?i ?j v ?f ?j))
)

;;;;; Reglas para deducir donde caería una ficha si se juega en la columna j
;;;;; Hay dos posibilidades: que la columna esté vacía o que se haya colocado
;;;;; al menos una ficha. Comprobamos ambos casos.

;;;;; Si la casilla está vacía y no existe una casilla debajo.

(defrule caeria_sobre_vacio
(Tablero Juego ?i ?j _)
(not (siguiente ?i ?j v ?f ?j))
=>
(assert (caeria ?i ?j))
)

;;;;; Si la casilla está vacía y la casilla de abajo tiene una ficha J o M.
;;;;; Además, aprovecho esta regla para eliminar los 'caeria' anteriores. Si
;;;;; encontramos una nueva posición donde caería la ficha por encima de otra
;;;;; significa necesariamente que el caería anterior ya está desfasado (donde
;;;;; ahora hay una ficha).

(defrule caeria_sobre_ficha
(Tablero Juego ?i ?j _)
(Tablero Juego ?f ?j M|J)
(siguiente ?i ?j v ?f ?j)
?r <- (caeria ?f ?j)
=>
(retract ?r)
(assert (caeria ?i ?j))
)

;;;;; Regla para deducir que hay dos fichas en línea para un mismo jugador.
;;;;; Simplemente se comprueba que una casilla es siguiente de otra para una
;;;;; misma dirección y para toda casilla que no sea vacío.

(defrule dos_en_linea 
(Tablero Juego ?i ?j ?turno&~_)
(Tablero Juego ?f ?c ?turno)
(siguiente ?i ?j ?direccion ?f ?c)
=>
(assert (dos_en_linea ?i ?j ?direccion ?f ?c ?turno))
)

;;;;; Reglas para deducir que hay tres fichas en línea para un mismo jugador y un espacio antes o después.
;;;;; Se comprueba que hay un dos en línea para un par de casillas 'a' y 'b' y para una par 'b' y 'c', y que
;;;;; hay un espacío antes de las fichas o después en la msima dirección.
;;;;; Por ejemplo: J J J _ 	o  _ J J J
;;;;; Se establece el hecho con las coordenadas del espacio vacío (pues es donde la falta la ficha necesaria
;;;;; para ganar) y el jugador que hace el tres en línea.

(defrule tres_en_linea_siguiente
(dos_en_linea ?i ?j ?direccion ?f ?c ?turno)
(dos_en_linea ?f ?c ?direccion ?y ?x ?turno)
(siguiente ?y ?x ?direccion ?a ?b)
=>
(assert (tres_en_linea ?a ?b ?turno))
)

(defrule tres_en_linea_anterior
(dos_en_linea ?i ?j ?direccion ?f ?c ?turno)
(dos_en_linea ?f ?c ?direccion ?y ?x ?turno)
(siguiente ?a ?b ?direccion ?i ?j)
=>
(assert (tres_en_linea ?a ?b ?turno))
)

;;;;; Regla para deducir que hay dos fichas en línea, un hueco y otra ficha para un mismo jugador
;;;;; (que también podría resultar en una victoria en una jugada, igual que en tres en línea).
;;;;; Por ejemplo: J J _ J 	 o	 J _ J J
;;;;; Se establece el hecho con las coordenadas del hueco vacío y el jugador que hace el "centro en línea".

(defrule centro_en_linea_21
(dos_en_linea ?i ?j ?direccion ?f ?c ?turno)
(siguiente ?f ?c ?direccion ?y ?x)
(Tablero Juego ?y ?x _)
(siguiente ?y ?x ?direccion ?a ?b)
(Tablero Juego ?a ?b ?turno)
=>
(assert (centro_en_linea ?y ?x ?turno))
)

(defrule centro_en_linea_12
(dos_en_linea ?i ?j ?direccion ?f ?c ?turno)
(siguiente ?y ?x ?direccion ?i ?j)
(Tablero Juego ?y ?x _)
(siguiente ?a ?b ?direccion ?y ?x)
(Tablero Juego ?a ?b ?turno)
=>
(assert (centro_en_linea ?y ?x ?turno))
)

;;;;; Regla para deducir que un jugador ganaría si jugase en una columna.
;;;;; Para ello usamos las reglas definidas anteriores de tres_en_linea y centro_en_linea,
;;;;; que son los únicos casos posibles de victoria en este juego. Si se dan esos casos
;;;;; y el espacio vacío dado por los hechos de tres/centro en línea es donde caería la ficha
;;;;; al jugar en esa columna, se establece el hecho "ganaria".

(defrule ganaria_tres
(tres_en_linea ?i ?j ?turno)
(caeria ?i ?j)
=>
(assert (ganaria ?turno ?j))
)

(defrule ganaria_centro
(centro_en_linea ?i ?j ?turno)
(caeria ?i ?j)
=>
(assert (ganaria ?turno ?j))
)

(defrule limpiar_ganaria
(declare (salience 10))
(Juega M|J ?c)
?g <- (ganaria M|J ?c)
=>
(retract ?g)
)

;;;;; Clips juega con conocimiento experto.

;;;;; Lo primero y más importante, comprobar si la máquina puede ganar en en ese turno. Si es así, la regla se dispara con 10 de prioridad y se juega en esa columna.

(defrule eligir_jugada_ganadora
(declare (salience 10))
?r <- (Turno M)
(ganaria M ?c)
=>
(printout t "Grave error. Juego en la columna " ?c crlf)
(retract ?r)
(assert (Juega M ?c))
)

;;;;; Después, comprobar si la máquina puede perder en el siguiente turno del jugador. Si es así, la regla se dispara con 9 de prioridad y se juega en esa columna.
;;;;; Esta regla tiene prioridad pero no más que "elegir_jugada_ganadora", ya que, lógicamente, si se gana en ese turno ya no se puede perder. No tiene
;;;;; sentido bloquear cuando puedes ganar directamente.

(defrule eligir_jugada_bloqueadora
(declare (salience 9))
?r <- (Turno M)
(ganaria J ?c)
=>
(printout t "Juego en la columna " ?c " para bloquear tu jugada" crlf)
(retract ?r)
(assert (Juega M ?c))
)

;;;;; Si no hay una jugada ganadora o bloqueadora que realizar, el sistema sigue el siguiente comportamiento:
;;;;; Primero, coloca donde haya donde tenga tres espacios libres después o antes de una ficha suya. Para ello,
;;;;; se comprueban que las tres casillas posteriores o anteriores a una ficha M cualquiera estén libres
;;;;; y se coloca la ficha justo en la primera libre, siempre y cuando la ficha vaya a caer en esa primera libre.

(defrule tres_libres_siguientes
?r <- (Jugar ?q)
(Tablero Juego ?i ?j M)
(siguiente ?i ?j ?direccion ?f ?c)
(siguiente ?f ?c ?direccion ?y ?x)
(siguiente ?y ?x ?direccion ?a ?b)
(Tablero Juego ?f ?c _)
(Tablero Juego ?y ?x _)
(Tablero Juego ?a ?b _)
(caeria ?f ?c)
=>
(printout t "Juego en la columna " ?c " porque hay tres casillas libres posteriores a mi ficha" crlf)
(retract ?r)
(assert (Juega M ?c))
)

(defrule tres_libres_anteriores
?r <- (Jugar ?q)
(Tablero Juego ?i ?j M)
(siguiente ?f ?c ?direccion ?i ?j)
(siguiente ?y ?x ?direccion ?f ?c)
(siguiente ?a ?b ?direccion ?y ?x)
(Tablero Juego ?f ?c _)
(Tablero Juego ?y ?x _)
(Tablero Juego ?a ?b _)
(caeria ?f ?c)
=>
(printout t "Juego en la columna " ?c " porque hay tres casillas libres anteriores a mi ficha" crlf)
(retract ?r)
(assert (Juega M ?c))
)

;;;;; Si, en cambio, lo que tenemos son dos casillas libres seguidas de un dos en línea para M, salta esta
;;;;; regla con más prioridad, para así ponerse en situación de ganar. Para ello se comprueba que hay un dos
;;;;; en línea para alguna dirección, que las dos casillas anteriores o siguientes están vacías. Si es así
;;;;; se coloca ficha en la preimera casilla libre, siempre y cuando la ficha vaya a caer en la casilla en cuestión.

(defrule dos_libres_siguientes
(declare (salience 1))
?r <- (Jugar ?q)
(dos_en_linea ?i ?j ?direccion ?f ?c M)
(siguiente ?f ?c ?direccion ?y ?x)
(siguiente ?y ?x ?direccion ?a ?b)
(Tablero Juego ?y ?x _)
(Tablero Juego ?a ?b _)
(caeria ?y ?x)
=>
(printout t "Juego en la columna " ?x " porque hay dos casillas libres posteriores a mi dos en linea" crlf)
(retract ?r)
(assert (Juega M ?x))
)

(defrule dos_libres_anteriores
(declare (salience 1))
?r <- (Jugar ?q)
(dos_en_linea ?i ?j ?direccion ?f ?c M)
(siguiente ?y ?x ?direccion ?i ?j)
(siguiente ?a ?b ?direccion ?y ?x)
(Tablero Juego ?y ?x _)
(Tablero Juego ?a ?b _)
(caeria ?y ?x)
=>
(printout t "Juego en la columna " ?x " porque hay dos casillas libres anteriores a mi dos en linea" crlf)
(retract ?r)
(assert (Juega M ?x))
)

;;;;; En caso de que el sistema juegue sin criterio porque no se den los cuatro posibles casos anteriores...
;;;;; Con este par de reglas me aseguro de que se no coloque ficha aleatoriamente en una posición donde favorezca al
;;;;; jugador y le haga ganar. 
;;;;; Por ejemplo, si se da esta situación: J J J _
;;;;;										M J M _
;;;;; Asegurarnos que no coloca ficha en la columna cuatro porque entonces jugador podría ganar en el siguiente turno.

(defrule comprobar_jugada_tres
(declare (salience 1))
?r <- (Juega M ?c)
(tres_en_linea ?i ?c J)
(caeria ?f ?c)
(siguiente ?i ?c v ?f ?c)
=>
(retract ?r)
(assert (Turno M))
)

;;;;; Lo mismo que antes, pero para una situación como esta: J _ J J
;;;;;														 M _ J M
;;;;; Asegurarnos que no coloca en la columna dos.

(defrule comprobar_jugada_centro
(declare (salience 1))
?r <- (Juega M ?c)
(centro_en_linea ?i ?c J)
(caeria ?f ?c)
(siguiente ?i ?c v ?f ?c)
=>
(retract ?r)
(assert (Turno M))
)
















