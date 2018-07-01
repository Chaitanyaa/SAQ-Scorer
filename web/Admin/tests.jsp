

<%@page import="edu.stanford.nlp.tagger.maxent.MaxentTagger"%>
<%@page import="rita.RiWordNet"%>
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rita.RiTa"%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Connection con=null;
    Statement stmt=null;
    Statement stmt1=null;
    Statement stmt2=null;
    int i=0;
    try{
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/project?user=root");
        }
        catch (Exception e) {
        e.printStackTrace();
        }
        stmt=con.createStatement();
        stmt1=con.createStatement();
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

<!SCORE>

<%!
public float mark(String f[],String s[])
        {
            RiWordNet wordnet = new RiWordNet("C:\\Users\\SAI CHAITANYA\\Downloads\\wn3.1.dict\\dict");
            float dist=0,min=2f,dt=0;
            String a[],b[];
            for(String x:s)
                {
                    a=x.split(":");
                    for(String y:f)
                    {
                        b=y.split(":");
                        if(a[1].equals(b[1]))
                        {
                            dt=wordnet.getDistance(a[0].trim(),b[0].trim() ,a[1]);
                            if(Float.compare(dt,min)<0){min=(float)dt;}
                            System.out.println("a:"+a[0]+" , b:"+b[0]+" Distance:"+wordnet.getDistance(a[0].trim(),b[0].trim() ,a[1]));
                        }
                    }dist=dist+min;min=2;System.out.println("*******");
                    
                }
            return dist; 
        }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.6/flatly/bootstrap.min.css" rel="stylesheet" integrity="sha384-XYCjB+hFAjSbgf9yKUgbysEjaVLOXhCgATTEBpCqT1R3jvG5LGRAK5ZIyRbH5vpX" crossorigin="anonymous">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </head>
    <script>
        function view(){
            document.getElementById("view").action = "viewtest.jsp";
        }
        function eval()
        {
            <%
            if(request.getParameter("hide")!=null)
            {
                String student,faculty,s[],f[];
                float error,score;
                stmt1=con.createStatement();
                String sql1="select project.test.answer as sanswer,project.qas.answer as fanswer from test,qas where test.question=qas.question and test.testname='"+request.getParameter("select")+"'";
                ResultSet res=stmt1.executeQuery(sql1);
                while(res.next()){
                    //System.out.println("Hello");
                    student=res.getString("sanswer");
                    s=preproc(student);
                    faculty=res.getString("fanswer");
                    faculty=faculty.replaceAll("\\[", "").replaceAll("\\]","");
                    f=faculty.split(",");
                    System.out.println(Arrays.toString(f));
                    System.out.println(Arrays.toString(s));
                    error=mark(f, s);
                    System.out.println("error:"+error);
                    if(s.length<3){error=5;}
                    score=5-error;
                    if(score<0){ score=0.2f;}
                    System.out.println(5-error);
                    stmt2=con.createStatement();
                    String sqla="update project.test set score='"+score+"' where answer='"+student+"';";
                    stmt2.executeUpdate(sqla);
                }   
            }
            %>
        }
    </script>
    <body>
        <div class="container">
            <form name="ev" target="f2" id="view">
            <table width="100%" cellspacing="10">
                <tbody>
                    <tr>
                        <td>
                            <h1>Test Overview !</h1><br>
                            <h3>Select Test</h3>
                            
                            <div class="col-lg-10">
                            
                            <select class="form-control" id="select" name="select">
                                <%
                                    String sql="select distinct(testname) from project.test";
                                    ResultSet rs=stmt.executeQuery(sql);
                                    while(rs.next()){
                                %>
                              <option><%=rs.getString("testname")%></option>
                              <%}rs.close();
                              %>
                            </select>
                            
                            </div>
                        </td>
                        <td>
                            <h3>Create new Test:</h3>
                            <a href="addtest.jsp" class="btn btn-primary btn-sm" target="f2">Add Test</a>
                        </td>
                    </tr>
                    <tr>
                        
                        <td>
                            <br>
                           <input type="hidden" name="hide">
                           <button type="submit" onclick="eval();" class="btn btn-primary btn-sm">Evaluate test</button>
                           <button type="submit" onclick="view();" class="btn btn-primary btn-sm">View test</button>
                        </td>
                        
                        <td>
                            <h3>Create new Question:</h3>
                            <a href="addquestion.jsp" class="btn btn-primary btn-sm" target="f2">Add Question</a>
                        </td>
                    </tr>
                </tbody>
            </table>
            </form>
        </div>
    </body>
</html>
