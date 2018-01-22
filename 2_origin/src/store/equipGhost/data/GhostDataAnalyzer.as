package store.equipGhost.data
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public final class GhostDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _dataList:Vector.<GhostData>;
      
      public function GhostDataAnalyzer(param1:Function)
      {
         _dataList = new Vector.<GhostData>();
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc2_:XML = new XML(param1);
         if(_loc2_.@value == "true")
         {
            _loc3_ = _loc2_..Item;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length())
            {
               _loc4_ = new GhostData();
               _loc4_.parseXML(_loc3_[_loc5_]);
               _dataList.push(_loc4_);
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc2_.@message;
            onAnalyzeError();
         }
      }
      
      public function get data() : Vector.<GhostData>
      {
         return _dataList;
      }
   }
}
