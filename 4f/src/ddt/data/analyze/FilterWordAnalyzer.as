package ddt.data.analyze
{
   import com.hurlant.util.Base64;
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.manager.LanguageMgr;
   
   public class FilterWordAnalyzer extends DataAnalyzer
   {
       
      
      public var words:Array;
      
      public var serverWords:Array;
      
      public var unableChar:String;
      
      public function FilterWordAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
   }
}
