package helper;


import edu.stanford.nlp.tagger.maxent.MaxentTagger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.TreeSet;
import rita.RiTa;
import rita.RiWordNet;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author SAI CHAITANYA
 */
public class scoring {
    String[] stopwords;
    String[] penn;
    Boolean reverse;
   public scoring()
    {
        
        String[] stopwords = {"the", "a", "about", "above", "above", "across", "after", "afterwards", "again", "against", "all", "almost", "alone", "along", "already", "also","although","always","am","among", "amongst", "amoungst", "amount",  "an", "and", "another", "any","anyhow","anyone","anything","anyway", "anywhere", "are", "around", "as",  "at", "back","be","became", "because","become","becomes", "becoming", "been", "before", "beforehand", "behind", "being", "below", "beside", "besides", "between", "beyond", "bill", "both", "bottom","but", "by", "call", "can", "cannot", "cant", "co", "con", "could", "couldnt", "cry", "de", "describe", "detail", "do", "done", "down", "due", "during", "each", "eg", "eight", "either", "eleven","else", "elsewhere", "empty", "enough", "etc", "even", "ever", "every", "everyone", "everything", "everywhere", "except", "few", "fifteen", "fify", "fill", "find", "fire", "first", "five", "for", "former", "formerly", "forty", "found", "four", "from", "front", "full", "further", "get", "give", "go", "had", "has", "hasnt", "have", "he", "hence", "her", "here", "hereafter", "hereby", "herein", "hereupon", "hers", "herself", "him", "himself", "his", "how", "however", "hundred", "ie", "if", "in", "inc", "indeed", "interest", "into", "is", "it", "its", "itself", "keep", "last", "latter", "latterly", "least", "less", "ltd", "made", "many", "may", "me", "meanwhile", "might", "mill", "mine", "more", "moreover", "most", "mostly", "move", "much", "must", "my", "myself", "name", "namely", "neither", "never", "nevertheless", "next", "nine", "no", "nobody", "none", "noone", "nor", "not", "nothing", "now", "nowhere", "of", "off", "often", "on", "once", "one", "only", "onto", "or", "other", "others", "otherwise", "our", "ours", "ourselves", "out", "over", "own","part", "per", "perhaps", "please", "put", "rather", "re", "same", "see", "seem", "seemed", "seeming", "seems", "serious", "several", "she", "should", "show", "side", "since", "sincere", "six", "sixty", "so", "some", "somehow", "someone", "something", "sometime", "sometimes", "somewhere", "still", "such", "system", "take", "ten", "than", "that", "the", "their", "them", "themselves", "then", "thence", "there", "thereafter", "thereby", "therefore", "therein", "thereupon", "these", "they", "thickv", "thin", "third", "this", "those", "though", "three", "through", "throughout", "thru", "thus", "to", "together", "too", "top", "toward", "towards", "twelve", "twenty", "two", "un", "under", "until", "up", "upon", "us", "very", "via", "was", "we", "well", "were", "what", "whatever", "when", "whence", "whenever", "where", "whereafter", "whereas", "whereby", "wherein", "whereupon", "wherever", "whether", "which", "while", "whither", "who", "whoever", "whole", "whom", "whose", "why", "will", "with", "within", "without", "would", "yet", "you", "your", "yours", "yourself", "yourselves", "the"};
        String[] penn = {"cc","cd","dt","ex","fw","in","jj","jjr","jjs","ls","md","nn","nns","nnps","nnp","pdt","pos","prp","prp$","rb","rbr","rbs","rp","sym","to","uh","vb","vbd","vbg","vbn","vbp","vbz","wdt","wp","wp$","wrb"};
        reverse=false;
        this.stopwords=stopwords;
        this.penn=penn;
        
    }
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
            {System.out.println(wrd);
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
            if(temp[0].endsWith("y")||temp[0].endsWith("e")||temp[0].endsWith("ion")){
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
                            dt=wordnet.getDistance(a[0],b[0] ,a[1]);
                            if(Float.compare(dt,min)<0){min=(float)dt;}
                            System.out.println("a:"+a[0]+" , b:"+b[0]+" Distance:"+wordnet.getDistance(a[0],b[0] ,a[1]));
                        }
                    }dist=dist+min;min=2;System.out.println("hello");
                    
                }
            return dist; 
        }
   
    	public static void main(String[] args) {
            String student,faculty,s[],f[];
            float error=0;
            faculty="The QUIck brown fox! jumped over@ the, lazy dog";
            student="A pointer is a element that holds the location of another variable.";
            scoring obj=new scoring();
            f=obj.preproc(faculty);
            s=obj.preproc(student);
            System.out.println(Arrays.toString(f));
            System.out.println(Arrays.toString(s));
            error=obj.mark(f, s);
            if(s.length<3){error=5;}
            System.out.println(5-error);
        }
}

