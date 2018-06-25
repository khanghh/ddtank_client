package ddt.data
{
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.BagEvent;
   import ddt.manager.PlayerManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   
   public class ChangeColorModel extends EventDispatcher
   {
       
      
      private var _colorEditableThings:DictionaryData;
      
      private var _self:SelfInfo;
      
      private var _currentItem:InventoryItemInfo;
      
      private var _oldHideHat:Boolean;
      
      private var _oldHideGlass:Boolean;
      
      private var _oldHideSuit:Boolean;
      
      private var _changed:Boolean = false;
      
      private var _tempColor:String = "";
      
      private var _tempSkin:String = "";
      
      private var _equipBag:BagInfo;
      
      public var place:int = -1;
      
      public var colorEditableBag:BagInfo;
      
      public var initColor:String;
      
      public var initSkinColor:String;
      
      public function ChangeColorModel()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _self = new SelfInfo();
         _self.beginChanges();
         _self.Sex = PlayerManager.Instance.Self.Sex;
         _self.Hide = PlayerManager.Instance.Self.Hide;
         _self.Style = PlayerManager.Instance.Self.getPrivateStyle();
         _self.Colors = PlayerManager.Instance.Self.Colors;
         _self.Skin = PlayerManager.Instance.Self.Skin;
         _self.commitChanges();
         _oldHideHat = _self.getHatHide();
         _oldHideGlass = _self.getGlassHide();
         _oldHideSuit = _self.getSuitesHide();
         _equipBag = PlayerManager.Instance.Self.Bag;
         colorEditableBag = new BagInfo(0,76);
         _colorEditableThings = new DictionaryData();
         colorEditableBag.items = _colorEditableThings;
         initEvents();
      }
      
      private function initEvents() : void
      {
         _equipBag.addEventListener("update",__updateItem);
      }
      
      private function removeEvents() : void
      {
         _equipBag.removeEventListener("update",__updateItem);
      }
      
      private function __updateItem(evt:BagEvent) : void
      {
         var changedSlots:Dictionary = evt.changedSlots;
         evt.stopImmediatePropagation();
         colorEditableBag.dispatchEvent(new BagEvent("update",changedSlots));
      }
      
      public function getColorEditableThings() : void
      {
         var item:* = null;
         var i:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _equipBag.items;
         for each(item in _equipBag.items)
         {
            if(item.Place > 30)
            {
               if(EquipType.isEditable(item) && item.getRemainDate() > 0)
               {
                  i++;
                  _colorEditableThings.add(i,item);
               }
            }
         }
      }
      
      public function setOnlyOneEditableThing(item:InventoryItemInfo) : void
      {
         _colorEditableThings.add(0,item);
      }
      
      public function savaItemInfo() : void
      {
         _tempColor = _currentItem.Color;
         _tempSkin = _currentItem.Skin;
      }
      
      public function restoreItem() : void
      {
         if(_currentItem)
         {
            _currentItem.Color = _tempColor;
            _currentItem.Skin = _tempSkin;
         }
      }
      
      public function get colorEditableThings() : DictionaryData
      {
         return _colorEditableThings;
      }
      
      public function set self(value:SelfInfo) : void
      {
      }
      
      public function get self() : SelfInfo
      {
         return _self;
      }
      
      public function set currentItem(value:InventoryItemInfo) : void
      {
         _currentItem = value;
      }
      
      public function findBodyThingByCategoryID(id:int) : InventoryItemInfo
      {
         return _equipBag.findFirstItem(id);
      }
      
      public function get currentItem() : InventoryItemInfo
      {
         return _currentItem;
      }
      
      public function set changed(value:Boolean) : void
      {
         _changed = value;
         dispatchEvent(new Event("setColor"));
      }
      
      public function get changed() : Boolean
      {
         return _changed;
      }
      
      public function get oldHideHat() : Boolean
      {
         return _oldHideHat;
      }
      
      public function get oldHideGlass() : Boolean
      {
         return _oldHideGlass;
      }
      
      public function get oldHideSuit() : Boolean
      {
         return _oldHideSuit;
      }
      
      public function unlockAll() : void
      {
         _equipBag.unLockAll();
      }
      
      public function dispose() : void
      {
         restoreItem();
         removeEvents();
         _colorEditableThings = null;
         _equipBag = null;
         _self = null;
         initColor = null;
         initSkinColor = null;
      }
   }
}
