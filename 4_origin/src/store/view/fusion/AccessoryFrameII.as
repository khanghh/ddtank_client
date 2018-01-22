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
      
      public function AccessoryFrameII()
      {
         super();
         initII();
      }
      
      private function initII() : void
      {
         titleText = LanguageMgr.GetTranslation("store.view.fusion.AccessoryFrame.add");
         _bg = new Shape();
         _bg.graphics.lineStyle(1,16777215);
         _bg.graphics.beginFill(7760227,1);
         _bg.graphics.drawRect(0,0,224,172);
         _bg.graphics.endFill();
         addToContent(_bg);
         _list = new SimpleTileList(3);
         addToContent(_list);
         _items = [];
         initList();
      }
      
      private function initList() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         clearList();
         _loc3_ = 5;
         while(_loc3_ < 11)
         {
            _loc2_ = ComponentFactory.Instance.creatBitmap("asset.ddtstore.FusionGoodsiBG");
            _loc1_ = new AccessoryItemCell(_loc3_);
            _loc1_.addEventListener("change",__itemInfoChange);
            _items.push(_loc1_);
            _list.addChild(_loc2_);
            _loc3_++;
         }
         _area = new AccessoryDragInArea(_items);
         _list.parent.addChildAt(_area,0);
      }
      
      private function __itemInfoChange(param1:Event) : void
      {
         dispatchEvent(new StoreIIEvent("itemclick"));
      }
      
      public function clearList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _list.disposeAllChildren();
         _loc2_ = 0;
         while(_loc2_ < _items.length)
         {
            _loc1_ = _items[_loc2_] as AccessoryItemCell;
            _loc1_.removeEventListener("change",__itemInfoChange);
            _loc1_.dispose();
            _loc2_++;
         }
         _items = [];
      }
      
      public function get isBinds() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _items.length)
         {
            if(_items[_loc1_] && _items[_loc1_].info && _items[_loc1_].info.IsBinds)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function setItemInfo(param1:int, param2:ItemTemplateInfo) : void
      {
         _items[param1 - 5].info = param2;
      }
      
      public function listEmpty() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _items.length)
         {
            _loc1_ = _items[_loc2_] as AccessoryItemCell;
            _loc2_++;
         }
      }
      
      public function show() : void
      {
      }
      
      public function hide() : void
      {
      }
      
      public function getCount() : Number
      {
         var _loc2_:int = 0;
         var _loc1_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < _items.length)
         {
            if(_items[_loc2_] != null && _items[_loc2_].info != null)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function containsItem(param1:InventoryItemInfo) : Boolean
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _items.length)
         {
            if(_items[_loc2_] != null && _items[_loc2_].itemInfo == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function getAllAccessory() : Array
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < _items.length)
         {
            if(_items[_loc3_] != null && _items[_loc3_].info != null)
            {
               _loc1_ = [];
               _loc1_.push(_items[_loc3_].info.BagType);
               _loc1_.push(_items[_loc3_].place);
               _loc2_.push(_loc1_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         clearList();
         if(_area)
         {
            ObjectUtils.disposeObject(_area);
         }
         _area = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
