package luckStar.manager
{
   import ddt.CoreManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import hallIcon.HallIconManager;
   import luckStar.model.LuckStarModel;
   import road7th.comm.PackageIn;
   
   public class LuckStarManager extends CoreManager
   {
      
      private static var _instance:LuckStarManager;
      
      public static const LUCKSTAR_FRAMECLOSE:String = "luckstarframeclose";
      
      public static const UPDATE_REWARD:String = "updatereward";
      
      public static const ALLGOODSINFO:String = "allgoodsinfo";
      
      public static const TURNGOODSINFO:String = "turngoodsinfo";
      
      public static const OPEN_LUCKYSTARFRAME:String = "openluckystarframe";
      
      public static const LOADER_LUCKSTAR_ICON:String = "loaderluckstaricon";
       
      
      private var _model:LuckStarModel;
      
      private var _isOpen:Boolean;
      
      public var iteminfo:InventoryItemInfo;
      
      public var rewardMsg:Object;
      
      public function LuckStarManager(){super();}
      
      public static function get Instance() : LuckStarManager{return null;}
      
      public function setup() : void{}
      
      private function __onActivityOpen(param1:CrazyTankSocketEvent) : void{}
      
      private function __onActivityEnd(param1:CrazyTankSocketEvent) : void{}
      
      private function __onAllGoodsInfo(param1:CrazyTankSocketEvent) : void{}
      
      private function __onTurnGoodsInfo(param1:CrazyTankSocketEvent) : void{}
      
      private function __onUpdateReward(param1:CrazyTankSocketEvent) : void{}
      
      private function __onReward(param1:CrazyTankSocketEvent) : void{}
      
      private function __onAwardRank(param1:CrazyTankSocketEvent) : void{}
      
      private function getTemplateInfo(param1:int) : InventoryItemInfo{return null;}
      
      public function addEnterIcon() : void{}
      
      public function onClickLuckyStarIocn(param1:MouseEvent) : void{}
      
      public function disposeEnterIcon() : void{}
      
      public function dispose() : void{}
      
      public function openLuckyStarFrame() : void{}
      
      public function addSocketEvent() : void{}
      
      public function removeSocketEvent() : void{}
      
      public function get isOpen() : Boolean{return false;}
      
      public function get model() : LuckStarModel{return null;}
   }
}
