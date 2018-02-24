package ddtBuried
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.events.PkgEvent;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddtBuried.data.SearchGoodsData;
   import ddtBuried.data.UpdateStarData;
   import ddtBuried.event.BuriedEvent;
   import ddtBuried.map.MapArrays;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import labyrinth.LabyrinthControl;
   import road7th.comm.PackageIn;
   import treasureHunting.views.TransactionsDiceFrame;
   
   public class BuriedControl extends EventDispatcher
   {
      
      public static const MAP1:int = 1;
      
      public static const MAP2:int = 2;
      
      public static const MAP3:int = 3;
      
      private static var _instance:BuriedControl;
       
      
      public var mapArrays:MapArrays;
      
      private var _frame:BuriedFrame;
      
      private var _transactionsFrame:TransactionsDiceFrame;
      
      private var _shopframe:BuriedShopFrame;
      
      private var _curGainBoxIndex:int;
      
      public var reachEndRewardsIDs:Array;
      
      private var _manager:BuriedManager;
      
      public function BuriedControl(){super();}
      
      public static function get Instance() : BuriedControl{return null;}
      
      public function getTakeCardPay() : String{return null;}
      
      public function oneDegreeToTwoDegree(param1:String, param2:int, param3:int) : Array{return null;}
      
      public function setup() : void{}
      
      public function getUpdateData(param1:Boolean) : UpdateStarData{return null;}
      
      public function getPayData() : SearchGoodsData{return null;}
      
      private function initEvents() : void{}
      
      protected function mapOverHandler(param1:BuriedEvent) : void{}
      
      public function requireGainRewards(param1:int) : void{}
      
      protected function onGainRewards(param1:PkgEvent) : void{}
      
      private function playerRollDiceHander(param1:PkgEvent) : void{}
      
      private function playerUpgradeLevelEnterHander(param1:PkgEvent) : void{}
      
      protected function __onOpenView(param1:BuriedEvent) : void{}
      
      protected function createActivityFrame() : void{}
      
      private function initFrames() : void{}
      
      private function openShopView(param1:BuriedEvent) : void{}
      
      public function openshopHander() : void{}
      
      protected function frameEvent(param1:FrameEvent) : void{}
      
      public function dispose() : void{}
      
      public function showTransactionFrame(param1:String, param2:Function = null, param3:Function = null, param4:Sprite = null) : void{}
      
      public function get curGainBoxIndex() : int{return 0;}
   }
}
