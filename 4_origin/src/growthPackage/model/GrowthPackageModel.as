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
      
      public function GrowthPackageModel(param1:IEventDispatcher = null)
      {
         _isCompleteList = [0,0,0,0,0,0,0,0];
         _gradeList = new Array(10,20,30,40,45,50,55,60,65);
         super(param1);
      }
      
      public function getInventoryItemInfo(param1:GrowthPackageInfo) : InventoryItemInfo
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
      
      public function dataChange(param1:String, param2:Object = null) : void
      {
         dispatchEvent(new GrowthPackageEvent(param1,param2));
      }
      
      public function get buyPrice() : Number
      {
         return _buyPrice;
      }
      
      public function set buyPrice(param1:Number) : void
      {
         _buyPrice = param1;
      }
      
      public function get itemInfoList() : Array
      {
         return _itemInfoList;
      }
      
      public function set itemInfoList(param1:Array) : void
      {
         _itemInfoList = param1;
      }
      
      public function get isCompleteList() : Array
      {
         return _isCompleteList;
      }
      
      public function set isCompleteList(param1:Array) : void
      {
         _isCompleteList = param1;
         if(!isShowIcon)
         {
            dataChange("icon_close");
         }
      }
      
      public function get isShowIcon() : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         if(isBuy && _isCompleteList)
         {
            _loc3_ = 0;
            while(_loc3_ < _isCompleteList.length)
            {
               _loc1_ = _isCompleteList[_loc3_];
               if(_loc1_ == 1)
               {
                  _loc2_++;
               }
               _loc3_++;
            }
            if(_loc2_ > 0 && _loc2_ == _isCompleteList.length)
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
      
      public function set gradeList(param1:Array) : void
      {
         _gradeList = param1;
      }
      
      public function get isBuy() : int
      {
         return _isBuy;
      }
      
      public function set isBuy(param1:int) : void
      {
         _isBuy = param1;
      }
   }
}
