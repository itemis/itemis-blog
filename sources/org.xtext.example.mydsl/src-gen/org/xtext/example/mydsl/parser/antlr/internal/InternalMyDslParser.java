package org.xtext.example.mydsl.parser.antlr.internal;

import org.eclipse.xtext.*;
import org.eclipse.xtext.parser.*;
import org.eclipse.xtext.parser.impl.*;
import org.eclipse.emf.ecore.util.EcoreUtil;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.parser.antlr.AbstractInternalAntlrParser;
import org.eclipse.xtext.parser.antlr.XtextTokenStream;
import org.eclipse.xtext.parser.antlr.XtextTokenStream.HiddenTokens;
import org.eclipse.xtext.parser.antlr.AntlrDatatypeRuleToken;
import org.xtext.example.mydsl.services.MyDslGrammarAccess;



import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;

@SuppressWarnings("all")
public class InternalMyDslParser extends AbstractInternalAntlrParser {
    public static final String[] tokenNames = new String[] {
        "<invalid>", "<EOR>", "<DOWN>", "<UP>", "RULE_STRING", "RULE_ID", "RULE_INT", "RULE_ML_COMMENT", "RULE_SL_COMMENT", "RULE_WS", "RULE_ANY_OTHER", "'import'", "'def'", "'Hallo'", "'!'"
    };
    public static final int RULE_ID=5;
    public static final int RULE_WS=9;
    public static final int RULE_STRING=4;
    public static final int RULE_ANY_OTHER=10;
    public static final int RULE_SL_COMMENT=8;
    public static final int RULE_INT=6;
    public static final int T__11=11;
    public static final int RULE_ML_COMMENT=7;
    public static final int T__12=12;
    public static final int T__13=13;
    public static final int T__14=14;
    public static final int EOF=-1;

    // delegates
    // delegators


        public InternalMyDslParser(TokenStream input) {
            this(input, new RecognizerSharedState());
        }
        public InternalMyDslParser(TokenStream input, RecognizerSharedState state) {
            super(input, state);
             
        }
        

    public String[] getTokenNames() { return InternalMyDslParser.tokenNames; }
    public String getGrammarFileName() { return "InternalMyDsl.g"; }



     	private MyDslGrammarAccess grammarAccess;

        public InternalMyDslParser(TokenStream input, MyDslGrammarAccess grammarAccess) {
            this(input);
            this.grammarAccess = grammarAccess;
            registerRules(grammarAccess.getGrammar());
        }

        @Override
        protected String getFirstRuleName() {
        	return "Model";
       	}

       	@Override
       	protected MyDslGrammarAccess getGrammarAccess() {
       		return grammarAccess;
       	}




    // $ANTLR start "entryRuleModel"
    // InternalMyDsl.g:64:1: entryRuleModel returns [EObject current=null] : iv_ruleModel= ruleModel EOF ;
    public final EObject entryRuleModel() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleModel = null;


