package xtext.workshop.advanced.formatting.parser.antlr.internal;

import org.eclipse.xtext.*;
import org.eclipse.xtext.parser.*;
import org.eclipse.xtext.parser.impl.*;
import org.eclipse.emf.ecore.util.EcoreUtil;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.parser.antlr.AbstractInternalAntlrParser;
import org.eclipse.xtext.parser.antlr.XtextTokenStream;
import org.eclipse.xtext.parser.antlr.XtextTokenStream.HiddenTokens;
import org.eclipse.xtext.parser.antlr.AntlrDatatypeRuleToken;
import xtext.workshop.advanced.formatting.services.TableGrammarAccess;



import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;

@SuppressWarnings("all")
public class InternalTableParser extends AbstractInternalAntlrParser {
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

        public InternalTableParser(TokenStream input, TableGrammarAccess grammarAccess) {
            this(input);
            this.grammarAccess = grammarAccess;
            registerRules(grammarAccess.getGrammar());
        }

        @Override
        protected String getFirstRuleName() {
        	return "Document";
       	}

       	@Override
       	protected TableGrammarAccess getGrammarAccess() {
       		return grammarAccess;
       	}




    // $ANTLR start "entryRuleDocument"
    // InternalTable.g:64:1: entryRuleDocument returns [EObject current=null] : iv_ruleDocument= ruleDocument EOF ;
    public final EObject entryRuleDocument() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleDocument = null;


