<%--
    Document   : addquestion
    Created on : Apr 9, 2016, 5:21:14 PM
    Author     : SAI CHAITANYA
--%>

<%@page import="edu.stanford.nlp.tagger.maxent.MaxentTagger"%>
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="rita.*"%>
<%@page import="rita.wordnet.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Connection con=null;
    Statement stmt=null;
    
    int i=2;
    try{
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/project?user=root");
        }
        catch (Exception e) {
        e.printStackTrace();
        }
    
%>

<!--Preprocess-->

<%!
    String[] stopwords = {"the", "a", "about", "above", "above", "across", "after", "afterwards", "again", "against", "all", "almost", "alone", "along", "already", "also","although","always","am","among", "amongst", "amoungst", "amount",  "an", "and", "another", "any","anyhow","anyone","anything","anyway", "anywhere", "are", "around", "as",  "at", "back","be","became", "because","become","becomes", "becoming", "been", "before", "beforehand", "behind", "being", "below", "beside", "besides", "between", "beyond", "bill", "both", "bottom","but", "by", "call", "can", "cannot", "cant", "co", "con", "could", "couldnt", "cry", "de", "describe", "detail", "do", "done", "down", "due", "during", "each", "eg", "eight", "either", "eleven","else", "elsewhere", "empty", "enough", "etc", "even", "ever", "every", "everyone", "everything", "everywhere", "except", "few", "fifteen", "fify", "fill", "find", "fire", "first", "five", "for", "former", "formerly", "forty", "found", "four", "from", "front", "full", "further", "get", "give", "go", "had", "has", "hasnt", "have", "he", "hence", "her", "here", "hereafter", "hereby", "herein", "hereupon", "hers", "herself", "him", "himself", "his", "how", "however", "hundred", "ie", "if", "in", "inc", "indeed", "interest", "into", "is", "it", "its", "itself", "keep", "last", "latter", "latterly", "least", "less", "ltd", "made", "many", "may", "me", "meanwhile", "might", "mill", "mine", "more", "moreover", "most", "mostly", "move", "much", "must", "my", "myself", "name", "namely", "neither", "never", "nevertheless", "next", "nine", "no", "nobody", "none", "noone", "nor", "not", "nothing", "now", "nowhere", "of", "off", "often", "on", "once", "one", "only", "onto", "or", "other", "others", "otherwise", "our", "ours", "ourselves", "out", "over", "own","part", "per", "perhaps", "please", "put", "rather", "re", "same", "see", "seem", "seemed", "seeming", "seems", "serious", "several", "she", "should", "show", "side", "since", "sincere", "six", "sixty", "so", "some", "somehow", "someone", "something", "sometime", "sometimes", "somewhere", "still", "such", "system", "take", "ten", "than", "that", "the", "their", "them", "themselves", "then", "thence", "there", "thereafter", "thereby", "therefore", "therein", "thereupon", "these", "they", "thickv", "thin", "third", "this", "those", "though", "three", "through", "throughout", "thru", "thus", "to", "together", "too", "top", "toward", "towards", "twelve", "twenty", "two", "un", "under", "until", "up", "upon", "us", "very", "via", "was", "we", "well", "were", "what", "whatever", "when", "whence", "whenever", "where", "whereafter", "whereas", "whereby", "wherein", "whereupon", "wherever", "whether", "which", "while", "whither", "who", "whoever", "whole", "whom", "whose", "why", "will", "with", "within", "without", "would", "yet", "you", "your", "yours", "yourself", "yourselves", "the"};
    String[] penn = {"cc","cd","dt","ex","fw","in","jj","jjr","jjs","ls","md","nn","nns","nnps","nnp","pdt","pos","prp","prp$","rb","rbr","rbs","rp","sym","to","uh","vb","vbd","vbg","vbn","vbp","vbz","wdt","wp","wp$","wrb"};
    Boolean reverse=false;
