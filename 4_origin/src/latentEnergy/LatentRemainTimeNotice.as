package latentEnergy
{
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import flash.events.Event;
   import flash.utils.setTimeout;
   import playerDress.PlayerDressManager;
   
   public class LatentRemainTimeNotice
   {
      
      private static var instance:LatentRemainTimeNotice;
       
      
      private var bagUpdated:Boolean = false;
      
      private var dressModelSet:Boolean = false;
      
      public function LatentRemainTimeNotice(param1:inner)
      {
         super();
      }
      
      public static function getInstance() : LatentRemainTimeNotice
      {
         if(!instance)
         {
            instance = new LatentRemainTimeNotice(new inner());
         }
         return instance;
      }
      
      public function ShowNotice() : void
      {
      }
      
      public function init() : void
      {
         addEvents();
      }
      
      public function dispose() : void
      {
         removeEvents();
         instance = null;
      }
      
      private function addEvents() : void
      {
         PlayerManager.Instance.addEventListener("bag_update",onBagUpdated);
         SocketManager.Instance.addEventListener("currentmodel_set",onDressSet);
      }
      
      private function removeEvents() : void
      {
         PlayerManager.Instance.removeEventListener("bag_update",onBagUpdated);
         SocketManager.Instance.removeEventListener("currentmodel_set",onDressSet);
      }
      
      protected function onDressSet(param1:Event) : void
      {
         dressModelSet = true;
         if(!bagUpdated)
         {
            return;
         }
         checkItems();
      }
      
      protected function onBagUpdated(param1:Event) : void
      {
         PlayerManager.Instance.removeEventListener("bag_update",onBagUpdated);
         bagUpdated = true;
         if(!dressModelSet)
         {
            return;
         }
         checkItems();
      }
      
      private function checkItems() : void
      {
         showMsg = function():void
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.latentEnergy.expire"),0,true,1);
         };
         var curIndex:int = PlayerDressManager.instance.currentIndex;
         var tpArr:Array = PlayerDressManager.instance.modelArr;
         var curDressArr:Array = PlayerDressManager.instance.modelArr[curIndex];
         if(curDressArr == null)
         {
            return;
         }
         var __date:Date = new Date();
         var __time:Number = __date.time;
         var bag:BagInfo = PlayerManager.Instance.Self.getBag(0);
         var expiredArr:Array = [];
         trace("今天:",TimeManager.Instance.Now().getTime());
         var _loc3_:int = 0;
         var _loc2_:* = bag.items;
         loop0:
         for each(v in bag.items)
         {
            trace(v.Name,v.latentEnergyEndTime.fullYear,v.latentEnergyEndTime.month,v.latentEnergyEndTime.date);
            if(v.latentEnergyEndTime && v.latentEnergyEndTime.getTime() <= TimeManager.Instance.Now().getTime() && v.latentEnergyEndTime.getTime() > TimeManager.Instance.Now().getTime() - 259200000)
            {
               var dressArrLen:int = curDressArr.length;
               var key:int = 0;
               while(key < dressArrLen)
               {
                  if(curDressArr[key].itemId == v.ItemID)
                  {
                     expiredArr.push(v.Name);
                     break loop0;
                  }
                  key = Number(key) + 1;
               }
               continue;
            }
         }
         if(expiredArr.length > 0)
         {
            setTimeout(showMsg,5000);
         }
         dispose();
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
