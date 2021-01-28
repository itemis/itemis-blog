package org.example.domainmodel.ide.contentassist

import com.google.inject.Inject
import org.eclipse.xtext.RuleCall
import org.eclipse.xtext.ide.editor.contentassist.ContentAssistContext
import org.eclipse.xtext.ide.editor.contentassist.IIdeContentProposalAcceptor
import org.eclipse.xtext.ide.editor.contentassist.IdeContentProposalProvider
import org.example.domainmodel.services.DomainmodelGrammarAccess

class DomainmodelIdeContentProposalProvider extends IdeContentProposalProvider {

	@Inject extension DomainmodelGrammarAccess

	override protected _createProposals(RuleCall ruleCall, ContentAssistContext context, IIdeContentProposalAcceptor acceptor) {
		if (typeRule == ruleCall.rule) {
			acceptor.accept(
				proposalCreator.createSnippet('''
					datatype ${1:name}
				''', "datatype template", context), 0)
			acceptor.accept(
				proposalCreator.createSnippet('''
					entity ${1:name} {
						
					}
				''', "entity template", context), 0)
		}
		super._createProposals(ruleCall, context, acceptor)
	}

}