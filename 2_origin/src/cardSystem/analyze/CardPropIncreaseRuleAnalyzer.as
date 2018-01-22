package cardSystem.analyze
{
   import cardSystem.data.CardPropIncreaseInfo;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   
   public class CardPropIncreaseRuleAnalyzer extends DataAnalyzer
   {
       
      
      private var _levelIncre:DictionaryData;
      
      public var propIncreaseDic:DictionaryData;
      
      public function CardPropIncreaseRuleAnalyzer(param1:Function)
      {
         super(param1);
         propIncreaseDic = new DictionaryData();
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc3_:XML = new XML(param1);
         if(_loc3_.@value == "true")
         {
            _loc4_ = _loc3_..Item;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length())
            {
               _loc5_ = new CardPropIncreaseInfo();
               ObjectUtils.copyPorpertiesByXML(_loc5_,_loc4_[_loc6_]);
               _loc2_ = _loc4_[_loc6_].@Id;
               if(propIncreaseDic[_loc2_] == null)
               {
                  propIncreaseDic[_loc2_] = new DictionaryData();
                  propIncreaseDic[_loc2_].add(_loc5_.Level,_loc5_);
               }
               else
               {
                  propIncreaseDic[_loc2_].add(_loc5_.Level,_loc5_);
               }
               _loc6_++;
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
