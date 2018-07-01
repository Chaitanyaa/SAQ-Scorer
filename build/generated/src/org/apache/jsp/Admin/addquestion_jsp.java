package org.apache.jsp.Admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import edu.stanford.nlp.tagger.maxent.MaxentTagger;
import java.util.TreeSet;
import java.util.Arrays;
import java.util.ArrayList;
import java.sql.*;
import rita.*;
import rita.wordnet.*;

public final class addquestion_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


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

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");

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
    

      out.write("\n");
      out.write("\n");
      out.write("<!--Preprocess-->\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>JSP Page</title>\n");
      out.write("        <link href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${pageContext.request.contextPath}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write("/css/style.css\" rel=\"stylesheet\" type=\"text/css\">\n");
      out.write("        <link href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${pageContext.request.contextPath}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write("/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("        <script src=\"https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js\"></script>\n");
      out.write("        <link href=\"https://maxcdn.bootstrapcdn.com/bootswatch/3.3.6/flatly/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("        <link href=\"https://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css\" rel=\"stylesheet\">\n");
      out.write("        <script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js\"></script>\n");
      out.write("    </head>\n");
      out.write("    \n");
      out.write("    <body>\n");
      out.write("        \n");
      out.write("        <script>\n");
      out.write("            function addq()\n");
      out.write("            {\n");
      out.write("                ");

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
                
      out.write("\n");
      out.write("            }\n");
      out.write("        </script>\n");
      out.write("        \n");
      out.write("        \n");
      out.write("        <div id=\"container0\">\n");
      out.write("            <h3>Enter new question</h3>\n");
      out.write("            <br>\n");
      out.write("            <form class=\"form-horizontal\" name=\"qform\" target=\"f2\">\n");
      out.write("            <div class=\"form-group\">\n");
      out.write("            <label for=\"textArea\" class=\"col-lg-2 control-label\">Question</label>\n");
      out.write("            <div class=\"col-lg-10\">\n");
      out.write("            <textarea class=\"form-control\" rows=\"3\" name=\"question\"></textarea>\n");
      out.write("            <br><br>\n");
      out.write("            </div>\n");
      out.write("            \n");
      out.write("            <div class=\"form-group\">\n");
      out.write("            <label for=\"textArea\" class=\"col-lg-2 control-label\">Answer</label>\n");
      out.write("            <div class=\"col-lg-10\">\n");
      out.write("            <textarea class=\"form-control\" rows=\"3\" name=\"answer\"></textarea>\n");
      out.write("            <span class=\"help-block\">Shorter the better !</span>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"form-group\" align=\"center\">\n");
      out.write("              <div class=\"col-lg-10 col-lg-offset-2\">\n");
      out.write("                  <a href=\"tests.jsp\" class=\"btn btn-primary\" target=\"f2\">Back</a>\n");
      out.write("                <button type=\"reset\" class=\"btn btn-default\">Cancel</button>\n");
      out.write("                <button type=\"submit\" onclick=\"addq();\" class=\"btn btn-primary\">Submit</button>\n");
      out.write("              </div>\n");
      out.write("            </div>\n");
      out.write("            </div>\n");
      out.write("            </div>\n");
      out.write("           </form>\n");
      out.write("        </div>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
