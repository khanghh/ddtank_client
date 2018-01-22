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
      
      public function FilterWordAnalyzer(param1:Function)
      {
         words = [];
         serverWords = [];
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc6_:* = null;
         var _loc2_:String = Base64.decode(String(param1));
         _loc2_ = _loc2_.toLocaleLowerCase();
         var _loc4_:Array = LanguageMgr.GetTranslation("zangNoFilterWords").split(",");
         var _loc8_:int = 0;
         var _loc7_:* = _loc4_;
         for each(var _loc5_ in _loc4_)
         {
            _loc6_ = new RegExp(_loc5_,"g");
            _loc2_ = _loc2_.replace(_loc6_,"");
         }
         var _loc3_:Array = _loc2_.toLocaleLowerCase().split("\n");
         if(_loc3_)
         {
            if(_loc3_[0])
            {
               unableChar = _loc3_[0];
            }
            if(_loc3_[1])
            {
               words = _loc3_[1].split("|");
            }
            if(_loc3_[2])
            {
               serverWords = _loc3_[2].split("|");
            }
         }
         onAnalyzeComplete();
      }
   }
}
