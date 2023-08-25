grammar Hello;     // The name of the grammar is Hello
r  : 'hello' ID ;         // The rule/production r match keyword `hello` followed by the rule `ID`
ID : [a-z]+ ;             // The rule/production `ID` match all lower-case characters
WS : [ \t\r\n]+ -> skip ; // This WS rule (WhiteSpace) skip spaces, tabs, newlines

cd /temp/hellog4
antlr4 Hello.g4 # Run the tool
grun Hello r -tree


public class Hello {

    public static void main(String[] args) {

        // The input
        String input = "hello nico";
        ANTLRInputStream inputStream = new ANTLRInputStream(input);

        // Lexer
        HelloLexer lexer = new HelloLexer(inputStream);

        // Stream of token
        CommonTokenStream commonTokenStream = new CommonTokenStream(lexer);

        // Create the parser
        HelloParser parser = new HelloParser(commonTokenStream);

        // Create the tree from the r parser rule
        ParseTree tree = parser.r();

        // Print the tree
        printNode(tree, 0, Arrays.asList(parser.getRuleNames()));

        // Or with the utility function to print the LISP-style tree
        // equivalent to `grun Hello r --tree`
        System.out.println(tree.toStringTree(parser));

    }

    /**
     * Recursive function to print a node
     * @param node
     * @param level
     * @param ruleNames
     */
    private static void printNode(ParseTree node, int level, List<String> ruleNames) {
        String nodeText = Trees.getNodeText(node, ruleNames);

        // Print
        StringBuilder line = new StringBuilder();
        IntStream.range(0, level).forEach(i -> line.append(" "));
        line
                .append("Level ")
                .append(level)
                .append(" - ")
                .append(nodeText);
        System.out.println(line.toString());


        // Chilrdnre
        if (node instanceof ParserRuleContext) {
            ParserRuleContext parserRuleContext = (ParserRuleContext) node;
            if (parserRuleContext.children != null) {
                for (ParseTree child : parserRuleContext.children) {
                    printNode(child, level + 1, ruleNames);
                }
            }
        }
    }
}
