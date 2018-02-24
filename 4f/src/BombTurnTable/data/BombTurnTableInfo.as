package BombTurnTable.data
{
   public class BombTurnTableInfo
   {
       
      
      private var _level:int;
      
      private var _goodsInfo:Vector.<BombTurnTableGoodInfo>;
      
      public function BombTurnTableInfo(){super();}
      
      public function get goodsInfo() : Vector.<BombTurnTableGoodInfo>{return null;}
      
      public function set goodsInfo(param1:Vector.<BombTurnTableGoodInfo>) : void{}
      
      public function get level() : int{return 0;}
      
      public function set level(param1:int) : void{}
      
      public function get quality() : int{return 0;}
   }
}
