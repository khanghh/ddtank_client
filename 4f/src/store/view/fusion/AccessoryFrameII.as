package store.view.fusion
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.events.Event;
   import store.events.StoreIIEvent;
   
   public class AccessoryFrameII extends Frame
   {
       
      
      private var _list:SimpleTileList;
      
      private var _bg:Shape;
      
      private var _items:Array;
      
      private var _area:AccessoryDragInArea;
      
      public function AccessoryFrameII(){super();}
      
      private function initII() : void{}
      
      private function initList() : void{}
      
      private function __itemInfoChange(param1:Event) : void{}
      
      public function clearList() : void{}
      
      public function get isBinds() : Boolean{return false;}
      
      public function setItemInfo(param1:int, param2:ItemTemplateInfo) : void{}
      
      public function listEmpty() : void{}
      
      public function show() : void{}
      
      public function hide() : void{}
      
      public function getCount() : Number{return 0;}
      
      public function containsItem(param1:InventoryItemInfo) : Boolean{return false;}
      
      public function getAllAccessory() : Array{return null;}
      
      override public function dispose() : void{}
   }
}
