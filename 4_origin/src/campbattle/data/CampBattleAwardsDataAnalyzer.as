package campbattle.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class CampBattleAwardsDataAnalyzer extends DataAnalyzer
   {
       
      
      public var _dataList:Array;
      
      public function CampBattleAwardsDataAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         _dataList = [];
         var _loc4_:XML = new XML(param1);
         if(_loc4_.@value == "true")
         {
            _loc5_ = _loc4_..Item;
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length())
            {
               _loc3_ = new CampBattleAwardsGoodsInfo();
               ObjectUtils.copyPorpertiesByXML(_loc3_,_loc5_[_loc6_]);
               _loc2_ = _dataList[_loc3_.ID - 1];
               if(!_loc2_)
               {
                  _loc2_ = [];
               }
               _loc2_.push(_loc3_);
               _dataList[_loc3_.ID - 1] = _loc2_;
               _loc6_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc4_.@message;
            onAnalyzeError();
         }
      }
   }
}
