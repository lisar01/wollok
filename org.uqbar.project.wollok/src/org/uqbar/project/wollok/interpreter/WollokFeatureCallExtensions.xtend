package org.uqbar.project.wollok.interpreter

import org.uqbar.project.wollok.interpreter.api.IWollokInterpreter
import org.uqbar.project.wollok.interpreter.core.WollokObject
import org.uqbar.project.wollok.interpreter.nativeobj.AbstractWollokDeclarativeNativeObject
import org.uqbar.project.wollok.interpreter.stack.VoidObject
import org.uqbar.project.wollok.wollokDsl.WFeatureCall
import org.uqbar.project.wollok.wollokDsl.WMemberFeatureCall
import org.uqbar.project.wollok.wollokDsl.WMethodDeclaration
import org.uqbar.project.wollok.wollokDsl.WSuperInvocation

import static extension org.uqbar.project.wollok.interpreter.context.EvaluationContextExtensions.*
import static extension org.uqbar.project.wollok.model.WollokModelExtensions.*
import static extension org.uqbar.project.wollok.ui.utils.XTendUtilExtensions.*

/**
 * Methods to be shared between WollokObject and CallableSuper
 * 
 * @author npasserini
 * @author jfernandes
 */
class WollokFeatureCallExtensions {
	WollokObject receiver
	extension IWollokInterpreter interpreter
	
	new(WollokObject receiver) {
		this.receiver = receiver
		this.interpreter = receiver.interpreter
	}
	
	def Object call(WMethodDeclaration method, Object... parameters) {
		if (method.parameters.size != parameters.size) 
			throw new MessageNotUnderstood('''Incorrect number of arguments for method '«method.name»'. Expected «method.parameters.size» but found «parameters.size»''')
		val c = method.createEvaluationContext(parameters).then(receiver)
		interpreter.performOnStack(method, c) [|
			if (method.native){
				// reflective call
				val r = receiver.nativeObject.invokeNative(method.name, parameters)
				if(receiver.nativeObject.isVoid(method.name, parameters))
					return VoidObject::instance
				else
					return r
			}else{
				method.expression.eval
				return VoidObject::instance
			}
		]
	}
	
	def dispatch invokeNative(Object nativeObject, String name, Object... parameters){
		nativeObject.invoke(name, parameters)
	}

	def dispatch invokeNative(AbstractWollokDeclarativeNativeObject nativeObject, String name, Object... parameters){
		nativeObject.call(name, parameters)
	}

	def dispatch isVoid(Object nativeObject, String message, Object... parameters){
		var method = this.class.methods.findFirst[name == message]
		
		if(method == null)
			return false
			
		method.returnType == Void.TYPE
	}

	def dispatch isVoid(AbstractWollokDeclarativeNativeObject nativeObject, String name, Object... parameters){
		nativeObject.isVoid(name, parameters)
	}

	
	def createEvaluationContext(WMethodDeclaration declaration, Object... values) {
		declaration.parameters.map[name].createEvaluationContext(values)
	}
	
	// STATIC EXTENSIONS
	
	def static dispatch feature(WFeatureCall call) { throw new UnsupportedOperationException("Should not happen") }
	def static dispatch feature(WMemberFeatureCall call) { call.feature }
	def static dispatch feature(WSuperInvocation call) { call.method.name }

	// TODO Esto no debería ser necesario pero no logro generar bien la herencia entre estas clases para poder tratarlas polimórficamente.
	def static dispatch memberCallArguments(WFeatureCall call) { throw new UnsupportedOperationException("Should not happen") }
	def static dispatch memberCallArguments(WMemberFeatureCall call) { call.memberCallArguments }
	def static dispatch memberCallArguments(WSuperInvocation call) { call.memberCallArguments }
	
}