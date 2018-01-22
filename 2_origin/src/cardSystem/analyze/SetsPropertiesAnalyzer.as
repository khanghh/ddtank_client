package cardSystem.analyze
{
   import cardSystem.data.SetsPropertyInfo;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   
   public class SetsPropertiesAnalyzer extends DataAnalyzer
   {
       
      
      public var setsList:DictionaryData;
      
      public function SetsPropertiesAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc6_:* = null;
         var _loc9_:int = 0;
         var _loc2_:* = null;
         var _loc5_:* = undefined;
         var _loc8_:* = null;
         var _loc4_:int = 0;
         var _loc7_:* = null;
         setsList = new DictionaryData();
         var _loc3_:XML = new XML(param1);
         if(_loc3_.@value == "true")
         {
            _loc6_ = _loc3_..Card;
            _loc9_ = 0;
            while(_loc9_ < _loc6_.length())
            {
               _loc2_ = _loc6_[_loc9_].@CardID;
               _loc5_ = new Vector.<SetsPropertyInfo>();
               _loc8_ = _loc6_[_loc9_]..Item;
               _loc4_ = 0;
               while(_loc4_ < _loc8_.length())
               {
                  if(_loc8_[_loc4_].@condition != "0")
                  {
                     _loc7_ = new SetsPropertyInfo();
                     ObjectUtils.copyPorpertiesByXML(_loc7_,_loc8_[_loc4_]);
                     _loc5_.push(_loc7_);
                  }
                  _loc4_++;
               }
               setsList.add(_loc2_,_loc5_);
               _loc9_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
