package xtext.workshop.advanced.formatting.ide.contentassist.antlr.internal;

import java.io.InputStream;
import org.eclipse.xtext.*;
import org.eclipse.xtext.parser.*;
import org.eclipse.xtext.parser.impl.*;
import org.eclipse.emf.ecore.util.EcoreUtil;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.parser.antlr.XtextTokenStream;
import org.eclipse.xtext.parser.antlr.XtextTokenStream.HiddenTokens;
import org.eclipse.xtext.ide.editor.contentassist.antlr.internal.AbstractInternalContentAssistParser;
import org.eclipse.xtext.ide.editor.contentassist.antlr.internal.DFA;
import xtext.workshop.advanced.formatting.services.TableGrammarAccess;



import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;

@SuppressWarnings("all")
public class InternalTableParser extends AbstractInternalContentAssistParser {
    public static final String[] tokenNames = new String[] {
        "<invalid>", "<EOR>", "<DOWN>", "<UP>", "RULE_ID", "RULE_STRING", "RULE_INT", "RULE_WS", "RULE_ANY_OTHER", "RULE_ML_COMMENT", "RULE_SL_COMMENT", "'{|'", "'|}'", "'|+'", "'|-'", "'!'", "'|'"
    };
    public static final int RULE_ID=4;
    public static final int RULE_WS=7;
    public static final int RULE_STRING=5;
    public static final int RULE_ANY_OTHER=8;
    public static final int RULE_SL_COMMENT=10;
    public static final int T__15=15;
    public static final int T__16=16;
    public static final int RULE_INT=6;
    public static final int T__11=11;
    public static final int RULE_ML_COMMENT=9;
    public static final int T__12=12;
    public static final int T__13=13;
    public static final int T__14=14;
    public static final int EOF=-1;

    // delegates
    // delegators


        public InternalTableParser(TokenStream input) {
            this(input, new RecognizerSharedState());
        }
        public InternalTableParser(TokenStream input, RecognizerSharedState state) {
            super(input, state);
             
        }
        

    public String[] getTokenNames() { return InternalTableParser.tokenNames; }
    public String getGrammarFileName() { return "InternalTable.g"; }


    	private TableGrammarAccess grammarAccess;

    	public void setGrammarAccess(TableGrammarAccess grammarAccess) {
    		this.grammarAccess = grammarAccess;
    	}

    	@Override
    	protected Grammar getGrammar() {
    		return grammarAccess.getGrammar();
    	}

    	@Override
    	protected String getValueForTokenName(String tokenName) {
    		return tokenName;
    	}



