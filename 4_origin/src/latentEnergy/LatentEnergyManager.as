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
      
      public function LatentEnergyManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : LatentEnergyManager
      {
         if(_instance == null)
         {
            _instance = new LatentEnergyManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(133),equipChangeHandler);
         _cacheDataList = [];
         _timer = new Timer(200,25);
         _timer.addEventListener("timer",timerHandler,false,0,true);
         _timer.addEventListener("timerComplete",timerCompleteHandler,false,0,true);
      }
      
      private function equipChangeHandler(param1:PkgEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc3_:Object = {};
         _loc3_.place = _loc4_.readInt();
         _loc3_.curStr = _loc4_.readUTF();
         _loc3_.newStr = _loc4_.readUTF();
         _loc3_.endTime = _loc4_.readDate();
         var _loc2_:InventoryItemInfo = PlayerManager.Instance.Self.Bag.items[_loc3_.place] as InventoryItemInfo;
         if(_loc2_)
         {
            doChange(_loc2_,_loc3_);
         }
         else
         {
            _cacheDataList.push(_loc3_);
            _timer.reset();
            _timer.start();
         }
      }
      
      private function doChange(param1:InventoryItemInfo, param2:Object) : void
      {
         param1.latentEnergyCurStr = param2.curStr;
         param1.latentEnergyNewStr = param2.newStr;
         param1.latentEnergyEndTime = param2.endTime;
         param1.IsBinds = true;
         dispatchEvent(new Event("latentEnergy_equip_change"));
      }
      
      private function timerHandler(param1:TimerEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = _cacheDataList.length;
         if(_loc3_ > 0)
         {
            _loc4_ = _loc3_ - 1;
            while(_loc4_ >= 0)
            {
               _loc2_ = PlayerManager.Instance.Self.Bag.items[_cacheDataList[_loc4_].place] as InventoryItemInfo;
               if(_loc2_)
               {
                  doChange(_loc2_,_cacheDataList[_loc4_]);
                  _cacheDataList.splice(_loc4_,1);
               }
               _loc4_--;
            }
         }
         else
         {
            _timer.stop();
         }
      }
      
      private function timerCompleteHandler(param1:TimerEvent) : void
      {
         _cacheDataList = [];
      }
      
      public function getCanLatentEnergyData() : BagInfo
      {
         var _loc3_:DictionaryData = PlayerManager.Instance.Self.Bag.items;
         var _loc5_:BagInfo = new BagInfo(0,21);
         var _loc2_:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            if(_loc4_.isCanLatentEnergy)
            {
               if(_loc4_.getRemainDate() > 0)
               {
                  if(_loc4_.Place < 17)
                  {
                     _loc5_.addItem(_loc4_);
                  }
                  else
                  {
                     _loc2_.push(_loc4_);
                  }
               }
            }
         }
         var _loc9_:int = 0;
         var _loc8_:* = _loc2_;
         for each(var _loc1_ in _loc2_)
         {
            _loc5_.addItem(_loc1_);
         }
         return _loc5_;
      }
      
      public function getLatentEnergyItemData() : BagInfo
      {
         var _loc1_:DictionaryData = PlayerManager.Instance.Self.PropBag.items;
         var _loc3_:BagInfo = new BagInfo(1,21);
         var _loc5_:int = 0;
         var _loc4_:* = _loc1_;
         for each(var _loc2_ in _loc1_)
         {
            if(_loc2_.CategoryID == 11 && int(_loc2_.Property1) == 101)
            {
               _loc3_.addItem(_loc2_);
            }
         }
         return _loc3_;
      }
   }
}
