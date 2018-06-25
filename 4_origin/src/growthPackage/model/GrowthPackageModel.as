package growthPackage.model
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import growthPackage.data.GrowthPackageInfo;
   import growthPackage.event.GrowthPackageEvent;
   
   public class GrowthPackageModel extends EventDispatcher
   {
       
      
      private var _isBuy:int;
      
      private var _buyPrice:Number;
      
      private var _itemInfoList:Array;
      
      private var _isCompleteList:Array;
      
      private var _gradeList:Array;
      
      public function GrowthPackageModel(target:IEventDispatcher = null)
      {
         _isCompleteList = [0,0,0,0,0,0,0,0];
         _gradeList = new Array(10,20,30,40,45,50,55,60,65);
         super(target);
      }
      
      public function getInventoryItemInfo(info:GrowthPackageInfo) : InventoryItemInfo
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
      
      public function dataChange(_eventType:String, _resultData:Object = null) : void
      {
         dispatchEvent(new GrowthPackageEvent(_eventType,_resultData));
      }
      
      public function get buyPrice() : Number
      {
         return _buyPrice;
      }
      
      public function set buyPrice(value:Number) : void
      {
         _buyPrice = value;
      }
      
      public function get itemInfoList() : Array
      {
         return _itemInfoList;
      }
      
      public function set itemInfoList(value:Array) : void
      {
         _itemInfoList = value;
      }
      
      public function get isCompleteList() : Array
      {
         return _isCompleteList;
      }
      
      public function set isCompleteList(value:Array) : void
      {
         _isCompleteList = value;
         if(!isShowIcon)
         {
            dataChange("icon_close");
         }
      }
      
      public function get isShowIcon() : Boolean
      {
         var tempCount:int = 0;
         var i:int = 0;
         var temp:int = 0;
         if(isBuy && _isCompleteList)
         {
            for(i = 0; i < _isCompleteList.length; )
            {
               temp = _isCompleteList[i];
               if(temp == 1)
               {
                  tempCount++;
               }
               i++;
            }
            if(tempCount > 0 && tempCount == _isCompleteList.length)
            {
               return false;
            }
         }
         return true;
      }
      
      public function get gradeList() : Array
      {
         return _gradeList;
      }
      
      public function set gradeList(value:Array) : void
      {
         _gradeList = value;
      }
      
      public function get isBuy() : int
      {
         return _isBuy;
      }
      
      public function set isBuy(value:int) : void
      {
         _isBuy = value;
      }
   }
}
