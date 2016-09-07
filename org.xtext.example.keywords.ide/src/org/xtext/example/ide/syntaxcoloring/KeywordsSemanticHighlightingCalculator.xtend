package org.xtext.example.ide.syntaxcoloring

import javax.inject.Inject
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.ide.editor.syntaxcoloring.DefaultSemanticHighlightingCalculator
import org.eclipse.xtext.ide.editor.syntaxcoloring.IHighlightedPositionAcceptor
import org.eclipse.xtext.util.CancelIndicator
import org.xtext.example.keywords.KeywordsPackage
import org.xtext.example.keywords.Type
import org.xtext.example.services.KeywordsGrammarAccess
import org.eclipse.xtext.ide.editor.syntaxcoloring.HighlightingStyles

class KeywordsSemanticHighlightingCalculator extends DefaultSemanticHighlightingCalculator {
	@Inject package KeywordsGrammarAccess grammar

	override protected boolean highlightElement(EObject object, IHighlightedPositionAcceptor acceptor,
		CancelIndicator cancelIndicator) {
		switch (object) {
			Type: {
				highlightFeature(acceptor, object, KeywordsPackage.eINSTANCE.type_Name, HighlightingStyles.DEFAULT_ID)
				return true
			}
			default: false
		}
	}
}
