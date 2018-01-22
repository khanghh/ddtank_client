package team.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   import team.model.TeamShopInfo;
   
   public class TeamShopAnalyze extends DataAnalyzer
   {
       
      
      public var data:DictionaryData;
      
      public var buyLimitLv:Array;
      
      public function TeamShopAnalyze(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:* = null;
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc4_:XML = new XML(param1);
         buyLimitLv = [];
         data = new DictionaryData();
         if(_loc4_.@value == "true")
         {
            _loc5_ = _loc4_..Item;
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length())
            {
               _loc6_ = new TeamShopInfo();
               ObjectUtils.copyPorpertiesByXML(_loc6_,_loc5_[_loc7_]);
               _loc2_ = _loc5_[_loc7_].@NeedLevel;
               if(buyLimitLv.indexOf(_loc2_) == -1)
               {
                  buyLimitLv.push(_loc2_);
               }
               if(!data.hasKey(_loc6_.ShopType))
               {
                  data.add(_loc6_.ShopType,[]);
               }
               _loc3_ = data[_loc6_.ShopType];
               _loc3_.push(_loc6_);
               _loc7_++;
            }
            buyLimitLv.sort();
            onAnalyzeComplete();
         }
         else
         {
            message = _loc4_.@message;
            onAnalyzeError();
         }
         data = null;
         buyLimitLv = null;
      }
   }
}
