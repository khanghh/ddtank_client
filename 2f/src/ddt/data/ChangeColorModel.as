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
      
      public function ChangeColorModel(){super();}
      
      private function init() : void{}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function __updateItem(param1:BagEvent) : void{}
      
      public function getColorEditableThings() : void{}
      
      public function setOnlyOneEditableThing(param1:InventoryItemInfo) : void{}
      
      public function savaItemInfo() : void{}
      
      public function restoreItem() : void{}
      
      public function get colorEditableThings() : DictionaryData{return null;}
      
      public function set self(param1:SelfInfo) : void{}
      
      public function get self() : SelfInfo{return null;}
      
      public function set currentItem(param1:InventoryItemInfo) : void{}
      
      public function findBodyThingByCategoryID(param1:int) : InventoryItemInfo{return null;}
      
      public function get currentItem() : InventoryItemInfo{return null;}
      
      public function set changed(param1:Boolean) : void{}
      
      public function get changed() : Boolean{return false;}
      
      public function get oldHideHat() : Boolean{return false;}
      
      public function get oldHideGlass() : Boolean{return false;}
      
      public function get oldHideSuit() : Boolean{return false;}
      
      public function unlockAll() : void{}
      
      public function dispose() : void{}
   }
}
