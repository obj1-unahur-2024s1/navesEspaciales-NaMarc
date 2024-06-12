/** First Wollok example */ class Nave {

	var velocidad = 0
	var direccion = 0
	var combustible = 0

	method velocidad() = velocidad

	method acelerar(cuanto) {
		velocidad = 100000.min(velocidad + cuanto)
	}

	method desacelera(cuanto) {
		velocidad = 0.max(velocidad - cuanto)
	}

	method irHaciaElSol() {
		direccion = 10
	}

	method escaparDelSol() {
		direccion = -10
	}

	method ponerseParaleloAlSol() {
		direccion = 0
	}

	method acercarseUnPocoAlSol() {
		direccion = 10.min(direccion + 1)
	}

	method alejarseUnPocoDelSol() {
		direccion = -10.max(direccion - 1)
	}

	method prepararViaje() {
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}

	method cargarCombustible(cantidad) {
		combustible += cantidad
	}

	method descargarCombustible(cantidad) {
		combustible -= cantidad
	}

	method combustible() = combustible

	method adicionalTranquilidad() {
		return true
	}

	method estaTranquila() {
		return self.combustible() >= 4000 and self.velocidad() <= 12000 and self.adicionalTranquilidad()
	}

	method escapar() {
	}

	method avisar() {
	}

	method recibirAmenaza() {
		self.escapar()
		self.avisar()
	}
	method tienePocaActividad(){
		return true
	}
	method estaDeRelajo(){
		return self.estaTranquila() and self.tienePocaActividad()
		
	}

}

class Baliza inherits Nave {
	var color = "azul"
	var contadorBaliza = 0

	method cambiarColorDeBaliza(colorNuevo) {
		contadorBaliza += 1
		return if ([ "verde", "rojo", "azul" ].contains(colorNuevo)) color = colorNuevo else "El color no es correcto"
	}

	method color() = color

	override method prepararViaje() {
		super()
		self.cambiarColorDeBaliza("verde")
		self.ponerseParaleloAlSol()
	}

	override method adicionalTranquilidad() {
		return self.color() !== "rojo"
	}

	override method escapar() {
		self.irHaciaElSol()
	}

	override method avisar() {
		self.cambiarColorDeBaliza("rojo")
	}
	override method tienePocaActividad(){
		return contadorBaliza == 0
	}
}

class Pasajeros inherits Nave {
	const pasajeros
	var comida = 0
	var bebida = 0
	var comidaServida = 0

	method cargarComida(cantidad) {
		comida += cantidad
	}

	method descargarComida(cantidad) {
		comida = 0.max(comida - cantidad)
		comidaServida += cantidad
	}

	method cargarBebida(cantidad) {
		bebida += cantidad
	}

	method descargarBebida(cantidad) {
		bebida = 0.max(bebida - cantidad)
	}

	override method prepararViaje() {
		super()
		self.cargarComida(4 * pasajeros)
		self.cargarBebida(6 * pasajeros)
		self.acercarseUnPocoAlSol()
	}

	override method escapar() {
		self.acelerar(velocidad)
	}

	override method avisar() {
		self.descargarComida(pasajeros)
		self.descargarBebida(2 * pasajeros)
	}
	override method tienePocaActividad(){
		return comidaServida < 50
	}
}

class Hospital inherits Pasajeros {

	var quirofanosPreparados = false

	method quirofanosPreparados() = quirofanosPreparados

	method prepararQuirofanos() {
		quirofanosPreparados = true
	}

	override method adicionalTranquilidad() {
		super()
		return not quirofanosPreparados
	}

	override method recibirAmenaza() {
		super()
		self.prepararQuirofanos()
	}

}

class Combate inherits Nave {

	var visible = true
	var misilesDesplegados = true
	const mensajes = []

	method ponerseVisible() {
		visible = true
	}

	method ponerseInvisible() {
		visible = false
	}

	method estaInvisible() {
		return not visible
	}

	method desplegarMisiles() {
		misilesDesplegados = true
	}

	method replegarMisiles() {
		misilesDesplegados = false
	}

	method misilesDesplegados() {
		return misilesDesplegados
	}

	method emitirMensaje(mensaje) {
		mensajes.add(mensaje)
	}

	method mensajesEmitidos() {
		return mensajes
	}

	method primerMensajeEmitido() {
		return mensajes.first()
	}

	method ultimoMensajeEmitido() {
		return mensajes.last()
	}

	method esEscueta() {
		return mensajes.all({ m => m.size() <= 30})
	}

	method emitioMensaje(mensaje) {
		return mensajes.filter({ m => m == mensaje})
	}

	override method prepararViaje() {
		super()
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en misión")
	}

	override method adicionalTranquilidad() {
		return not self.misilesDesplegados()
	}

	override method escapar() {
		self.acercarseUnPocoAlSol()
		self.acercarseUnPocoAlSol()
	}

	override method avisar() {
		self.emitirMensaje("Amenza Recibida")
	}
	override method tienePocaActividad(){
		return self.esEscueta()
	}
}

class Sigilosa inherits Combate {

	override method adicionalTranquilidad() {
		super()
		return not self.estaInvisible()
	}

	override method recibirAmenaza() {
		super()
		self.desplegarMisiles()
		self.ponerseInvisible()
	}

}

