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
      
      public function FilterWordAnalyzer(onCompleteCall:Function)
      {
         words = [];
         serverWords = [];
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var exc:* = null;
         var str:String = Base64.decode(String(data));
         str = str.toLocaleLowerCase();
         var NoFilterWords:Array = LanguageMgr.GetTranslation("zangNoFilterWords").split(",");
         var _loc8_:int = 0;
         var _loc7_:* = NoFilterWords;
         for each(var tmp in NoFilterWords)
         {
            exc = new RegExp(tmp,"g");
            str = str.replace(exc,"");
         }
         var arr:Array = str.toLocaleLowerCase().split("\n");
         if(arr)
         {
            if(arr[0])
            {
               unableChar = arr[0];
            }
            if(arr[1])
            {
               words = arr[1].split("|");
            }
            if(arr[2])
            {
               serverWords = arr[2].split("|");
            }
         }
         onAnalyzeComplete();
      }
   }
}
