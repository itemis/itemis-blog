package org.example.domainmodel.ide.quickfix;

import org.eclipse.xtext.ide.editor.quickfix.AbstractDeclarativeIdeQuickfixProvider;
import org.eclipse.xtext.ide.editor.quickfix.DiagnosticResolutionAcceptor;
import org.eclipse.xtext.ide.editor.quickfix.QuickFix;
import org.eclipse.xtext.xbase.lib.StringExtensions;
import org.example.domainmodel.domainmodel.Entity;
import org.example.domainmodel.validation.DomainmodelValidator;

public class DomainmodelQuickfixProvider extends AbstractDeclarativeIdeQuickfixProvider {

	@QuickFix(DomainmodelValidator.INVALID_NAME)
	public void fixLowerCaseName(DiagnosticResolutionAcceptor acceptor) {
		acceptor.accept("Change entity name to first upper", obj -> {
			final Entity entity = (Entity) obj;
			entity.setName(StringExtensions.toFirstUpper(entity.getName()));
		});
	}

}