public final String[] preproc(String str)
    {
        int k=0;
        str=str.toLowerCase();
        str=RiTa.stripPunctuation(str); //REMOVE ANY PUCTUATION
        if(str.contains("was")||str.contains("by")){reverse=true;}
        //str=RiTa.getPosTagsInline(str); //TEXT TAGGING
        
        MaxentTagger tagger =  new MaxentTagger("C:/Users/SAI CHAITANYA/Downloads/stanford-postagger-2015-01-30/models/english-left3words-distsim.tagger");
        str=tagger.tagString(str);
        str=str.toLowerCase();
        String regex,cfsr[];
        ArrayList <String>a=new ArrayList();
        ArrayList <String>b=new ArrayList();
        ArrayList <String>c=new ArrayList();
        
        //REMOVE STOPWORDS
        for(String wrd: stopwords)
        {
            for(String pen:penn)
            {
            regex = "\\s*\\b"+wrd+"_"+pen+"\\b\\s*";
            str=str.replaceAll(regex, "  ");
            str=str.replace("$","");
            }
        }
        
        //STEMMING
        cfsr=RiTa.tokenize(str);
        String temp[];
        for(String i:cfsr)
        {
            temp=i.split("_");
            if(temp[1].startsWith("j"))
            {
                temp[1]="a";
            }
            else if(temp[1].startsWith("n"))
            {
                temp[1]="n";
            }
            else if(temp[1].startsWith("v"))
            {
                temp[1]="v";
            }
            if(temp[0].endsWith("y")||temp[0].endsWith("e")||temp[0].endsWith("ion")||temp[0].endsWith("es")){
                i=temp[0];
            }
            else{
                i=RiTa.stem(temp[0]);
            }
            i=i+":"+temp[1];
            cfsr[k++]=i;
        }
        
        // SWAPPING SUBJECT AND OBJECT
        if(reverse)
        {
            int i=-1;
            for(String w:cfsr)
            {
                i++;
                if(w.contains("v")){break;}
            }
            for(int j=0;j<i;j++)
            {
                a.add(cfsr[j]);
            }
            for(int j=i+1;j<cfsr.length;j++)
            {
                b.add(cfsr[j]);
            }
            for (String b1 : b) {
                c.add(b1);
            }
            c.add(cfsr[i]);
            for (String a1 : a) {
                c.add(a1);
            }
            cfsr=c.toArray(new String[0]);
        }
        //REMOVE DUPLICATES
        cfsr=new TreeSet<String>(Arrays.asList(cfsr)).toArray(new String[0]);
        return cfsr;
        }
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.6/flatly/bootstrap.min.css" rel="stylesheet">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </head>
    
    <body>
        
        <script>
            function addq()
            {
                <%
                    if(request.getParameter("question")!=null&&request.getParameter("answer")!=null)
                    {
                        String Question=request.getParameter("question");
                        String Answer=request.getParameter("answer");
                        String f[];
                        f=preproc(Answer);
                        Answer=Arrays.toString(f);
                        try{
                            
                            stmt=con.createStatement();
                            ResultSet rs=stmt.executeQuery("select count(id) as count from project.qas");
                            rs.next();
                            String sql="insert into project.qas values('"+Question+"','"+Answer+"',"+ rs.getString("count")+1 +")";
                            stmt.executeUpdate(sql);
                            }
                            catch (Exception e) {
                            e.printStackTrace();
                            }
                    }
                %>
            }
        </script>
        
        
        <div id="container0">
            <h3>Enter new question</h3>
            <br>
            <form class="form-horizontal" name="qform" target="f2">
            <div class="form-group">
            <label for="textArea" class="col-lg-2 control-label">Question</label>
            <div class="col-lg-10">
            <textarea class="form-control" rows="3" name="question"></textarea>
            <br><br>
            </div>
            
            <div class="form-group">
            <label for="textArea" class="col-lg-2 control-label">Answer</label>
            <div class="col-lg-10">
            <textarea class="form-control" rows="3" name="answer"></textarea>
            <span class="help-block">Shorter the better !</span>
            </div>
            <div class="form-group" align="center">
              <div class="col-lg-10 col-lg-offset-2">
                  <a href="tests.jsp" class="btn btn-primary" target="f2">Back</a>
                <button type="reset" class="btn btn-default">Cancel</button>
                <button type="submit" onclick="addq();" class="btn btn-primary">Submit</button>
              </div>
            </div>
            </div>
            </div>
           </form>
        </div>
    </body>
</html>