        try {
            // InternalTable.g:64:49: (iv_ruleDocument= ruleDocument EOF )
            // InternalTable.g:65:2: iv_ruleDocument= ruleDocument EOF
            {
             newCompositeNode(grammarAccess.getDocumentRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleDocument=ruleDocument();

            state._fsp--;

             current =iv_ruleDocument; 
            match(input,EOF,FOLLOW_2); 

            }

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "entryRuleDocument"


    // $ANTLR start "ruleDocument"
    // InternalTable.g:71:1: ruleDocument returns [EObject current=null] : ( (lv_elements_0_0= ruleTable ) )* ;
    public final EObject ruleDocument() throws RecognitionException {
        EObject current = null;

        EObject lv_elements_0_0 = null;



        	enterRule();

        try {
            // InternalTable.g:77:2: ( ( (lv_elements_0_0= ruleTable ) )* )
            // InternalTable.g:78:2: ( (lv_elements_0_0= ruleTable ) )*
            {
            // InternalTable.g:78:2: ( (lv_elements_0_0= ruleTable ) )*
            loop1:
            do {
                int alt1=2;
                int LA1_0 = input.LA(1);

                if ( (LA1_0==11) ) {
                    alt1=1;
                }


                switch (alt1) {
            	case 1 :
            	    // InternalTable.g:79:3: (lv_elements_0_0= ruleTable )
            	    {
            	    // InternalTable.g:79:3: (lv_elements_0_0= ruleTable )
            	    // InternalTable.g:80:4: lv_elements_0_0= ruleTable
            	    {

            	    				newCompositeNode(grammarAccess.getDocumentAccess().getElementsTableParserRuleCall_0());
            	    			
            	    pushFollow(FOLLOW_3);
            	    lv_elements_0_0=ruleTable();

            	    state._fsp--;


            	    				if (current==null) {
            	    					current = createModelElementForParent(grammarAccess.getDocumentRule());
            	    				}
            	    				add(
            	    					current,
            	    					"elements",
            	    					lv_elements_0_0,
            	    					"xtext.workshop.advanced.formatting.Table.Table");
            	    				afterParserOrEnumRuleCall();
            	    			

            	    }


            	    }
            	    break;

            	default :
            	    break loop1;
                }
            } while (true);


            }


            	leaveRule();

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "ruleDocument"


    // $ANTLR start "entryRuleTable"
    // InternalTable.g:100:1: entryRuleTable returns [EObject current=null] : iv_ruleTable= ruleTable EOF ;
    public final EObject entryRuleTable() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleTable = null;


        try {
            // InternalTable.g:100:46: (iv_ruleTable= ruleTable EOF )
            // InternalTable.g:101:2: iv_ruleTable= ruleTable EOF
            {
             newCompositeNode(grammarAccess.getTableRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleTable=ruleTable();

            state._fsp--;

             current =iv_ruleTable; 
            match(input,EOF,FOLLOW_2); 

            }

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "entryRuleTable"


    // $ANTLR start "ruleTable"
    // InternalTable.g:107:1: ruleTable returns [EObject current=null] : ( () otherlv_1= '{|' ( (lv_caption_2_0= ruleCaption ) )? ( (lv_rows_3_0= ruleRow ) )* otherlv_4= '|}' ) ;
    public final EObject ruleTable() throws RecognitionException {
        EObject current = null;

        Token otherlv_1=null;
        Token otherlv_4=null;
        EObject lv_caption_2_0 = null;

        EObject lv_rows_3_0 = null;



        	enterRule();

        try {
            // InternalTable.g:113:2: ( ( () otherlv_1= '{|' ( (lv_caption_2_0= ruleCaption ) )? ( (lv_rows_3_0= ruleRow ) )* otherlv_4= '|}' ) )
            // InternalTable.g:114:2: ( () otherlv_1= '{|' ( (lv_caption_2_0= ruleCaption ) )? ( (lv_rows_3_0= ruleRow ) )* otherlv_4= '|}' )
            {
            // InternalTable.g:114:2: ( () otherlv_1= '{|' ( (lv_caption_2_0= ruleCaption ) )? ( (lv_rows_3_0= ruleRow ) )* otherlv_4= '|}' )
            // InternalTable.g:115:3: () otherlv_1= '{|' ( (lv_caption_2_0= ruleCaption ) )? ( (lv_rows_3_0= ruleRow ) )* otherlv_4= '|}'
            {
            // InternalTable.g:115:3: ()
            // InternalTable.g:116:4: 
            {

            				current = forceCreateModelElement(
            					grammarAccess.getTableAccess().getTableAction_0(),
            					current);
            			

            }

            otherlv_1=(Token)match(input,11,FOLLOW_4); 

            			newLeafNode(otherlv_1, grammarAccess.getTableAccess().getLeftCurlyBracketVerticalLineKeyword_1());
            		
            // InternalTable.g:126:3: ( (lv_caption_2_0= ruleCaption ) )?
            int alt2=2;
            int LA2_0 = input.LA(1);

            if ( (LA2_0==13) ) {
                alt2=1;
            }
            switch (alt2) {
                case 1 :
                    // InternalTable.g:127:4: (lv_caption_2_0= ruleCaption )
                    {
                    // InternalTable.g:127:4: (lv_caption_2_0= ruleCaption )
                    // InternalTable.g:128:5: lv_caption_2_0= ruleCaption
                    {

                    					newCompositeNode(grammarAccess.getTableAccess().getCaptionCaptionParserRuleCall_2_0());
                    				
                    pushFollow(FOLLOW_5);
                    lv_caption_2_0=ruleCaption();

                    state._fsp--;


                    					if (current==null) {
                    						current = createModelElementForParent(grammarAccess.getTableRule());
                    					}
                    					set(
                    						current,
                    						"caption",
                    						lv_caption_2_0,
                    						"xtext.workshop.advanced.formatting.Table.Caption");
                    					afterParserOrEnumRuleCall();
                    				

                    }


                    }
                    break;

            }

            // InternalTable.g:145:3: ( (lv_rows_3_0= ruleRow ) )*
            loop3:
            do {
                int alt3=2;
                int LA3_0 = input.LA(1);

                if ( (LA3_0==14) ) {
                    alt3=1;
                }


                switch (alt3) {
            	case 1 :
            	    // InternalTable.g:146:4: (lv_rows_3_0= ruleRow )
            	    {
            	    // InternalTable.g:146:4: (lv_rows_3_0= ruleRow )
            	    // InternalTable.g:147:5: lv_rows_3_0= ruleRow
            	    {

            	    					newCompositeNode(grammarAccess.getTableAccess().getRowsRowParserRuleCall_3_0());
            	    				
            	    pushFollow(FOLLOW_5);
            	    lv_rows_3_0=ruleRow();

            	    state._fsp--;


            	    					if (current==null) {
            	    						current = createModelElementForParent(grammarAccess.getTableRule());
            	    					}
            	    					add(
            	    						current,
            	    						"rows",
            	    						lv_rows_3_0,
            	    						"xtext.workshop.advanced.formatting.Table.Row");
            	    					afterParserOrEnumRuleCall();
            	    				

            	    }


            	    }
            	    break;

            	default :
            	    break loop3;
                }
            } while (true);

            otherlv_4=(Token)match(input,12,FOLLOW_2); 

            			newLeafNode(otherlv_4, grammarAccess.getTableAccess().getVerticalLineRightCurlyBracketKeyword_4());
            		

            }


            }


            	leaveRule();

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "ruleTable"


    // $ANTLR start "entryRuleCaption"
    // InternalTable.g:172:1: entryRuleCaption returns [EObject current=null] : iv_ruleCaption= ruleCaption EOF ;
    public final EObject entryRuleCaption() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleCaption = null;


        try {
            // InternalTable.g:172:48: (iv_ruleCaption= ruleCaption EOF )
            // InternalTable.g:173:2: iv_ruleCaption= ruleCaption EOF
            {
             newCompositeNode(grammarAccess.getCaptionRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleCaption=ruleCaption();

            state._fsp--;

             current =iv_ruleCaption; 
            match(input,EOF,FOLLOW_2); 

            }

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "entryRuleCaption"


    // $ANTLR start "ruleCaption"
    // InternalTable.g:179:1: ruleCaption returns [EObject current=null] : (otherlv_0= '|+' ( (lv_label_1_0= ruleLabel ) ) ) ;
    public final EObject ruleCaption() throws RecognitionException {
        EObject current = null;

        Token otherlv_0=null;
        AntlrDatatypeRuleToken lv_label_1_0 = null;



        	enterRule();

        try {
            // InternalTable.g:185:2: ( (otherlv_0= '|+' ( (lv_label_1_0= ruleLabel ) ) ) )
            // InternalTable.g:186:2: (otherlv_0= '|+' ( (lv_label_1_0= ruleLabel ) ) )
            {
            // InternalTable.g:186:2: (otherlv_0= '|+' ( (lv_label_1_0= ruleLabel ) ) )
            // InternalTable.g:187:3: otherlv_0= '|+' ( (lv_label_1_0= ruleLabel ) )
            {
            otherlv_0=(Token)match(input,13,FOLLOW_6); 

            			newLeafNode(otherlv_0, grammarAccess.getCaptionAccess().getVerticalLinePlusSignKeyword_0());
            		
            // InternalTable.g:191:3: ( (lv_label_1_0= ruleLabel ) )
            // InternalTable.g:192:4: (lv_label_1_0= ruleLabel )
            {
            // InternalTable.g:192:4: (lv_label_1_0= ruleLabel )
            // InternalTable.g:193:5: lv_label_1_0= ruleLabel
            {

            					newCompositeNode(grammarAccess.getCaptionAccess().getLabelLabelParserRuleCall_1_0());
            				
            pushFollow(FOLLOW_2);
            lv_label_1_0=ruleLabel();

            state._fsp--;


            					if (current==null) {
            						current = createModelElementForParent(grammarAccess.getCaptionRule());
            					}
            					set(
            						current,
            						"label",
            						lv_label_1_0,
            						"xtext.workshop.advanced.formatting.Table.Label");
            					afterParserOrEnumRuleCall();
            				

            }


            }


            }


            }


            	leaveRule();

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "ruleCaption"


    // $ANTLR start "entryRuleRow"
    // InternalTable.g:214:1: entryRuleRow returns [EObject current=null] : iv_ruleRow= ruleRow EOF ;
    public final EObject entryRuleRow() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleRow = null;


        try {
            // InternalTable.g:214:44: (iv_ruleRow= ruleRow EOF )
            // InternalTable.g:215:2: iv_ruleRow= ruleRow EOF
            {
             newCompositeNode(grammarAccess.getRowRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleRow=ruleRow();

            state._fsp--;

             current =iv_ruleRow; 
            match(input,EOF,FOLLOW_2); 

            }

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "entryRuleRow"


    // $ANTLR start "ruleRow"
    // InternalTable.g:221:1: ruleRow returns [EObject current=null] : ( () otherlv_1= '|-' ( (lv_cells_2_0= ruleCell ) )* ) ;
    public final EObject ruleRow() throws RecognitionException {
        EObject current = null;

        Token otherlv_1=null;
        EObject lv_cells_2_0 = null;



        	enterRule();

        try {
            // InternalTable.g:227:2: ( ( () otherlv_1= '|-' ( (lv_cells_2_0= ruleCell ) )* ) )
            // InternalTable.g:228:2: ( () otherlv_1= '|-' ( (lv_cells_2_0= ruleCell ) )* )
            {
            // InternalTable.g:228:2: ( () otherlv_1= '|-' ( (lv_cells_2_0= ruleCell ) )* )
            // InternalTable.g:229:3: () otherlv_1= '|-' ( (lv_cells_2_0= ruleCell ) )*
            {
            // InternalTable.g:229:3: ()
            // InternalTable.g:230:4: 
            {

            				current = forceCreateModelElement(
            					grammarAccess.getRowAccess().getRowAction_0(),
            					current);
            			

            }

            otherlv_1=(Token)match(input,14,FOLLOW_7); 

            			newLeafNode(otherlv_1, grammarAccess.getRowAccess().getVerticalLineHyphenMinusKeyword_1());
            		
            // InternalTable.g:240:3: ( (lv_cells_2_0= ruleCell ) )*
            loop4:
            do {
                int alt4=2;
                int LA4_0 = input.LA(1);

                if ( ((LA4_0>=15 && LA4_0<=16)) ) {
                    alt4=1;
                }


                switch (alt4) {
            	case 1 :
            	    // InternalTable.g:241:4: (lv_cells_2_0= ruleCell )
            	    {
            	    // InternalTable.g:241:4: (lv_cells_2_0= ruleCell )
            	    // InternalTable.g:242:5: lv_cells_2_0= ruleCell
            	    {

            	    					newCompositeNode(grammarAccess.getRowAccess().getCellsCellParserRuleCall_2_0());
            	    				
            	    pushFollow(FOLLOW_7);
            	    lv_cells_2_0=ruleCell();

            	    state._fsp--;


            	    					if (current==null) {
            	    						current = createModelElementForParent(grammarAccess.getRowRule());
            	    					}
            	    					add(
            	    						current,
            	    						"cells",
            	    						lv_cells_2_0,
            	    						"xtext.workshop.advanced.formatting.Table.Cell");
            	    					afterParserOrEnumRuleCall();
            	    				

            	    }


            	    }
            	    break;

            	default :
            	    break loop4;
                }
            } while (true);


            }


            }


            	leaveRule();

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "ruleRow"


    // $ANTLR start "entryRuleCell"
    // InternalTable.g:263:1: entryRuleCell returns [EObject current=null] : iv_ruleCell= ruleCell EOF ;
    public final EObject entryRuleCell() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleCell = null;


        try {
            // InternalTable.g:263:45: (iv_ruleCell= ruleCell EOF )
            // InternalTable.g:264:2: iv_ruleCell= ruleCell EOF
            {
             newCompositeNode(grammarAccess.getCellRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleCell=ruleCell();

            state._fsp--;

             current =iv_ruleCell; 
            match(input,EOF,FOLLOW_2); 

            }

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "entryRuleCell"


    // $ANTLR start "ruleCell"
    // InternalTable.g:270:1: ruleCell returns [EObject current=null] : (this_HeaderCell_0= ruleHeaderCell | this_DataCell_1= ruleDataCell ) ;
    public final EObject ruleCell() throws RecognitionException {
        EObject current = null;

        EObject this_HeaderCell_0 = null;

        EObject this_DataCell_1 = null;



        	enterRule();

        try {
            // InternalTable.g:276:2: ( (this_HeaderCell_0= ruleHeaderCell | this_DataCell_1= ruleDataCell ) )
            // InternalTable.g:277:2: (this_HeaderCell_0= ruleHeaderCell | this_DataCell_1= ruleDataCell )
            {
            // InternalTable.g:277:2: (this_HeaderCell_0= ruleHeaderCell | this_DataCell_1= ruleDataCell )
            int alt5=2;
            int LA5_0 = input.LA(1);

            if ( (LA5_0==15) ) {
                alt5=1;
            }
            else if ( (LA5_0==16) ) {
                alt5=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 5, 0, input);

                throw nvae;
            }
            switch (alt5) {
                case 1 :
                    // InternalTable.g:278:3: this_HeaderCell_0= ruleHeaderCell
                    {

                    			newCompositeNode(grammarAccess.getCellAccess().getHeaderCellParserRuleCall_0());
                    		
                    pushFollow(FOLLOW_2);
                    this_HeaderCell_0=ruleHeaderCell();

                    state._fsp--;


                    			current = this_HeaderCell_0;
                    			afterParserOrEnumRuleCall();
                    		

                    }
                    break;
                case 2 :
                    // InternalTable.g:287:3: this_DataCell_1= ruleDataCell
                    {

                    			newCompositeNode(grammarAccess.getCellAccess().getDataCellParserRuleCall_1());
                    		
                    pushFollow(FOLLOW_2);
                    this_DataCell_1=ruleDataCell();

                    state._fsp--;


                    			current = this_DataCell_1;
                    			afterParserOrEnumRuleCall();
                    		

                    }
                    break;

            }


            }


            	leaveRule();

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "ruleCell"


    // $ANTLR start "entryRuleHeaderCell"
    // InternalTable.g:299:1: entryRuleHeaderCell returns [EObject current=null] : iv_ruleHeaderCell= ruleHeaderCell EOF ;
    public final EObject entryRuleHeaderCell() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleHeaderCell = null;


        try {
            // InternalTable.g:299:51: (iv_ruleHeaderCell= ruleHeaderCell EOF )
            // InternalTable.g:300:2: iv_ruleHeaderCell= ruleHeaderCell EOF
            {
             newCompositeNode(grammarAccess.getHeaderCellRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleHeaderCell=ruleHeaderCell();

            state._fsp--;

             current =iv_ruleHeaderCell; 
            match(input,EOF,FOLLOW_2); 

            }

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "entryRuleHeaderCell"


    // $ANTLR start "ruleHeaderCell"
    // InternalTable.g:306:1: ruleHeaderCell returns [EObject current=null] : (otherlv_0= '!' ( (lv_text_1_0= ruleLabel ) ) ) ;
    public final EObject ruleHeaderCell() throws RecognitionException {
        EObject current = null;

        Token otherlv_0=null;
        AntlrDatatypeRuleToken lv_text_1_0 = null;



        	enterRule();

        try {
            // InternalTable.g:312:2: ( (otherlv_0= '!' ( (lv_text_1_0= ruleLabel ) ) ) )
            // InternalTable.g:313:2: (otherlv_0= '!' ( (lv_text_1_0= ruleLabel ) ) )
            {
            // InternalTable.g:313:2: (otherlv_0= '!' ( (lv_text_1_0= ruleLabel ) ) )
            // InternalTable.g:314:3: otherlv_0= '!' ( (lv_text_1_0= ruleLabel ) )
            {
            otherlv_0=(Token)match(input,15,FOLLOW_6); 

            			newLeafNode(otherlv_0, grammarAccess.getHeaderCellAccess().getExclamationMarkKeyword_0());
            		
            // InternalTable.g:318:3: ( (lv_text_1_0= ruleLabel ) )
            // InternalTable.g:319:4: (lv_text_1_0= ruleLabel )
            {
            // InternalTable.g:319:4: (lv_text_1_0= ruleLabel )
            // InternalTable.g:320:5: lv_text_1_0= ruleLabel
            {

            					newCompositeNode(grammarAccess.getHeaderCellAccess().getTextLabelParserRuleCall_1_0());
            				
            pushFollow(FOLLOW_2);
            lv_text_1_0=ruleLabel();

            state._fsp--;


            					if (current==null) {
            						current = createModelElementForParent(grammarAccess.getHeaderCellRule());
            					}
            					set(
            						current,
            						"text",
            						lv_text_1_0,
            						"xtext.workshop.advanced.formatting.Table.Label");
            					afterParserOrEnumRuleCall();
            				

            }


            }


            }


            }


            	leaveRule();

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "ruleHeaderCell"


    // $ANTLR start "entryRuleDataCell"
    // InternalTable.g:341:1: entryRuleDataCell returns [EObject current=null] : iv_ruleDataCell= ruleDataCell EOF ;
    public final EObject entryRuleDataCell() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleDataCell = null;


        try {
            // InternalTable.g:341:49: (iv_ruleDataCell= ruleDataCell EOF )
            // InternalTable.g:342:2: iv_ruleDataCell= ruleDataCell EOF
            {
             newCompositeNode(grammarAccess.getDataCellRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleDataCell=ruleDataCell();

            state._fsp--;

             current =iv_ruleDataCell; 
            match(input,EOF,FOLLOW_2); 

            }

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "entryRuleDataCell"


    // $ANTLR start "ruleDataCell"
    // InternalTable.g:348:1: ruleDataCell returns [EObject current=null] : (otherlv_0= '|' ( (lv_text_1_0= ruleLabel ) ) ) ;
    public final EObject ruleDataCell() throws RecognitionException {
        EObject current = null;

        Token otherlv_0=null;
        AntlrDatatypeRuleToken lv_text_1_0 = null;



        	enterRule();

        try {
            // InternalTable.g:354:2: ( (otherlv_0= '|' ( (lv_text_1_0= ruleLabel ) ) ) )
            // InternalTable.g:355:2: (otherlv_0= '|' ( (lv_text_1_0= ruleLabel ) ) )
            {
            // InternalTable.g:355:2: (otherlv_0= '|' ( (lv_text_1_0= ruleLabel ) ) )
            // InternalTable.g:356:3: otherlv_0= '|' ( (lv_text_1_0= ruleLabel ) )
            {
            otherlv_0=(Token)match(input,16,FOLLOW_6); 

            			newLeafNode(otherlv_0, grammarAccess.getDataCellAccess().getVerticalLineKeyword_0());
            		
            // InternalTable.g:360:3: ( (lv_text_1_0= ruleLabel ) )
            // InternalTable.g:361:4: (lv_text_1_0= ruleLabel )
            {
            // InternalTable.g:361:4: (lv_text_1_0= ruleLabel )
            // InternalTable.g:362:5: lv_text_1_0= ruleLabel
            {

            					newCompositeNode(grammarAccess.getDataCellAccess().getTextLabelParserRuleCall_1_0());
            				
            pushFollow(FOLLOW_2);
            lv_text_1_0=ruleLabel();

            state._fsp--;


            					if (current==null) {
            						current = createModelElementForParent(grammarAccess.getDataCellRule());
            					}
            					set(
            						current,
            						"text",
            						lv_text_1_0,
            						"xtext.workshop.advanced.formatting.Table.Label");
            					afterParserOrEnumRuleCall();
            				

            }


            }


            }


            }


            	leaveRule();

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "ruleDataCell"


    // $ANTLR start "entryRuleLabel"
    // InternalTable.g:383:1: entryRuleLabel returns [String current=null] : iv_ruleLabel= ruleLabel EOF ;
    public final String entryRuleLabel() throws RecognitionException {
        String current = null;

        AntlrDatatypeRuleToken iv_ruleLabel = null;


        try {
            // InternalTable.g:383:45: (iv_ruleLabel= ruleLabel EOF )
            // InternalTable.g:384:2: iv_ruleLabel= ruleLabel EOF
            {
             newCompositeNode(grammarAccess.getLabelRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleLabel=ruleLabel();

            state._fsp--;

             current =iv_ruleLabel.getText(); 
            match(input,EOF,FOLLOW_2); 

            }

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "entryRuleLabel"


    // $ANTLR start "ruleLabel"
    // InternalTable.g:390:1: ruleLabel returns [AntlrDatatypeRuleToken current=new AntlrDatatypeRuleToken()] : (this_ID_0= RULE_ID | this_STRING_1= RULE_STRING | this_INT_2= RULE_INT | this_WS_3= RULE_WS | this_ANY_OTHER_4= RULE_ANY_OTHER )* ;
    public final AntlrDatatypeRuleToken ruleLabel() throws RecognitionException {
        AntlrDatatypeRuleToken current = new AntlrDatatypeRuleToken();

        Token this_ID_0=null;
        Token this_STRING_1=null;
        Token this_INT_2=null;
        Token this_WS_3=null;
        Token this_ANY_OTHER_4=null;


        	enterRule();

        try {
            // InternalTable.g:396:2: ( (this_ID_0= RULE_ID | this_STRING_1= RULE_STRING | this_INT_2= RULE_INT | this_WS_3= RULE_WS | this_ANY_OTHER_4= RULE_ANY_OTHER )* )
            // InternalTable.g:397:2: (this_ID_0= RULE_ID | this_STRING_1= RULE_STRING | this_INT_2= RULE_INT | this_WS_3= RULE_WS | this_ANY_OTHER_4= RULE_ANY_OTHER )*
            {
            // InternalTable.g:397:2: (this_ID_0= RULE_ID | this_STRING_1= RULE_STRING | this_INT_2= RULE_INT | this_WS_3= RULE_WS | this_ANY_OTHER_4= RULE_ANY_OTHER )*
            loop6:
            do {
                int alt6=6;
                switch ( input.LA(1) ) {
                case RULE_ID:
                    {
                    alt6=1;
                    }
                    break;
                case RULE_STRING:
                    {
                    alt6=2;
                    }
                    break;
                case RULE_INT:
                    {
                    alt6=3;
                    }
                    break;
                case RULE_WS:
                    {
                    alt6=4;
                    }
                    break;
                case RULE_ANY_OTHER:
                    {
                    alt6=5;
                    }
                    break;

                }

                switch (alt6) {
            	case 1 :
            	    // InternalTable.g:398:3: this_ID_0= RULE_ID
            	    {
            	    this_ID_0=(Token)match(input,RULE_ID,FOLLOW_8); 

            	    			current.merge(this_ID_0);
            	    		

            	    			newLeafNode(this_ID_0, grammarAccess.getLabelAccess().getIDTerminalRuleCall_0());
            	    		

            	    }
            	    break;
            	case 2 :
            	    // InternalTable.g:406:3: this_STRING_1= RULE_STRING
            	    {
            	    this_STRING_1=(Token)match(input,RULE_STRING,FOLLOW_8); 

            	    			current.merge(this_STRING_1);
            	    		

            	    			newLeafNode(this_STRING_1, grammarAccess.getLabelAccess().getSTRINGTerminalRuleCall_1());
            	    		

            	    }
            	    break;
            	case 3 :
            	    // InternalTable.g:414:3: this_INT_2= RULE_INT
            	    {
            	    this_INT_2=(Token)match(input,RULE_INT,FOLLOW_8); 

            	    			current.merge(this_INT_2);
            	    		

            	    			newLeafNode(this_INT_2, grammarAccess.getLabelAccess().getINTTerminalRuleCall_2());
            	    		

            	    }
            	    break;
            	case 4 :
            	    // InternalTable.g:422:3: this_WS_3= RULE_WS
            	    {
            	    this_WS_3=(Token)match(input,RULE_WS,FOLLOW_8); 

            	    			current.merge(this_WS_3);
            	    		

            	    			newLeafNode(this_WS_3, grammarAccess.getLabelAccess().getWSTerminalRuleCall_3());
            	    		

            	    }
            	    break;
            	case 5 :
            	    // InternalTable.g:430:3: this_ANY_OTHER_4= RULE_ANY_OTHER
            	    {
            	    this_ANY_OTHER_4=(Token)match(input,RULE_ANY_OTHER,FOLLOW_8); 

            	    			current.merge(this_ANY_OTHER_4);
            	    		

            	    			newLeafNode(this_ANY_OTHER_4, grammarAccess.getLabelAccess().getANY_OTHERTerminalRuleCall_4());
            	    		

            	    }
            	    break;

            	default :
            	    break loop6;
                }
            } while (true);


            }


            	leaveRule();

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "ruleLabel"

    // Delegated rules


 

    public static final BitSet FOLLOW_1 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_2 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_3 = new BitSet(new long[]{0x0000000000000802L});
    public static final BitSet FOLLOW_4 = new BitSet(new long[]{0x0000000000007000L});
    public static final BitSet FOLLOW_5 = new BitSet(new long[]{0x0000000000005000L});
    public static final BitSet FOLLOW_6 = new BitSet(new long[]{0x00000000000001F0L});
    public static final BitSet FOLLOW_7 = new BitSet(new long[]{0x0000000000018002L});
    public static final BitSet FOLLOW_8 = new BitSet(new long[]{0x00000000000001F2L});

}