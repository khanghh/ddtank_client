package latentEnergy
{
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   
   public class LatentEnergyManager extends EventDispatcher
   {
      
      public static const EQUIP_MOVE:String = "latentEnergy_equip_move";
      
      public static const EQUIP_MOVE2:String = "latentEnergy_equip_move2";
      
      public static const ITEM_MOVE:String = "latentEnergy_item_move";
      
      public static const ITEM_MOVE2:String = "latentEnergy_item_move2";
      
      public static const EQUIP_CHANGE:String = "latentEnergy_equip_change";
      
      private static var _instance:LatentEnergyManager;
       
      
      private var _cacheDataList:Array;
      
      private var _timer:Timer;
      
      public function LatentEnergyManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : LatentEnergyManager{return null;}
      
      public function setup() : void{}
      
      private function equipChangeHandler(param1:PkgEvent) : void{}
      
      private function doChange(param1:InventoryItemInfo, param2:Object) : void{}
      
      private function timerHandler(param1:TimerEvent) : void{}
      
      private function timerCompleteHandler(param1:TimerEvent) : void{}
      
      public function getCanLatentEnergyData() : BagInfo{return null;}
      
      public function getLatentEnergyItemData() : BagInfo{return null;}
   }
}
