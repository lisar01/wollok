program console {
	val console = this // TODO esto debería volar

	// console es un objeto que me permite escribir en pantalla
	// otros objetos útiles son los strings
	console.println("Hello Wollok !!!")
	console.println(1)

	// Los números también son objetos
	console.println(1+2)

	// Las constantes y variables me sirven para guardarme 'referencias' a un objeto
	val x = 2
	console.println(x)

	val y = 3
	var z = 0
	console.println(z)
	
	z = x + y
	console.println(z)
}
