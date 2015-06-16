package org.uqbar.project.wollok.interpreter.core

import java.util.Map
import org.uqbar.project.wollok.interpreter.nativeobj.collections.AbstractWollokCollection
import org.uqbar.project.wollok.wollokDsl.WClass
import org.uqbar.project.wollok.wollokDsl.WNamedObject
import org.uqbar.project.wollok.wollokDsl.WObjectLiteral

import static extension org.uqbar.project.wollok.model.WMethodContainerExtensions.*

class ToStringBuilder {
	val alreadyShown = <WollokObject>newHashSet()
	
	def static shortLabel(WollokObject obj) {
		obj.behavior.objectDescription
	}

	def static dispatch objectDescription(WClass clazz) { "a " + clazz.name  }
	def static dispatch objectDescription(WObjectLiteral obj) { "anObject" }
	def static dispatch objectDescription(WNamedObject namedObject){ namedObject.name }
	
	def dispatch String smartToString(WollokObject obj){
		val toString = obj.behavior.lookupMethod("toString")
		if (toString != null)
			obj.call("toString").toString
		else{
			if(alreadyShown.contains(obj)){
				obj.behavior.objectDescription
			}else{
				alreadyShown.add(obj)
				obj.behavior.objectDescription + obj.instanceVariables.smartToString
			}
		}
	}
	
	def dispatch String smartToString(AbstractWollokCollection<?> col){
		col.wollokName + "[" + col.wrapped.map[ smartToString ].join(", ") + "]"
	}
	
	def dispatch String smartToString(Map<String,Object> obs){
		"[" + obs.entrySet.map[ key + "=" + value.smartToString ].join(", ") +  "]"
	}
	
	def dispatch String smartToString(Object obj){
		obj.toString
	}
}