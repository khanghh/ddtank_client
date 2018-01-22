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
      
      public function ChickActivationModel(param1:IEventDispatcher = null)
      {
         gainArr = [];
         super(param1);
      }
      
      public function getInventoryItemInfo(param1:ChickActivationInfo) : InventoryItemInfo
      {
         var _loc3_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(param1.TemplateID);
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(_loc2_,_loc3_);
         _loc2_.LuckCompose = param1.TemplateID;
         _loc2_.ValidDate = param1.ValidDate;
         _loc2_.Count = param1.Count;
         _loc2_.IsBinds = param1.IsBind;
         _loc2_.StrengthenLevel = param1.StrengthLevel;
         _loc2_.AttackCompose = param1.AttackCompose;
         _loc2_.DefendCompose = param1.DefendCompose;
         _loc2_.AgilityCompose = param1.AgilityCompose;
         _loc2_.LuckCompose = param1.LuckCompose;
         return _loc2_;
      }
      
      public function findQualityValue(param1:String) : int
      {
         var _loc2_:int = 0;
         if(qualityDic.hasOwnProperty(param1))
         {
            _loc2_ = qualityDic[param1];
         }
         return _loc2_;
      }
      
      public function getRemainingDay() : int
      {
         var _loc1_:* = 86400000;
         var _loc2_:int = 0;
         if(isKeyOpened && keyOpenedTime)
         {
            _loc2_ = Math.ceil((60 * _loc1_ - (TimeManager.Instance.Now().time - keyOpenedTime.time)) / _loc1_);
            if(_loc2_ > 60)
            {
               _loc2_ = 60;
            }
         }
         return _loc2_;
      }
      
      public function getGainLevel(param1:int) : Boolean
      {
         return (gainArr[11] & 1 << param1 - 1) > 0;
      }
      
      public function get itemInfoList() : Array
      {
         return _itemInfoList;
      }
      
      public function set itemInfoList(param1:Array) : void
      {
         _itemInfoList = param1;
      }
      
      public function dataChange(param1:String, param2:Object = null) : void
      {
         dispatchEvent(new ChickActivationEvent(param1,param2));
      }
   }
}
