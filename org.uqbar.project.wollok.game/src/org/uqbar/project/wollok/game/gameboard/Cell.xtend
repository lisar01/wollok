package org.uqbar.project.wollok.game.gameboard

import org.uqbar.project.wollok.game.Image
import org.uqbar.project.wollok.game.Position
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Cell {
	var Image image
	var Position position

	new(Position position, Image image) {
		this.position = position
		this.image = image
	}
	
	def draw(Window window) {
		window.draw(image, position)
	}	
}