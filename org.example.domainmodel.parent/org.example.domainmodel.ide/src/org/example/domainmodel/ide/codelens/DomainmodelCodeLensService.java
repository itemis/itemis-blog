package org.example.domainmodel.ide.codelens;

import java.util.ArrayList;
import java.util.List;

import org.eclipse.lsp4j.CodeLens;
import org.eclipse.lsp4j.CodeLensParams;
import org.eclipse.lsp4j.Command;
import org.eclipse.lsp4j.Position;
import org.eclipse.lsp4j.Range;
import org.eclipse.xtext.EcoreUtil2;
import org.eclipse.xtext.ide.server.Document;
import org.eclipse.xtext.ide.server.codelens.ICodeLensService;
import org.eclipse.xtext.nodemodel.ICompositeNode;
import org.eclipse.xtext.nodemodel.util.NodeModelUtils;
import org.eclipse.xtext.resource.XtextResource;
import org.eclipse.xtext.util.CancelIndicator;
import org.example.domainmodel.domainmodel.Entity;

public class DomainmodelCodeLensService implements ICodeLensService {

	@Override
	public List<? extends CodeLens> computeCodeLenses(Document document, XtextResource resource, CodeLensParams params,
			CancelIndicator indicator) {

		List<CodeLens> codeLenses = new ArrayList<>();

		// get all entities in the open document
		List<Entity> allEntities = EcoreUtil2.eAllOfType(resource.getContents().get(0), Entity.class);

		// create a code lens for each entity showing the number of the contained features
		for (Entity entitiy : allEntities) {
			int featuresCount = entitiy.getFeatures().size();
			String codeLensTitle = featuresCount + " feature" + (featuresCount == 1 ? "" : "s");

			ICompositeNode node = NodeModelUtils.getNode(entitiy);
			int codeLensLine = document.getPosition(node.getOffset()).getLine();

			CodeLens codeLens = createCodeLens(codeLensTitle, codeLensLine);
			codeLenses.add(codeLens);
		}

		return codeLenses;
	}

	private CodeLens createCodeLens(String title, int line) {
		CodeLens codeLens = new CodeLens();
		Command command = new Command();
		command.setCommand("");
		command.setTitle(title);
		codeLens.setCommand(command);
		codeLens.setRange(new Range(new Position(line,0), new Position(line, title.length())));
		return codeLens;
	}
}
