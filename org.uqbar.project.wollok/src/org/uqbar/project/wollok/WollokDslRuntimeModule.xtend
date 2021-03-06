/*
 * generated by Xtext
 */
package org.uqbar.project.wollok

import com.google.inject.Binder
import com.google.inject.TypeLiteral
import com.google.inject.name.Names
import java.util.List
import org.eclipse.xtext.common.types.TypesFactory
import org.eclipse.xtext.common.types.access.IJvmTypeProvider
import org.eclipse.xtext.linking.ILinkingDiagnosticMessageProvider
import org.eclipse.xtext.parser.antlr.SyntaxErrorMessageProvider
import org.eclipse.xtext.resource.IDefaultResourceDescriptionStrategy
import org.eclipse.xtext.scoping.IScopeProvider
import org.eclipse.xtext.scoping.impl.AbstractDeclarativeScopeProvider
import org.eclipse.xtext.service.OperationCanceledManager
import org.uqbar.project.wollok.formatting2.WollokDslFormatter
import org.uqbar.project.wollok.interpreter.SysoutWollokInterpreterConsole
import org.uqbar.project.wollok.interpreter.WollokInterpreterConsole
import org.uqbar.project.wollok.interpreter.WollokInterpreterEvaluator
import org.uqbar.project.wollok.interpreter.api.XInterpreterEvaluator
import org.uqbar.project.wollok.interpreter.core.WollokObject
import org.uqbar.project.wollok.interpreter.natives.DefaultNativeObjectFactory
import org.uqbar.project.wollok.interpreter.natives.NativeObjectFactory
import org.uqbar.project.wollok.libraries.BasicWollokLibraryLoader
import org.uqbar.project.wollok.libraries.JarWollokLibraries
import org.uqbar.project.wollok.libraries.StandardWollokLib
import org.uqbar.project.wollok.libraries.WollokLib
import org.uqbar.project.wollok.libraries.WollokLibraries
import org.uqbar.project.wollok.libraries.WollokLibraryLoader
import org.uqbar.project.wollok.linking.WollokLinker
import org.uqbar.project.wollok.linking.WollokLinkingDiagnosticMessageProvider
import org.uqbar.project.wollok.parser.WollokSyntaxErrorMessageProvider
import org.uqbar.project.wollok.scoping.WollokGlobalScopeProvider
import org.uqbar.project.wollok.scoping.WollokImportedNamespaceAwareLocalScopeProvider
import org.uqbar.project.wollok.scoping.WollokQualifiedNameProvider
import org.uqbar.project.wollok.scoping.WollokResourceDescriptionStrategy
import org.uqbar.project.wollok.scoping.cache.MapBasedWollokGlobalScopeCache
import org.uqbar.project.wollok.scoping.cache.WollokGlobalScopeCache
import org.uqbar.project.wollok.serializer.WollokDslSyntacticSequencerWithSyntheticLinking
import org.uqbar.project.wollok.utils.DummyJvmTypeProviderFactory

/**
 * Use this class to register components to be used at runtime / without the Equinox extension registry.
 */
@SuppressWarnings("restriction")
class WollokDslRuntimeModule extends AbstractWollokDslRuntimeModule {
	override configure(Binder binder) {
		super.configure(binder);

		binder.bind(NativeObjectFactory).to(DefaultNativeObjectFactory);
		binder.bind(IJvmTypeProvider.Factory).to(DummyJvmTypeProviderFactory);
		binder.bind(TypesFactory).toInstance(TypesFactory.eINSTANCE);

		binder.bind(ILinkingDiagnosticMessageProvider.Extended).to(WollokLinkingDiagnosticMessageProvider);
		binder.bind(OperationCanceledManager).toInstance(new OperationCanceledManager);
		
		binder.bind(WollokLib).annotatedWith(Names.named("standardWollokLib")).to(StandardWollokLib)
		binder.bind(new TypeLiteral<List<String>>(){}).annotatedWith(Names.named("libraries")).toInstance(libs())
		binder.bind(WollokLibraries).to(JarWollokLibraries)	
	}
	
	//this method is overriden by WollokLauncherModule
	def List<String> libs() {
		#[]
	}

	def Class<? extends IDefaultResourceDescriptionStrategy> bindIDefaultResourceDescriptionStrategy() {
		WollokResourceDescriptionStrategy
	}

	override bindIGlobalScopeProvider() {
		WollokGlobalScopeProvider
	}

	def Class<? extends WollokGlobalScopeCache> bindWollokGlobalScopeCache() {
		MapBasedWollokGlobalScopeCache
	}

	def Class<? extends WollokLibraryLoader> bindWollokManifestFinder() {
		BasicWollokLibraryLoader
	}

	override configureIScopeProviderDelegate(Binder binder) {
		binder.bind(IScopeProvider).annotatedWith(Names.named(AbstractDeclarativeScopeProvider.NAMED_DELEGATE)).to(
			WollokImportedNamespaceAwareLocalScopeProvider);
	}

	override bindIQualifiedNameProvider() {
		WollokQualifiedNameProvider
	}

	def Class<? extends XInterpreterEvaluator<WollokObject>> bindXInterpreterEvaluator() {
		WollokInterpreterEvaluator
	}

	def Class<? extends WollokInterpreterConsole> bindWollokInterpreterConsole() {
		SysoutWollokInterpreterConsole
	}

	override bindILinker() {
		WollokLinker
	}

	override bindISyntacticSequencer() {
		WollokDslSyntacticSequencerWithSyntheticLinking;
	}

	def Class<? extends SyntaxErrorMessageProvider> bindSyntaxErrorMessageProvider() {
		WollokSyntaxErrorMessageProvider
	}

}
