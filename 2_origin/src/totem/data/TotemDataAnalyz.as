package totem.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class TotemDataAnalyz extends DataAnalyzer
   {
       
      
      private var _dataList:Object;
      
      private var _dataList2:Object;
      
      public function TotemDataAnalyz(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         _dataList = {};
         _dataList2 = {};
         var _loc2_:XML = new XML(param1);
         if(_loc2_.@value == "true")
         {
            _loc3_ = _loc2_..item;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length())
            {
               _loc4_ = new TotemDataVo();
               ObjectUtils.copyPorpertiesByXML(_loc4_,_loc3_[_loc5_]);
               _dataList[_loc4_.ID] = _loc4_;
               _dataList2[_loc4_.Point] = _loc4_;
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc2_.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
      
      public function get dataList() : Object
      {
         return _dataList;
      }
      
      public function get dataList2() : Object
      {
         return _dataList2;
      }
   }
}
