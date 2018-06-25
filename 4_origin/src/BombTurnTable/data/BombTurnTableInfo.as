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
      
      public function set goodsInfo(value:Vector.<BombTurnTableGoodInfo>) : void
      {
         _goodsInfo = value;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set level(value:int) : void
      {
         _level = value;
      }
      
      public function get quality() : int
      {
         return (_level - 1) / 4;
      }
   }
}
