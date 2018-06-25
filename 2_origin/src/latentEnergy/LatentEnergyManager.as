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
      
      public function LatentEnergyManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      private function equipChangeHandler(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var data:Object = {};
         data.place = pkg.readInt();
         data.curStr = pkg.readUTF();
         data.newStr = pkg.readUTF();
         data.endTime = pkg.readDate();
         var equipInfo:InventoryItemInfo = PlayerManager.Instance.Self.Bag.items[data.place] as InventoryItemInfo;
         if(equipInfo)
         {
            doChange(equipInfo,data);
         }
         else
         {
            _cacheDataList.push(data);
            _timer.reset();
            _timer.start();
         }
      }
      
      private function doChange(equipInfo:InventoryItemInfo, data:Object) : void
      {
         equipInfo.latentEnergyCurStr = data.curStr;
         equipInfo.latentEnergyNewStr = data.newStr;
         equipInfo.latentEnergyEndTime = data.endTime;
         equipInfo.IsBinds = true;
         dispatchEvent(new Event("latentEnergy_equip_change"));
      }
      
      private function timerHandler(event:TimerEvent) : void
      {
         var i:int = 0;
         var equipInfo:* = null;
         var len:int = _cacheDataList.length;
         if(len > 0)
         {
            for(i = len - 1; i >= 0; )
            {
               equipInfo = PlayerManager.Instance.Self.Bag.items[_cacheDataList[i].place] as InventoryItemInfo;
               if(equipInfo)
               {
                  doChange(equipInfo,_cacheDataList[i]);
                  _cacheDataList.splice(i,1);
               }
               i--;
            }
         }
         else
         {
            _timer.stop();
         }
      }
      
      private function timerCompleteHandler(event:TimerEvent) : void
      {
         _cacheDataList = [];
      }
      
      public function getCanLatentEnergyData() : BagInfo
      {
         var equipBaglist:DictionaryData = PlayerManager.Instance.Self.Bag.items;
         var latentEnergyBagList:BagInfo = new BagInfo(0,21);
         var arr:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = equipBaglist;
         for each(var item in equipBaglist)
         {
            if(item.isCanLatentEnergy)
            {
               if(item.getRemainDate() > 0)
               {
                  if(item.Place < 17)
                  {
                     latentEnergyBagList.addItem(item);
                  }
                  else
                  {
                     arr.push(item);
                  }
               }
            }
         }
         var _loc9_:int = 0;
         var _loc8_:* = arr;
         for each(var infoItem in arr)
         {
            latentEnergyBagList.addItem(infoItem);
         }
         return latentEnergyBagList;
      }
      
      public function getLatentEnergyItemData() : BagInfo
      {
         var proBaglist:DictionaryData = PlayerManager.Instance.Self.PropBag.items;
         var latentEnergyBagList:BagInfo = new BagInfo(1,21);
         var _loc5_:int = 0;
         var _loc4_:* = proBaglist;
         for each(var item in proBaglist)
         {
            if(item.CategoryID == 11 && int(item.Property1) == 101)
            {
               latentEnergyBagList.addItem(item);
            }
         }
         return latentEnergyBagList;
      }
   }
}
