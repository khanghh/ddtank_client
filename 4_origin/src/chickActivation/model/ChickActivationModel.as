package chickActivation.model
{
   import chickActivation.data.ChickActivationInfo;
   import chickActivation.event.ChickActivationEvent;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.TimeManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   
   public class ChickActivationModel extends EventDispatcher
   {
       
      
      public var isOpen:Boolean = true;
      
      private var _itemInfoList:Array;
      
      public var qualityDic:Dictionary;
      
      public var isKeyOpened:int;
      
      public var keyIndex:int;
      
      public var keyOpenedTime:Date;
      
      public var keyOpenedType:int;
      
      public var gainArr:Array;
      
      public function ChickActivationModel(target:IEventDispatcher = null)
      {
         gainArr = [];
         super(target);
      }
      
      public function getInventoryItemInfo(info:ChickActivationInfo) : InventoryItemInfo
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
         return tInfo;
      }
      
      public function findQualityValue(qualityKey:String) : int
      {
         var qualityValue:int = 0;
         if(qualityDic.hasOwnProperty(qualityKey))
         {
            qualityValue = qualityDic[qualityKey];
         }
         return qualityValue;
      }
      
      public function getRemainingDay() : int
      {
         var temp:* = 86400000;
         var day:int = 0;
         if(isKeyOpened && keyOpenedTime)
         {
            day = Math.ceil((60 * temp - (TimeManager.Instance.Now().time - keyOpenedTime.time)) / temp);
            if(day > 60)
            {
               day = 60;
            }
         }
         return day;
      }
      
      public function getGainLevel(level:int) : Boolean
      {
         return (gainArr[11] & 1 << level - 1) > 0;
      }
      
      public function get itemInfoList() : Array
      {
         return _itemInfoList;
      }
      
      public function set itemInfoList(value:Array) : void
      {
         _itemInfoList = value;
      }
      
      public function dataChange(_eventType:String, _resultData:Object = null) : void
      {
         dispatchEvent(new ChickActivationEvent(_eventType,_resultData));
      }
   }
}
