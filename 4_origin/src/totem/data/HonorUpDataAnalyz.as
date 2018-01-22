package totem.data
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class HonorUpDataAnalyz extends DataAnalyzer
   {
       
      
      private var _dataList:Array;
      
      public function HonorUpDataAnalyz(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:XML = new XML(param1);
         _dataList = [];
         if(_loc2_.@value == "true")
         {
            _loc3_ = _loc2_..item;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length())
            {
               _loc4_ = new HonorUpDataVo();
               _loc4_.index = _loc3_[_loc5_].@ID;
               _loc4_.honor = _loc3_[_loc5_].@AddHonor;
               _loc4_.money = _loc3_[_loc5_].@NeedMoney;
               _dataList.push(_loc4_);
               _loc5_++;
            }
            _dataList.sortOn("index",16);
            onAnalyzeComplete();
         }
         else
         {
            message = _loc2_.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
      
      public function get dataList() : Array
      {
         return _dataList;
      }
   }
}
