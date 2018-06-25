package ddt.data
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.PyramidEvent;
   import ddt.manager.ItemManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   
   public class PyramidModel extends EventDispatcher
   {
       
      
      public var isOpen:Boolean;
      
      public var isScoreExchange:Boolean;
      
      public var turnCardPrice:int;
      
      public var revivePrice:Array;
      
      public var freeCount:int;
      
      public var beginTime:Date;
      
      public var endTime:Date;
      
      public var currentLayer:int;
      
      public var position:int;
      
      public var maxLayer:int;
      
      private var _totalPoint:int;
      
      public var turnPoint:int;
      
      public var pointRatio:int;
      
      public var currentFreeCount:int;
      
      public var currentReviveCount:int;
      
      public var isPyramidStart:Boolean;
      
      public var selectLayerItems:Dictionary;
      
      public var templateID:int;
      
      public var isPyramidDie:Boolean;
      
      public var isUp:Boolean;
      
      public var items:Array;
      
      public function PyramidModel(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public function getLevelCardItems(level:int) : Array
      {
         return items[level - 1];
      }
      
      public function getLevelCardItem(level:int, templateID:int) : PyramidSystemItemsInfo
      {
         var item:* = null;
         var arr:* = null;
         var i:int = 0;
         var temp:* = null;
         if(isUp)
         {
            arr = items[level - 2];
         }
         else
         {
            arr = items[level - 1];
         }
         for(i = 0; i < arr.length; )
         {
            temp = arr[i];
            if(temp.TemplateID == templateID)
            {
               item = temp;
               break;
            }
            i++;
         }
         return item;
      }
      
      public function getInventoryItemInfo(info:PyramidSystemItemsInfo) : InventoryItemInfo
      {
         var tempInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(info.TemplateID);
         var tInfo:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(tInfo,tempInfo);
         tInfo.LuckCompose = info.TemplateID;
         tInfo.ValidDate = info.ValidDate;
         tInfo.Count = info.Count;
         tInfo.IsBinds = info.IsBind;
         tInfo.StrengthenLevel = info.StrengthLevel;
         tInfo.AttackCompose = info.AttackCompose;
         tInfo.DefendCompose = info.DefendCompose;
         tInfo.AgilityCompose = info.AgilityCompose;
         tInfo.LuckCompose = info.LuckCompose;
         tInfo.isShowBind = false;
         return tInfo;
      }
      
      public function get startActivityTime() : String
      {
         var minutes:* = null;
         var dateString:String = "";
         if(beginTime)
         {
            minutes = beginTime.minutes > 9?beginTime.minutes + "":"0" + beginTime.minutes;
            dateString = beginTime.fullYear + "." + (beginTime.month + 1) + "." + beginTime.date + " " + beginTime.hours + ":" + minutes;
         }
         return dateString;
      }
      
      public function get endActivityTime() : String
      {
         var minutes:* = null;
         var dateString:String = "";
         if(endTime)
         {
            minutes = endTime.minutes > 9?endTime.minutes + "":"0" + endTime.minutes;
            dateString = endTime.fullYear + "." + (endTime.month + 1) + "." + endTime.date + " " + endTime.hours + ":" + minutes;
         }
         return dateString;
      }
      
      public function get isShuffleMovie() : Boolean
      {
         if(currentLayer >= 8)
         {
            return false;
         }
         if(!isPyramidStart)
         {
            return false;
         }
         if(isUp)
         {
            return true;
         }
         var length:int = 0;
         var dic:Dictionary = selectLayerItems[currentLayer];
         var _loc5_:int = 0;
         var _loc4_:* = dic;
         for each(var obj in dic)
         {
            length++;
         }
         if(length > 0)
         {
            return false;
         }
         return true;
      }
      
      public function dataChange(_eventType:String, _resultData:Object = null) : void
      {
         dispatchEvent(new PyramidEvent(_eventType,_resultData));
      }
      
      public function set totalPoint(value:int) : void
      {
         _totalPoint = value;
         dispatchEvent(new PyramidEvent("dataChange"));
      }
      
      public function get totalPoint() : int
      {
         return this._totalPoint;
      }
   }
}
