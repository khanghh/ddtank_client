package BombTurnTable.data
{
   public class BombTurnTableInfo
   {
       
      
      private var _level:int;
      
      private var _goodsInfo:Vector.<BombTurnTableGoodInfo>;
      
      public function BombTurnTableInfo()
      {
         super();
      }
      
      public function get goodsInfo() : Vector.<BombTurnTableGoodInfo>
      {
         if(_goodsInfo == null)
         {
            _goodsInfo = new Vector.<BombTurnTableGoodInfo>();
         }
         return _goodsInfo;
      }
      
      public function set goodsInfo(param1:Vector.<BombTurnTableGoodInfo>) : void
      {
         _goodsInfo = param1;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set level(param1:int) : void
      {
         _level = param1;
      }
      
      public function get quality() : int
      {
         return (_level - 1) / 4;
      }
   }
}