    // $ANTLR start "entryRuleDocument"
    // InternalTable.g:53:1: entryRuleDocument : ruleDocument EOF ;
    public final void entryRuleDocument() throws RecognitionException {
        try {
            // InternalTable.g:54:1: ( ruleDocument EOF )
            // InternalTable.g:55:1: ruleDocument EOF
            {
             before(grammarAccess.getDocumentRule()); 
            pushFollow(FOLLOW_1);
            ruleDocument();

            state._fsp--;

             after(grammarAccess.getDocumentRule()); 
            match(input,EOF,FOLLOW_2); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "entryRuleDocument"


    // $ANTLR start "ruleDocument"
    // InternalTable.g:62:1: ruleDocument : ( ( rule__Document__ElementsAssignment )* ) ;
    public final void ruleDocument() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:66:2: ( ( ( rule__Document__ElementsAssignment )* ) )
            // InternalTable.g:67:2: ( ( rule__Document__ElementsAssignment )* )
            {
            // InternalTable.g:67:2: ( ( rule__Document__ElementsAssignment )* )
            // InternalTable.g:68:3: ( rule__Document__ElementsAssignment )*
            {
             before(grammarAccess.getDocumentAccess().getElementsAssignment()); 
            // InternalTable.g:69:3: ( rule__Document__ElementsAssignment )*
            loop1:
            do {
                int alt1=2;
                int LA1_0 = input.LA(1);

                if ( (LA1_0==11) ) {
                    alt1=1;
                }


                switch (alt1) {
            	case 1 :
            	    // InternalTable.g:69:4: rule__Document__ElementsAssignment
            	    {
            	    pushFollow(FOLLOW_3);
            	    rule__Document__ElementsAssignment();

            	    state._fsp--;


            	    }
            	    break;

            	default :
            	    break loop1;
                }
            } while (true);

             after(grammarAccess.getDocumentAccess().getElementsAssignment()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "ruleDocument"


    // $ANTLR start "entryRuleTable"
    // InternalTable.g:78:1: entryRuleTable : ruleTable EOF ;
    public final void entryRuleTable() throws RecognitionException {
        try {
            // InternalTable.g:79:1: ( ruleTable EOF )
            // InternalTable.g:80:1: ruleTable EOF
            {
             before(grammarAccess.getTableRule()); 
            pushFollow(FOLLOW_1);
            ruleTable();

            state._fsp--;

             after(grammarAccess.getTableRule()); 
            match(input,EOF,FOLLOW_2); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "entryRuleTable"


    // $ANTLR start "ruleTable"
    // InternalTable.g:87:1: ruleTable : ( ( rule__Table__Group__0 ) ) ;
    public final void ruleTable() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:91:2: ( ( ( rule__Table__Group__0 ) ) )
            // InternalTable.g:92:2: ( ( rule__Table__Group__0 ) )
            {
            // InternalTable.g:92:2: ( ( rule__Table__Group__0 ) )
            // InternalTable.g:93:3: ( rule__Table__Group__0 )
            {
             before(grammarAccess.getTableAccess().getGroup()); 
            // InternalTable.g:94:3: ( rule__Table__Group__0 )
            // InternalTable.g:94:4: rule__Table__Group__0
            {
            pushFollow(FOLLOW_2);
            rule__Table__Group__0();

            state._fsp--;


            }

             after(grammarAccess.getTableAccess().getGroup()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "ruleTable"


    // $ANTLR start "entryRuleCaption"
    // InternalTable.g:103:1: entryRuleCaption : ruleCaption EOF ;
    public final void entryRuleCaption() throws RecognitionException {
        try {
            // InternalTable.g:104:1: ( ruleCaption EOF )
            // InternalTable.g:105:1: ruleCaption EOF
            {
             before(grammarAccess.getCaptionRule()); 
            pushFollow(FOLLOW_1);
            ruleCaption();

            state._fsp--;

             after(grammarAccess.getCaptionRule()); 
            match(input,EOF,FOLLOW_2); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "entryRuleCaption"


    // $ANTLR start "ruleCaption"
    // InternalTable.g:112:1: ruleCaption : ( ( rule__Caption__Group__0 ) ) ;
    public final void ruleCaption() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:116:2: ( ( ( rule__Caption__Group__0 ) ) )
            // InternalTable.g:117:2: ( ( rule__Caption__Group__0 ) )
            {
            // InternalTable.g:117:2: ( ( rule__Caption__Group__0 ) )
            // InternalTable.g:118:3: ( rule__Caption__Group__0 )
            {
             before(grammarAccess.getCaptionAccess().getGroup()); 
            // InternalTable.g:119:3: ( rule__Caption__Group__0 )
            // InternalTable.g:119:4: rule__Caption__Group__0
            {
            pushFollow(FOLLOW_2);
            rule__Caption__Group__0();

            state._fsp--;


            }

             after(grammarAccess.getCaptionAccess().getGroup()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "ruleCaption"


    // $ANTLR start "entryRuleRow"
    // InternalTable.g:128:1: entryRuleRow : ruleRow EOF ;
    public final void entryRuleRow() throws RecognitionException {
        try {
            // InternalTable.g:129:1: ( ruleRow EOF )
            // InternalTable.g:130:1: ruleRow EOF
            {
             before(grammarAccess.getRowRule()); 
            pushFollow(FOLLOW_1);
            ruleRow();

            state._fsp--;

             after(grammarAccess.getRowRule()); 
            match(input,EOF,FOLLOW_2); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "entryRuleRow"


    // $ANTLR start "ruleRow"
    // InternalTable.g:137:1: ruleRow : ( ( rule__Row__Group__0 ) ) ;
    public final void ruleRow() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:141:2: ( ( ( rule__Row__Group__0 ) ) )
            // InternalTable.g:142:2: ( ( rule__Row__Group__0 ) )
            {
            // InternalTable.g:142:2: ( ( rule__Row__Group__0 ) )
            // InternalTable.g:143:3: ( rule__Row__Group__0 )
            {
             before(grammarAccess.getRowAccess().getGroup()); 
            // InternalTable.g:144:3: ( rule__Row__Group__0 )
            // InternalTable.g:144:4: rule__Row__Group__0
            {
            pushFollow(FOLLOW_2);
            rule__Row__Group__0();

            state._fsp--;


            }

             after(grammarAccess.getRowAccess().getGroup()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "ruleRow"


    // $ANTLR start "entryRuleCell"
    // InternalTable.g:153:1: entryRuleCell : ruleCell EOF ;
    public final void entryRuleCell() throws RecognitionException {
        try {
            // InternalTable.g:154:1: ( ruleCell EOF )
            // InternalTable.g:155:1: ruleCell EOF
            {
             before(grammarAccess.getCellRule()); 
            pushFollow(FOLLOW_1);
            ruleCell();

            state._fsp--;

             after(grammarAccess.getCellRule()); 
            match(input,EOF,FOLLOW_2); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "entryRuleCell"


    // $ANTLR start "ruleCell"
    // InternalTable.g:162:1: ruleCell : ( ( rule__Cell__Alternatives ) ) ;
    public final void ruleCell() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:166:2: ( ( ( rule__Cell__Alternatives ) ) )
            // InternalTable.g:167:2: ( ( rule__Cell__Alternatives ) )
            {
            // InternalTable.g:167:2: ( ( rule__Cell__Alternatives ) )
            // InternalTable.g:168:3: ( rule__Cell__Alternatives )
            {
             before(grammarAccess.getCellAccess().getAlternatives()); 
            // InternalTable.g:169:3: ( rule__Cell__Alternatives )
            // InternalTable.g:169:4: rule__Cell__Alternatives
            {
            pushFollow(FOLLOW_2);
            rule__Cell__Alternatives();

            state._fsp--;


            }

             after(grammarAccess.getCellAccess().getAlternatives()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "ruleCell"


    // $ANTLR start "entryRuleHeaderCell"
    // InternalTable.g:178:1: entryRuleHeaderCell : ruleHeaderCell EOF ;
    public final void entryRuleHeaderCell() throws RecognitionException {
        try {
            // InternalTable.g:179:1: ( ruleHeaderCell EOF )
            // InternalTable.g:180:1: ruleHeaderCell EOF
            {
             before(grammarAccess.getHeaderCellRule()); 
            pushFollow(FOLLOW_1);
            ruleHeaderCell();

            state._fsp--;

             after(grammarAccess.getHeaderCellRule()); 
            match(input,EOF,FOLLOW_2); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "entryRuleHeaderCell"


    // $ANTLR start "ruleHeaderCell"
    // InternalTable.g:187:1: ruleHeaderCell : ( ( rule__HeaderCell__Group__0 ) ) ;
    public final void ruleHeaderCell() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:191:2: ( ( ( rule__HeaderCell__Group__0 ) ) )
            // InternalTable.g:192:2: ( ( rule__HeaderCell__Group__0 ) )
            {
            // InternalTable.g:192:2: ( ( rule__HeaderCell__Group__0 ) )
            // InternalTable.g:193:3: ( rule__HeaderCell__Group__0 )
            {
             before(grammarAccess.getHeaderCellAccess().getGroup()); 
            // InternalTable.g:194:3: ( rule__HeaderCell__Group__0 )
            // InternalTable.g:194:4: rule__HeaderCell__Group__0
            {
            pushFollow(FOLLOW_2);
            rule__HeaderCell__Group__0();

            state._fsp--;


            }

             after(grammarAccess.getHeaderCellAccess().getGroup()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "ruleHeaderCell"


    // $ANTLR start "entryRuleDataCell"
    // InternalTable.g:203:1: entryRuleDataCell : ruleDataCell EOF ;
    public final void entryRuleDataCell() throws RecognitionException {
        try {
            // InternalTable.g:204:1: ( ruleDataCell EOF )
            // InternalTable.g:205:1: ruleDataCell EOF
            {
             before(grammarAccess.getDataCellRule()); 
            pushFollow(FOLLOW_1);
            ruleDataCell();

            state._fsp--;

             after(grammarAccess.getDataCellRule()); 
            match(input,EOF,FOLLOW_2); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "entryRuleDataCell"


    // $ANTLR start "ruleDataCell"
    // InternalTable.g:212:1: ruleDataCell : ( ( rule__DataCell__Group__0 ) ) ;
    public final void ruleDataCell() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:216:2: ( ( ( rule__DataCell__Group__0 ) ) )
            // InternalTable.g:217:2: ( ( rule__DataCell__Group__0 ) )
            {
            // InternalTable.g:217:2: ( ( rule__DataCell__Group__0 ) )
            // InternalTable.g:218:3: ( rule__DataCell__Group__0 )
            {
             before(grammarAccess.getDataCellAccess().getGroup()); 
            // InternalTable.g:219:3: ( rule__DataCell__Group__0 )
            // InternalTable.g:219:4: rule__DataCell__Group__0
            {
            pushFollow(FOLLOW_2);
            rule__DataCell__Group__0();

            state._fsp--;


            }

             after(grammarAccess.getDataCellAccess().getGroup()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "ruleDataCell"


    // $ANTLR start "entryRuleLabel"
    // InternalTable.g:228:1: entryRuleLabel : ruleLabel EOF ;
    public final void entryRuleLabel() throws RecognitionException {
        try {
            // InternalTable.g:229:1: ( ruleLabel EOF )
            // InternalTable.g:230:1: ruleLabel EOF
            {
             before(grammarAccess.getLabelRule()); 
            pushFollow(FOLLOW_1);
            ruleLabel();

            state._fsp--;

             after(grammarAccess.getLabelRule()); 
            match(input,EOF,FOLLOW_2); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "entryRuleLabel"


    // $ANTLR start "ruleLabel"
    // InternalTable.g:237:1: ruleLabel : ( ( rule__Label__Alternatives )* ) ;
    public final void ruleLabel() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:241:2: ( ( ( rule__Label__Alternatives )* ) )
            // InternalTable.g:242:2: ( ( rule__Label__Alternatives )* )
            {
            // InternalTable.g:242:2: ( ( rule__Label__Alternatives )* )
            // InternalTable.g:243:3: ( rule__Label__Alternatives )*
            {
             before(grammarAccess.getLabelAccess().getAlternatives()); 
            // InternalTable.g:244:3: ( rule__Label__Alternatives )*
            loop2:
            do {
                int alt2=2;
                int LA2_0 = input.LA(1);

                if ( ((LA2_0>=RULE_ID && LA2_0<=RULE_ANY_OTHER)) ) {
                    alt2=1;
                }


                switch (alt2) {
            	case 1 :
            	    // InternalTable.g:244:4: rule__Label__Alternatives
            	    {
            	    pushFollow(FOLLOW_4);
            	    rule__Label__Alternatives();

            	    state._fsp--;


            	    }
            	    break;

            	default :
            	    break loop2;
                }
            } while (true);

             after(grammarAccess.getLabelAccess().getAlternatives()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "ruleLabel"


    // $ANTLR start "rule__Cell__Alternatives"
    // InternalTable.g:252:1: rule__Cell__Alternatives : ( ( ruleHeaderCell ) | ( ruleDataCell ) );
    public final void rule__Cell__Alternatives() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:256:1: ( ( ruleHeaderCell ) | ( ruleDataCell ) )
            int alt3=2;
            int LA3_0 = input.LA(1);

            if ( (LA3_0==15) ) {
                alt3=1;
            }
            else if ( (LA3_0==16) ) {
                alt3=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 3, 0, input);

                throw nvae;
            }
            switch (alt3) {
                case 1 :
                    // InternalTable.g:257:2: ( ruleHeaderCell )
                    {
                    // InternalTable.g:257:2: ( ruleHeaderCell )
                    // InternalTable.g:258:3: ruleHeaderCell
                    {
                     before(grammarAccess.getCellAccess().getHeaderCellParserRuleCall_0()); 
                    pushFollow(FOLLOW_2);
                    ruleHeaderCell();

                    state._fsp--;

                     after(grammarAccess.getCellAccess().getHeaderCellParserRuleCall_0()); 

                    }


                    }
                    break;
                case 2 :
                    // InternalTable.g:263:2: ( ruleDataCell )
                    {
                    // InternalTable.g:263:2: ( ruleDataCell )
                    // InternalTable.g:264:3: ruleDataCell
                    {
                     before(grammarAccess.getCellAccess().getDataCellParserRuleCall_1()); 
                    pushFollow(FOLLOW_2);
                    ruleDataCell();

                    state._fsp--;

                     after(grammarAccess.getCellAccess().getDataCellParserRuleCall_1()); 

                    }


                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Cell__Alternatives"


    // $ANTLR start "rule__Label__Alternatives"
    // InternalTable.g:273:1: rule__Label__Alternatives : ( ( RULE_ID ) | ( RULE_STRING ) | ( RULE_INT ) | ( RULE_WS ) | ( RULE_ANY_OTHER ) );
    public final void rule__Label__Alternatives() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:277:1: ( ( RULE_ID ) | ( RULE_STRING ) | ( RULE_INT ) | ( RULE_WS ) | ( RULE_ANY_OTHER ) )
            int alt4=5;
            switch ( input.LA(1) ) {
            case RULE_ID:
                {
                alt4=1;
                }
                break;
            case RULE_STRING:
                {
                alt4=2;
                }
                break;
            case RULE_INT:
                {
                alt4=3;
                }
                break;
            case RULE_WS:
                {
                alt4=4;
                }
                break;
            case RULE_ANY_OTHER:
                {
                alt4=5;
                }
                break;
            default:
                NoViableAltException nvae =
                    new NoViableAltException("", 4, 0, input);

                throw nvae;
            }

            switch (alt4) {
                case 1 :
                    // InternalTable.g:278:2: ( RULE_ID )
                    {
                    // InternalTable.g:278:2: ( RULE_ID )
                    // InternalTable.g:279:3: RULE_ID
                    {
                     before(grammarAccess.getLabelAccess().getIDTerminalRuleCall_0()); 
                    match(input,RULE_ID,FOLLOW_2); 
                     after(grammarAccess.getLabelAccess().getIDTerminalRuleCall_0()); 

                    }


                    }
                    break;
                case 2 :
                    // InternalTable.g:284:2: ( RULE_STRING )
                    {
                    // InternalTable.g:284:2: ( RULE_STRING )
                    // InternalTable.g:285:3: RULE_STRING
                    {
                     before(grammarAccess.getLabelAccess().getSTRINGTerminalRuleCall_1()); 
                    match(input,RULE_STRING,FOLLOW_2); 
                     after(grammarAccess.getLabelAccess().getSTRINGTerminalRuleCall_1()); 

                    }


                    }
                    break;
                case 3 :
                    // InternalTable.g:290:2: ( RULE_INT )
                    {
                    // InternalTable.g:290:2: ( RULE_INT )
                    // InternalTable.g:291:3: RULE_INT
                    {
                     before(grammarAccess.getLabelAccess().getINTTerminalRuleCall_2()); 
                    match(input,RULE_INT,FOLLOW_2); 
                     after(grammarAccess.getLabelAccess().getINTTerminalRuleCall_2()); 

                    }


                    }
                    break;
                case 4 :
                    // InternalTable.g:296:2: ( RULE_WS )
                    {
                    // InternalTable.g:296:2: ( RULE_WS )
                    // InternalTable.g:297:3: RULE_WS
                    {
                     before(grammarAccess.getLabelAccess().getWSTerminalRuleCall_3()); 
                    match(input,RULE_WS,FOLLOW_2); 
                     after(grammarAccess.getLabelAccess().getWSTerminalRuleCall_3()); 

                    }


                    }
                    break;
                case 5 :
                    // InternalTable.g:302:2: ( RULE_ANY_OTHER )
                    {
                    // InternalTable.g:302:2: ( RULE_ANY_OTHER )
                    // InternalTable.g:303:3: RULE_ANY_OTHER
                    {
                     before(grammarAccess.getLabelAccess().getANY_OTHERTerminalRuleCall_4()); 
                    match(input,RULE_ANY_OTHER,FOLLOW_2); 
                     after(grammarAccess.getLabelAccess().getANY_OTHERTerminalRuleCall_4()); 

                    }


                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Label__Alternatives"


    // $ANTLR start "rule__Table__Group__0"
    // InternalTable.g:312:1: rule__Table__Group__0 : rule__Table__Group__0__Impl rule__Table__Group__1 ;
    public final void rule__Table__Group__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:316:1: ( rule__Table__Group__0__Impl rule__Table__Group__1 )
            // InternalTable.g:317:2: rule__Table__Group__0__Impl rule__Table__Group__1
            {
            pushFollow(FOLLOW_5);
            rule__Table__Group__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__Table__Group__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Table__Group__0"


    // $ANTLR start "rule__Table__Group__0__Impl"
    // InternalTable.g:324:1: rule__Table__Group__0__Impl : ( () ) ;
    public final void rule__Table__Group__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:328:1: ( ( () ) )
            // InternalTable.g:329:1: ( () )
            {
            // InternalTable.g:329:1: ( () )
            // InternalTable.g:330:2: ()
            {
             before(grammarAccess.getTableAccess().getTableAction_0()); 
            // InternalTable.g:331:2: ()
            // InternalTable.g:331:3: 
            {
            }

             after(grammarAccess.getTableAccess().getTableAction_0()); 

            }


            }

        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Table__Group__0__Impl"


    // $ANTLR start "rule__Table__Group__1"
    // InternalTable.g:339:1: rule__Table__Group__1 : rule__Table__Group__1__Impl rule__Table__Group__2 ;
    public final void rule__Table__Group__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:343:1: ( rule__Table__Group__1__Impl rule__Table__Group__2 )
            // InternalTable.g:344:2: rule__Table__Group__1__Impl rule__Table__Group__2
            {
            pushFollow(FOLLOW_6);
            rule__Table__Group__1__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__Table__Group__2();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Table__Group__1"


    // $ANTLR start "rule__Table__Group__1__Impl"
    // InternalTable.g:351:1: rule__Table__Group__1__Impl : ( '{|' ) ;
    public final void rule__Table__Group__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:355:1: ( ( '{|' ) )
            // InternalTable.g:356:1: ( '{|' )
            {
            // InternalTable.g:356:1: ( '{|' )
            // InternalTable.g:357:2: '{|'
            {
             before(grammarAccess.getTableAccess().getLeftCurlyBracketVerticalLineKeyword_1()); 
            match(input,11,FOLLOW_2); 
             after(grammarAccess.getTableAccess().getLeftCurlyBracketVerticalLineKeyword_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Table__Group__1__Impl"


    // $ANTLR start "rule__Table__Group__2"
    // InternalTable.g:366:1: rule__Table__Group__2 : rule__Table__Group__2__Impl rule__Table__Group__3 ;
    public final void rule__Table__Group__2() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:370:1: ( rule__Table__Group__2__Impl rule__Table__Group__3 )
            // InternalTable.g:371:2: rule__Table__Group__2__Impl rule__Table__Group__3
            {
            pushFollow(FOLLOW_6);
            rule__Table__Group__2__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__Table__Group__3();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Table__Group__2"


    // $ANTLR start "rule__Table__Group__2__Impl"
    // InternalTable.g:378:1: rule__Table__Group__2__Impl : ( ( rule__Table__CaptionAssignment_2 )? ) ;
    public final void rule__Table__Group__2__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:382:1: ( ( ( rule__Table__CaptionAssignment_2 )? ) )
            // InternalTable.g:383:1: ( ( rule__Table__CaptionAssignment_2 )? )
            {
            // InternalTable.g:383:1: ( ( rule__Table__CaptionAssignment_2 )? )
            // InternalTable.g:384:2: ( rule__Table__CaptionAssignment_2 )?
            {
             before(grammarAccess.getTableAccess().getCaptionAssignment_2()); 
            // InternalTable.g:385:2: ( rule__Table__CaptionAssignment_2 )?
            int alt5=2;
            int LA5_0 = input.LA(1);

            if ( (LA5_0==13) ) {
                alt5=1;
            }
            switch (alt5) {
                case 1 :
                    // InternalTable.g:385:3: rule__Table__CaptionAssignment_2
                    {
                    pushFollow(FOLLOW_2);
                    rule__Table__CaptionAssignment_2();

                    state._fsp--;


                    }
                    break;

            }

             after(grammarAccess.getTableAccess().getCaptionAssignment_2()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Table__Group__2__Impl"


    // $ANTLR start "rule__Table__Group__3"
    // InternalTable.g:393:1: rule__Table__Group__3 : rule__Table__Group__3__Impl rule__Table__Group__4 ;
    public final void rule__Table__Group__3() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:397:1: ( rule__Table__Group__3__Impl rule__Table__Group__4 )
            // InternalTable.g:398:2: rule__Table__Group__3__Impl rule__Table__Group__4
            {
            pushFollow(FOLLOW_6);
            rule__Table__Group__3__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__Table__Group__4();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Table__Group__3"


    // $ANTLR start "rule__Table__Group__3__Impl"
    // InternalTable.g:405:1: rule__Table__Group__3__Impl : ( ( rule__Table__RowsAssignment_3 )* ) ;
    public final void rule__Table__Group__3__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:409:1: ( ( ( rule__Table__RowsAssignment_3 )* ) )
            // InternalTable.g:410:1: ( ( rule__Table__RowsAssignment_3 )* )
            {
            // InternalTable.g:410:1: ( ( rule__Table__RowsAssignment_3 )* )
            // InternalTable.g:411:2: ( rule__Table__RowsAssignment_3 )*
            {
             before(grammarAccess.getTableAccess().getRowsAssignment_3()); 
            // InternalTable.g:412:2: ( rule__Table__RowsAssignment_3 )*
            loop6:
            do {
                int alt6=2;
                int LA6_0 = input.LA(1);

                if ( (LA6_0==14) ) {
                    alt6=1;
                }


                switch (alt6) {
            	case 1 :
            	    // InternalTable.g:412:3: rule__Table__RowsAssignment_3
            	    {
            	    pushFollow(FOLLOW_7);
            	    rule__Table__RowsAssignment_3();

            	    state._fsp--;


            	    }
            	    break;

            	default :
            	    break loop6;
                }
            } while (true);

             after(grammarAccess.getTableAccess().getRowsAssignment_3()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Table__Group__3__Impl"


    // $ANTLR start "rule__Table__Group__4"
    // InternalTable.g:420:1: rule__Table__Group__4 : rule__Table__Group__4__Impl ;
    public final void rule__Table__Group__4() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:424:1: ( rule__Table__Group__4__Impl )
            // InternalTable.g:425:2: rule__Table__Group__4__Impl
            {
            pushFollow(FOLLOW_2);
            rule__Table__Group__4__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Table__Group__4"


    // $ANTLR start "rule__Table__Group__4__Impl"
    // InternalTable.g:431:1: rule__Table__Group__4__Impl : ( '|}' ) ;
    public final void rule__Table__Group__4__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:435:1: ( ( '|}' ) )
            // InternalTable.g:436:1: ( '|}' )
            {
            // InternalTable.g:436:1: ( '|}' )
            // InternalTable.g:437:2: '|}'
            {
             before(grammarAccess.getTableAccess().getVerticalLineRightCurlyBracketKeyword_4()); 
            match(input,12,FOLLOW_2); 
             after(grammarAccess.getTableAccess().getVerticalLineRightCurlyBracketKeyword_4()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Table__Group__4__Impl"


    // $ANTLR start "rule__Caption__Group__0"
    // InternalTable.g:447:1: rule__Caption__Group__0 : rule__Caption__Group__0__Impl rule__Caption__Group__1 ;
    public final void rule__Caption__Group__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:451:1: ( rule__Caption__Group__0__Impl rule__Caption__Group__1 )
            // InternalTable.g:452:2: rule__Caption__Group__0__Impl rule__Caption__Group__1
            {
            pushFollow(FOLLOW_8);
            rule__Caption__Group__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__Caption__Group__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Caption__Group__0"


    // $ANTLR start "rule__Caption__Group__0__Impl"
    // InternalTable.g:459:1: rule__Caption__Group__0__Impl : ( '|+' ) ;
    public final void rule__Caption__Group__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:463:1: ( ( '|+' ) )
            // InternalTable.g:464:1: ( '|+' )
            {
            // InternalTable.g:464:1: ( '|+' )
            // InternalTable.g:465:2: '|+'
            {
             before(grammarAccess.getCaptionAccess().getVerticalLinePlusSignKeyword_0()); 
            match(input,13,FOLLOW_2); 
             after(grammarAccess.getCaptionAccess().getVerticalLinePlusSignKeyword_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Caption__Group__0__Impl"


    // $ANTLR start "rule__Caption__Group__1"
    // InternalTable.g:474:1: rule__Caption__Group__1 : rule__Caption__Group__1__Impl ;
    public final void rule__Caption__Group__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:478:1: ( rule__Caption__Group__1__Impl )
            // InternalTable.g:479:2: rule__Caption__Group__1__Impl
            {
            pushFollow(FOLLOW_2);
            rule__Caption__Group__1__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Caption__Group__1"


    // $ANTLR start "rule__Caption__Group__1__Impl"
    // InternalTable.g:485:1: rule__Caption__Group__1__Impl : ( ( rule__Caption__LabelAssignment_1 ) ) ;
    public final void rule__Caption__Group__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:489:1: ( ( ( rule__Caption__LabelAssignment_1 ) ) )
            // InternalTable.g:490:1: ( ( rule__Caption__LabelAssignment_1 ) )
            {
            // InternalTable.g:490:1: ( ( rule__Caption__LabelAssignment_1 ) )
            // InternalTable.g:491:2: ( rule__Caption__LabelAssignment_1 )
            {
             before(grammarAccess.getCaptionAccess().getLabelAssignment_1()); 
            // InternalTable.g:492:2: ( rule__Caption__LabelAssignment_1 )
            // InternalTable.g:492:3: rule__Caption__LabelAssignment_1
            {
            pushFollow(FOLLOW_2);
            rule__Caption__LabelAssignment_1();

            state._fsp--;


            }

             after(grammarAccess.getCaptionAccess().getLabelAssignment_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Caption__Group__1__Impl"


    // $ANTLR start "rule__Row__Group__0"
    // InternalTable.g:501:1: rule__Row__Group__0 : rule__Row__Group__0__Impl rule__Row__Group__1 ;
    public final void rule__Row__Group__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:505:1: ( rule__Row__Group__0__Impl rule__Row__Group__1 )
            // InternalTable.g:506:2: rule__Row__Group__0__Impl rule__Row__Group__1
            {
            pushFollow(FOLLOW_9);
            rule__Row__Group__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__Row__Group__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Row__Group__0"


    // $ANTLR start "rule__Row__Group__0__Impl"
    // InternalTable.g:513:1: rule__Row__Group__0__Impl : ( () ) ;
    public final void rule__Row__Group__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:517:1: ( ( () ) )
            // InternalTable.g:518:1: ( () )
            {
            // InternalTable.g:518:1: ( () )
            // InternalTable.g:519:2: ()
            {
             before(grammarAccess.getRowAccess().getRowAction_0()); 
            // InternalTable.g:520:2: ()
            // InternalTable.g:520:3: 
            {
            }

             after(grammarAccess.getRowAccess().getRowAction_0()); 

            }


            }

        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Row__Group__0__Impl"


    // $ANTLR start "rule__Row__Group__1"
    // InternalTable.g:528:1: rule__Row__Group__1 : rule__Row__Group__1__Impl rule__Row__Group__2 ;
    public final void rule__Row__Group__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:532:1: ( rule__Row__Group__1__Impl rule__Row__Group__2 )
            // InternalTable.g:533:2: rule__Row__Group__1__Impl rule__Row__Group__2
            {
            pushFollow(FOLLOW_10);
            rule__Row__Group__1__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__Row__Group__2();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Row__Group__1"


    // $ANTLR start "rule__Row__Group__1__Impl"
    // InternalTable.g:540:1: rule__Row__Group__1__Impl : ( '|-' ) ;
    public final void rule__Row__Group__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:544:1: ( ( '|-' ) )
            // InternalTable.g:545:1: ( '|-' )
            {
            // InternalTable.g:545:1: ( '|-' )
            // InternalTable.g:546:2: '|-'
            {
             before(grammarAccess.getRowAccess().getVerticalLineHyphenMinusKeyword_1()); 
            match(input,14,FOLLOW_2); 
             after(grammarAccess.getRowAccess().getVerticalLineHyphenMinusKeyword_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Row__Group__1__Impl"


    // $ANTLR start "rule__Row__Group__2"
    // InternalTable.g:555:1: rule__Row__Group__2 : rule__Row__Group__2__Impl ;
    public final void rule__Row__Group__2() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:559:1: ( rule__Row__Group__2__Impl )
            // InternalTable.g:560:2: rule__Row__Group__2__Impl
            {
            pushFollow(FOLLOW_2);
            rule__Row__Group__2__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Row__Group__2"


    // $ANTLR start "rule__Row__Group__2__Impl"
    // InternalTable.g:566:1: rule__Row__Group__2__Impl : ( ( rule__Row__CellsAssignment_2 )* ) ;
    public final void rule__Row__Group__2__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:570:1: ( ( ( rule__Row__CellsAssignment_2 )* ) )
            // InternalTable.g:571:1: ( ( rule__Row__CellsAssignment_2 )* )
            {
            // InternalTable.g:571:1: ( ( rule__Row__CellsAssignment_2 )* )
            // InternalTable.g:572:2: ( rule__Row__CellsAssignment_2 )*
            {
             before(grammarAccess.getRowAccess().getCellsAssignment_2()); 
            // InternalTable.g:573:2: ( rule__Row__CellsAssignment_2 )*
            loop7:
            do {
                int alt7=2;
                int LA7_0 = input.LA(1);

                if ( ((LA7_0>=15 && LA7_0<=16)) ) {
                    alt7=1;
                }


                switch (alt7) {
            	case 1 :
            	    // InternalTable.g:573:3: rule__Row__CellsAssignment_2
            	    {
            	    pushFollow(FOLLOW_11);
            	    rule__Row__CellsAssignment_2();

            	    state._fsp--;


            	    }
            	    break;

            	default :
            	    break loop7;
                }
            } while (true);

             after(grammarAccess.getRowAccess().getCellsAssignment_2()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Row__Group__2__Impl"


    // $ANTLR start "rule__HeaderCell__Group__0"
    // InternalTable.g:582:1: rule__HeaderCell__Group__0 : rule__HeaderCell__Group__0__Impl rule__HeaderCell__Group__1 ;
    public final void rule__HeaderCell__Group__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:586:1: ( rule__HeaderCell__Group__0__Impl rule__HeaderCell__Group__1 )
            // InternalTable.g:587:2: rule__HeaderCell__Group__0__Impl rule__HeaderCell__Group__1
            {
            pushFollow(FOLLOW_8);
            rule__HeaderCell__Group__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__HeaderCell__Group__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__HeaderCell__Group__0"


    // $ANTLR start "rule__HeaderCell__Group__0__Impl"
    // InternalTable.g:594:1: rule__HeaderCell__Group__0__Impl : ( '!' ) ;
    public final void rule__HeaderCell__Group__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:598:1: ( ( '!' ) )
            // InternalTable.g:599:1: ( '!' )
            {
            // InternalTable.g:599:1: ( '!' )
            // InternalTable.g:600:2: '!'
            {
             before(grammarAccess.getHeaderCellAccess().getExclamationMarkKeyword_0()); 
            match(input,15,FOLLOW_2); 
             after(grammarAccess.getHeaderCellAccess().getExclamationMarkKeyword_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__HeaderCell__Group__0__Impl"


    // $ANTLR start "rule__HeaderCell__Group__1"
    // InternalTable.g:609:1: rule__HeaderCell__Group__1 : rule__HeaderCell__Group__1__Impl ;
    public final void rule__HeaderCell__Group__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:613:1: ( rule__HeaderCell__Group__1__Impl )
            // InternalTable.g:614:2: rule__HeaderCell__Group__1__Impl
            {
            pushFollow(FOLLOW_2);
            rule__HeaderCell__Group__1__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__HeaderCell__Group__1"


    // $ANTLR start "rule__HeaderCell__Group__1__Impl"
    // InternalTable.g:620:1: rule__HeaderCell__Group__1__Impl : ( ( rule__HeaderCell__TextAssignment_1 ) ) ;
    public final void rule__HeaderCell__Group__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:624:1: ( ( ( rule__HeaderCell__TextAssignment_1 ) ) )
            // InternalTable.g:625:1: ( ( rule__HeaderCell__TextAssignment_1 ) )
            {
            // InternalTable.g:625:1: ( ( rule__HeaderCell__TextAssignment_1 ) )
            // InternalTable.g:626:2: ( rule__HeaderCell__TextAssignment_1 )
            {
             before(grammarAccess.getHeaderCellAccess().getTextAssignment_1()); 
            // InternalTable.g:627:2: ( rule__HeaderCell__TextAssignment_1 )
            // InternalTable.g:627:3: rule__HeaderCell__TextAssignment_1
            {
            pushFollow(FOLLOW_2);
            rule__HeaderCell__TextAssignment_1();

            state._fsp--;


            }

             after(grammarAccess.getHeaderCellAccess().getTextAssignment_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__HeaderCell__Group__1__Impl"


    // $ANTLR start "rule__DataCell__Group__0"
    // InternalTable.g:636:1: rule__DataCell__Group__0 : rule__DataCell__Group__0__Impl rule__DataCell__Group__1 ;
    public final void rule__DataCell__Group__0() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:640:1: ( rule__DataCell__Group__0__Impl rule__DataCell__Group__1 )
            // InternalTable.g:641:2: rule__DataCell__Group__0__Impl rule__DataCell__Group__1
            {
            pushFollow(FOLLOW_8);
            rule__DataCell__Group__0__Impl();

            state._fsp--;

            pushFollow(FOLLOW_2);
            rule__DataCell__Group__1();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__DataCell__Group__0"


    // $ANTLR start "rule__DataCell__Group__0__Impl"
    // InternalTable.g:648:1: rule__DataCell__Group__0__Impl : ( '|' ) ;
    public final void rule__DataCell__Group__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:652:1: ( ( '|' ) )
            // InternalTable.g:653:1: ( '|' )
            {
            // InternalTable.g:653:1: ( '|' )
            // InternalTable.g:654:2: '|'
            {
             before(grammarAccess.getDataCellAccess().getVerticalLineKeyword_0()); 
            match(input,16,FOLLOW_2); 
             after(grammarAccess.getDataCellAccess().getVerticalLineKeyword_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__DataCell__Group__0__Impl"


    // $ANTLR start "rule__DataCell__Group__1"
    // InternalTable.g:663:1: rule__DataCell__Group__1 : rule__DataCell__Group__1__Impl ;
    public final void rule__DataCell__Group__1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:667:1: ( rule__DataCell__Group__1__Impl )
            // InternalTable.g:668:2: rule__DataCell__Group__1__Impl
            {
            pushFollow(FOLLOW_2);
            rule__DataCell__Group__1__Impl();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__DataCell__Group__1"


    // $ANTLR start "rule__DataCell__Group__1__Impl"
    // InternalTable.g:674:1: rule__DataCell__Group__1__Impl : ( ( rule__DataCell__TextAssignment_1 ) ) ;
    public final void rule__DataCell__Group__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:678:1: ( ( ( rule__DataCell__TextAssignment_1 ) ) )
            // InternalTable.g:679:1: ( ( rule__DataCell__TextAssignment_1 ) )
            {
            // InternalTable.g:679:1: ( ( rule__DataCell__TextAssignment_1 ) )
            // InternalTable.g:680:2: ( rule__DataCell__TextAssignment_1 )
            {
             before(grammarAccess.getDataCellAccess().getTextAssignment_1()); 
            // InternalTable.g:681:2: ( rule__DataCell__TextAssignment_1 )
            // InternalTable.g:681:3: rule__DataCell__TextAssignment_1
            {
            pushFollow(FOLLOW_2);
            rule__DataCell__TextAssignment_1();

            state._fsp--;


            }

             after(grammarAccess.getDataCellAccess().getTextAssignment_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__DataCell__Group__1__Impl"


    // $ANTLR start "rule__Document__ElementsAssignment"
    // InternalTable.g:690:1: rule__Document__ElementsAssignment : ( ruleTable ) ;
    public final void rule__Document__ElementsAssignment() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:694:1: ( ( ruleTable ) )
            // InternalTable.g:695:2: ( ruleTable )
            {
            // InternalTable.g:695:2: ( ruleTable )
            // InternalTable.g:696:3: ruleTable
            {
             before(grammarAccess.getDocumentAccess().getElementsTableParserRuleCall_0()); 
            pushFollow(FOLLOW_2);
            ruleTable();

            state._fsp--;

             after(grammarAccess.getDocumentAccess().getElementsTableParserRuleCall_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Document__ElementsAssignment"


    // $ANTLR start "rule__Table__CaptionAssignment_2"
    // InternalTable.g:705:1: rule__Table__CaptionAssignment_2 : ( ruleCaption ) ;
    public final void rule__Table__CaptionAssignment_2() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:709:1: ( ( ruleCaption ) )
            // InternalTable.g:710:2: ( ruleCaption )
            {
            // InternalTable.g:710:2: ( ruleCaption )
            // InternalTable.g:711:3: ruleCaption
            {
             before(grammarAccess.getTableAccess().getCaptionCaptionParserRuleCall_2_0()); 
            pushFollow(FOLLOW_2);
            ruleCaption();

            state._fsp--;

             after(grammarAccess.getTableAccess().getCaptionCaptionParserRuleCall_2_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Table__CaptionAssignment_2"


    // $ANTLR start "rule__Table__RowsAssignment_3"
    // InternalTable.g:720:1: rule__Table__RowsAssignment_3 : ( ruleRow ) ;
    public final void rule__Table__RowsAssignment_3() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:724:1: ( ( ruleRow ) )
            // InternalTable.g:725:2: ( ruleRow )
            {
            // InternalTable.g:725:2: ( ruleRow )
            // InternalTable.g:726:3: ruleRow
            {
             before(grammarAccess.getTableAccess().getRowsRowParserRuleCall_3_0()); 
            pushFollow(FOLLOW_2);
            ruleRow();

            state._fsp--;

             after(grammarAccess.getTableAccess().getRowsRowParserRuleCall_3_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Table__RowsAssignment_3"


    // $ANTLR start "rule__Caption__LabelAssignment_1"
    // InternalTable.g:735:1: rule__Caption__LabelAssignment_1 : ( ruleLabel ) ;
    public final void rule__Caption__LabelAssignment_1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:739:1: ( ( ruleLabel ) )
            // InternalTable.g:740:2: ( ruleLabel )
            {
            // InternalTable.g:740:2: ( ruleLabel )
            // InternalTable.g:741:3: ruleLabel
            {
             before(grammarAccess.getCaptionAccess().getLabelLabelParserRuleCall_1_0()); 
            pushFollow(FOLLOW_2);
            ruleLabel();

            state._fsp--;

             after(grammarAccess.getCaptionAccess().getLabelLabelParserRuleCall_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Caption__LabelAssignment_1"


    // $ANTLR start "rule__Row__CellsAssignment_2"
    // InternalTable.g:750:1: rule__Row__CellsAssignment_2 : ( ruleCell ) ;
    public final void rule__Row__CellsAssignment_2() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:754:1: ( ( ruleCell ) )
            // InternalTable.g:755:2: ( ruleCell )
            {
            // InternalTable.g:755:2: ( ruleCell )
            // InternalTable.g:756:3: ruleCell
            {
             before(grammarAccess.getRowAccess().getCellsCellParserRuleCall_2_0()); 
            pushFollow(FOLLOW_2);
            ruleCell();

            state._fsp--;

             after(grammarAccess.getRowAccess().getCellsCellParserRuleCall_2_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__Row__CellsAssignment_2"


    // $ANTLR start "rule__HeaderCell__TextAssignment_1"
    // InternalTable.g:765:1: rule__HeaderCell__TextAssignment_1 : ( ruleLabel ) ;
    public final void rule__HeaderCell__TextAssignment_1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:769:1: ( ( ruleLabel ) )
            // InternalTable.g:770:2: ( ruleLabel )
            {
            // InternalTable.g:770:2: ( ruleLabel )
            // InternalTable.g:771:3: ruleLabel
            {
             before(grammarAccess.getHeaderCellAccess().getTextLabelParserRuleCall_1_0()); 
            pushFollow(FOLLOW_2);
            ruleLabel();

            state._fsp--;

             after(grammarAccess.getHeaderCellAccess().getTextLabelParserRuleCall_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__HeaderCell__TextAssignment_1"


    // $ANTLR start "rule__DataCell__TextAssignment_1"
    // InternalTable.g:780:1: rule__DataCell__TextAssignment_1 : ( ruleLabel ) ;
    public final void rule__DataCell__TextAssignment_1() throws RecognitionException {

        		int stackSize = keepStackSize();
        	
        try {
            // InternalTable.g:784:1: ( ( ruleLabel ) )
            // InternalTable.g:785:2: ( ruleLabel )
            {
            // InternalTable.g:785:2: ( ruleLabel )
            // InternalTable.g:786:3: ruleLabel
            {
             before(grammarAccess.getDataCellAccess().getTextLabelParserRuleCall_1_0()); 
            pushFollow(FOLLOW_2);
            ruleLabel();

            state._fsp--;

             after(grammarAccess.getDataCellAccess().getTextLabelParserRuleCall_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end "rule__DataCell__TextAssignment_1"

    // Delegated rules


 

    public static final BitSet FOLLOW_1 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_2 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_3 = new BitSet(new long[]{0x0000000000000802L});
    public static final BitSet FOLLOW_4 = new BitSet(new long[]{0x00000000000001F2L});
    public static final BitSet FOLLOW_5 = new BitSet(new long[]{0x0000000000000800L});
    public static final BitSet FOLLOW_6 = new BitSet(new long[]{0x0000000000007000L});
    public static final BitSet FOLLOW_7 = new BitSet(new long[]{0x0000000000004002L});
    public static final BitSet FOLLOW_8 = new BitSet(new long[]{0x00000000000001F0L});
    public static final BitSet FOLLOW_9 = new BitSet(new long[]{0x0000000000004000L});
    public static final BitSet FOLLOW_10 = new BitSet(new long[]{0x0000000000018000L});
    public static final BitSet FOLLOW_11 = new BitSet(new long[]{0x0000000000018002L});

}