        try {
            // InternalMyDsl.g:64:46: (iv_ruleModel= ruleModel EOF )
            // InternalMyDsl.g:65:2: iv_ruleModel= ruleModel EOF
            {
             newCompositeNode(grammarAccess.getModelRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleModel=ruleModel();

            state._fsp--;

             current =iv_ruleModel; 
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
    // $ANTLR end "entryRuleModel"


    // $ANTLR start "ruleModel"
    // InternalMyDsl.g:71:1: ruleModel returns [EObject current=null] : ( ( (lv_includes_0_0= ruleInclude ) )* ( (lv_names_1_0= ruleName ) )* ( (lv_greetings_2_0= ruleGreeting ) )* ) ;
    public final EObject ruleModel() throws RecognitionException {
        EObject current = null;

        EObject lv_includes_0_0 = null;

        EObject lv_names_1_0 = null;

        EObject lv_greetings_2_0 = null;



        	enterRule();

        try {
            // InternalMyDsl.g:77:2: ( ( ( (lv_includes_0_0= ruleInclude ) )* ( (lv_names_1_0= ruleName ) )* ( (lv_greetings_2_0= ruleGreeting ) )* ) )
            // InternalMyDsl.g:78:2: ( ( (lv_includes_0_0= ruleInclude ) )* ( (lv_names_1_0= ruleName ) )* ( (lv_greetings_2_0= ruleGreeting ) )* )
            {
            // InternalMyDsl.g:78:2: ( ( (lv_includes_0_0= ruleInclude ) )* ( (lv_names_1_0= ruleName ) )* ( (lv_greetings_2_0= ruleGreeting ) )* )
            // InternalMyDsl.g:79:3: ( (lv_includes_0_0= ruleInclude ) )* ( (lv_names_1_0= ruleName ) )* ( (lv_greetings_2_0= ruleGreeting ) )*
            {
            // InternalMyDsl.g:79:3: ( (lv_includes_0_0= ruleInclude ) )*
            loop1:
            do {
                int alt1=2;
                int LA1_0 = input.LA(1);

                if ( (LA1_0==11) ) {
                    alt1=1;
                }


                switch (alt1) {
            	case 1 :
            	    // InternalMyDsl.g:80:4: (lv_includes_0_0= ruleInclude )
            	    {
            	    // InternalMyDsl.g:80:4: (lv_includes_0_0= ruleInclude )
            	    // InternalMyDsl.g:81:5: lv_includes_0_0= ruleInclude
            	    {

            	    					newCompositeNode(grammarAccess.getModelAccess().getIncludesIncludeParserRuleCall_0_0());
            	    				
            	    pushFollow(FOLLOW_3);
            	    lv_includes_0_0=ruleInclude();

            	    state._fsp--;


            	    					if (current==null) {
            	    						current = createModelElementForParent(grammarAccess.getModelRule());
            	    					}
            	    					add(
            	    						current,
            	    						"includes",
            	    						lv_includes_0_0,
            	    						"org.xtext.example.mydsl.MyDsl.Include");
            	    					afterParserOrEnumRuleCall();
            	    				

            	    }


            	    }
            	    break;

            	default :
            	    break loop1;
                }
            } while (true);

            // InternalMyDsl.g:98:3: ( (lv_names_1_0= ruleName ) )*
            loop2:
            do {
                int alt2=2;
                int LA2_0 = input.LA(1);

                if ( (LA2_0==12) ) {
                    alt2=1;
                }


                switch (alt2) {
            	case 1 :
            	    // InternalMyDsl.g:99:4: (lv_names_1_0= ruleName )
            	    {
            	    // InternalMyDsl.g:99:4: (lv_names_1_0= ruleName )
            	    // InternalMyDsl.g:100:5: lv_names_1_0= ruleName
            	    {

            	    					newCompositeNode(grammarAccess.getModelAccess().getNamesNameParserRuleCall_1_0());
            	    				
            	    pushFollow(FOLLOW_4);
            	    lv_names_1_0=ruleName();

            	    state._fsp--;


            	    					if (current==null) {
            	    						current = createModelElementForParent(grammarAccess.getModelRule());
            	    					}
            	    					add(
            	    						current,
            	    						"names",
            	    						lv_names_1_0,
            	    						"org.xtext.example.mydsl.MyDsl.Name");
            	    					afterParserOrEnumRuleCall();
            	    				

            	    }


            	    }
            	    break;

            	default :
            	    break loop2;
                }
            } while (true);

            // InternalMyDsl.g:117:3: ( (lv_greetings_2_0= ruleGreeting ) )*
            loop3:
            do {
                int alt3=2;
                int LA3_0 = input.LA(1);

                if ( (LA3_0==13) ) {
                    alt3=1;
                }


                switch (alt3) {
            	case 1 :
            	    // InternalMyDsl.g:118:4: (lv_greetings_2_0= ruleGreeting )
            	    {
            	    // InternalMyDsl.g:118:4: (lv_greetings_2_0= ruleGreeting )
            	    // InternalMyDsl.g:119:5: lv_greetings_2_0= ruleGreeting
            	    {

            	    					newCompositeNode(grammarAccess.getModelAccess().getGreetingsGreetingParserRuleCall_2_0());
            	    				
            	    pushFollow(FOLLOW_5);
            	    lv_greetings_2_0=ruleGreeting();

            	    state._fsp--;


            	    					if (current==null) {
            	    						current = createModelElementForParent(grammarAccess.getModelRule());
            	    					}
            	    					add(
            	    						current,
            	    						"greetings",
            	    						lv_greetings_2_0,
            	    						"org.xtext.example.mydsl.MyDsl.Greeting");
            	    					afterParserOrEnumRuleCall();
            	    				

            	    }


            	    }
            	    break;

            	default :
            	    break loop3;
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
    // $ANTLR end "ruleModel"


    // $ANTLR start "entryRuleInclude"
    // InternalMyDsl.g:140:1: entryRuleInclude returns [EObject current=null] : iv_ruleInclude= ruleInclude EOF ;
    public final EObject entryRuleInclude() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleInclude = null;


        try {
            // InternalMyDsl.g:140:48: (iv_ruleInclude= ruleInclude EOF )
            // InternalMyDsl.g:141:2: iv_ruleInclude= ruleInclude EOF
            {
             newCompositeNode(grammarAccess.getIncludeRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleInclude=ruleInclude();

            state._fsp--;

             current =iv_ruleInclude; 
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
    // $ANTLR end "entryRuleInclude"


    // $ANTLR start "ruleInclude"
    // InternalMyDsl.g:147:1: ruleInclude returns [EObject current=null] : (otherlv_0= 'import' ( (lv_importURI_1_0= RULE_STRING ) ) ) ;
    public final EObject ruleInclude() throws RecognitionException {
        EObject current = null;

        Token otherlv_0=null;
        Token lv_importURI_1_0=null;


        	enterRule();

        try {
            // InternalMyDsl.g:153:2: ( (otherlv_0= 'import' ( (lv_importURI_1_0= RULE_STRING ) ) ) )
            // InternalMyDsl.g:154:2: (otherlv_0= 'import' ( (lv_importURI_1_0= RULE_STRING ) ) )
            {
            // InternalMyDsl.g:154:2: (otherlv_0= 'import' ( (lv_importURI_1_0= RULE_STRING ) ) )
            // InternalMyDsl.g:155:3: otherlv_0= 'import' ( (lv_importURI_1_0= RULE_STRING ) )
            {
            otherlv_0=(Token)match(input,11,FOLLOW_6); 

            			newLeafNode(otherlv_0, grammarAccess.getIncludeAccess().getImportKeyword_0());
            		
            // InternalMyDsl.g:159:3: ( (lv_importURI_1_0= RULE_STRING ) )
            // InternalMyDsl.g:160:4: (lv_importURI_1_0= RULE_STRING )
            {
            // InternalMyDsl.g:160:4: (lv_importURI_1_0= RULE_STRING )
            // InternalMyDsl.g:161:5: lv_importURI_1_0= RULE_STRING
            {
            lv_importURI_1_0=(Token)match(input,RULE_STRING,FOLLOW_2); 

            					newLeafNode(lv_importURI_1_0, grammarAccess.getIncludeAccess().getImportURISTRINGTerminalRuleCall_1_0());
            				

            					if (current==null) {
            						current = createModelElement(grammarAccess.getIncludeRule());
            					}
            					setWithLastConsumed(
            						current,
            						"importURI",
            						lv_importURI_1_0,
            						"org.eclipse.xtext.common.Terminals.STRING");
            				

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
    // $ANTLR end "ruleInclude"


    // $ANTLR start "entryRuleName"
    // InternalMyDsl.g:181:1: entryRuleName returns [EObject current=null] : iv_ruleName= ruleName EOF ;
    public final EObject entryRuleName() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleName = null;


        try {
            // InternalMyDsl.g:181:45: (iv_ruleName= ruleName EOF )
            // InternalMyDsl.g:182:2: iv_ruleName= ruleName EOF
            {
             newCompositeNode(grammarAccess.getNameRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleName=ruleName();

            state._fsp--;

             current =iv_ruleName; 
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
    // $ANTLR end "entryRuleName"


    // $ANTLR start "ruleName"
    // InternalMyDsl.g:188:1: ruleName returns [EObject current=null] : (otherlv_0= 'def' ( (lv_name_1_0= RULE_ID ) ) ) ;
    public final EObject ruleName() throws RecognitionException {
        EObject current = null;

        Token otherlv_0=null;
        Token lv_name_1_0=null;


        	enterRule();

        try {
            // InternalMyDsl.g:194:2: ( (otherlv_0= 'def' ( (lv_name_1_0= RULE_ID ) ) ) )
            // InternalMyDsl.g:195:2: (otherlv_0= 'def' ( (lv_name_1_0= RULE_ID ) ) )
            {
            // InternalMyDsl.g:195:2: (otherlv_0= 'def' ( (lv_name_1_0= RULE_ID ) ) )
            // InternalMyDsl.g:196:3: otherlv_0= 'def' ( (lv_name_1_0= RULE_ID ) )
            {
            otherlv_0=(Token)match(input,12,FOLLOW_7); 

            			newLeafNode(otherlv_0, grammarAccess.getNameAccess().getDefKeyword_0());
            		
            // InternalMyDsl.g:200:3: ( (lv_name_1_0= RULE_ID ) )
            // InternalMyDsl.g:201:4: (lv_name_1_0= RULE_ID )
            {
            // InternalMyDsl.g:201:4: (lv_name_1_0= RULE_ID )
            // InternalMyDsl.g:202:5: lv_name_1_0= RULE_ID
            {
            lv_name_1_0=(Token)match(input,RULE_ID,FOLLOW_2); 

            					newLeafNode(lv_name_1_0, grammarAccess.getNameAccess().getNameIDTerminalRuleCall_1_0());
            				

            					if (current==null) {
            						current = createModelElement(grammarAccess.getNameRule());
            					}
            					setWithLastConsumed(
            						current,
            						"name",
            						lv_name_1_0,
            						"org.eclipse.xtext.common.Terminals.ID");
            				

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
    // $ANTLR end "ruleName"


    // $ANTLR start "entryRuleGreeting"
    // InternalMyDsl.g:222:1: entryRuleGreeting returns [EObject current=null] : iv_ruleGreeting= ruleGreeting EOF ;
    public final EObject entryRuleGreeting() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleGreeting = null;


        try {
            // InternalMyDsl.g:222:49: (iv_ruleGreeting= ruleGreeting EOF )
            // InternalMyDsl.g:223:2: iv_ruleGreeting= ruleGreeting EOF
            {
             newCompositeNode(grammarAccess.getGreetingRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleGreeting=ruleGreeting();

            state._fsp--;

             current =iv_ruleGreeting; 
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
    // $ANTLR end "entryRuleGreeting"


    // $ANTLR start "ruleGreeting"
    // InternalMyDsl.g:229:1: ruleGreeting returns [EObject current=null] : (otherlv_0= 'Hallo' ( (otherlv_1= RULE_ID ) ) otherlv_2= '!' ) ;
    public final EObject ruleGreeting() throws RecognitionException {
        EObject current = null;

        Token otherlv_0=null;
        Token otherlv_1=null;
        Token otherlv_2=null;


        	enterRule();

        try {
            // InternalMyDsl.g:235:2: ( (otherlv_0= 'Hallo' ( (otherlv_1= RULE_ID ) ) otherlv_2= '!' ) )
            // InternalMyDsl.g:236:2: (otherlv_0= 'Hallo' ( (otherlv_1= RULE_ID ) ) otherlv_2= '!' )
            {
            // InternalMyDsl.g:236:2: (otherlv_0= 'Hallo' ( (otherlv_1= RULE_ID ) ) otherlv_2= '!' )
            // InternalMyDsl.g:237:3: otherlv_0= 'Hallo' ( (otherlv_1= RULE_ID ) ) otherlv_2= '!'
            {
            otherlv_0=(Token)match(input,13,FOLLOW_7); 

            			newLeafNode(otherlv_0, grammarAccess.getGreetingAccess().getHalloKeyword_0());
            		
            // InternalMyDsl.g:241:3: ( (otherlv_1= RULE_ID ) )
            // InternalMyDsl.g:242:4: (otherlv_1= RULE_ID )
            {
            // InternalMyDsl.g:242:4: (otherlv_1= RULE_ID )
            // InternalMyDsl.g:243:5: otherlv_1= RULE_ID
            {

            					if (current==null) {
            						current = createModelElement(grammarAccess.getGreetingRule());
            					}
            				
            otherlv_1=(Token)match(input,RULE_ID,FOLLOW_8); 

            					newLeafNode(otherlv_1, grammarAccess.getGreetingAccess().getNameNameCrossReference_1_0());
            				

            }


            }

            otherlv_2=(Token)match(input,14,FOLLOW_2); 

            			newLeafNode(otherlv_2, grammarAccess.getGreetingAccess().getExclamationMarkKeyword_2());
            		

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
    // $ANTLR end "ruleGreeting"

    // Delegated rules


 

    public static final BitSet FOLLOW_1 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_2 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_3 = new BitSet(new long[]{0x0000000000003802L});
    public static final BitSet FOLLOW_4 = new BitSet(new long[]{0x0000000000003002L});
    public static final BitSet FOLLOW_5 = new BitSet(new long[]{0x0000000000002002L});
    public static final BitSet FOLLOW_6 = new BitSet(new long[]{0x0000000000000010L});
    public static final BitSet FOLLOW_7 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_8 = new BitSet(new long[]{0x0000000000004000L});

}