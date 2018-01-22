package bagAndInfo.bag
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerDress.components.DressUtils;
   
   public class CellMenu extends Sprite
   {
      
      public static const ADDPRICE:String = "addprice";
      
      public static const MOVE:String = "move";
      
      public static const OPEN:String = "open";
      
      public static const USE:String = "use";
      
      public static const OPEN_BATCH:String = "open_batch";
      
      public static const COLOR_CHANGE:String = "color_change";
      
      public static const SELL:String = "delete";
      
      public static const RELIEVE:String = "relieve";
      
      private static var _instance:CellMenu;
       
      
      private var _bg:Bitmap;
      
      private var _bg2:Bitmap;
      
      private var _cell:BagCell;
      
      private var _addpriceitem:BaseButton;
      
      private var _moveitem:BaseButton;
      
      private var _openitem:BaseButton;
      
      private var _useitem:BaseButton;
      
      private var _openBatchItem:BaseButton;
      
      private var _colorChangeItem:BaseButton;
      
      private var _sellItem:BaseButton;
      
      private var _relieveBtm:BaseButton;
      
      private var _list:Sprite;
      
      public function CellMenu(param1:SingletonFoce)
      {
         super();
         init();
      }
      
      public static function get instance() : CellMenu
      {
         if(_instance == null)
         {
            _instance = new CellMenu(new SingletonFoce());
         }
         return _instance;
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("bagAndInfo.cellMenu.CellMenuBGAsset");
         _bg2 = ComponentFactory.Instance.creatBitmap("bagAndInfo.cellMenu.CellMenuBG2Asset");
         addChild(_bg);
         addChild(_bg2);
         _list = new Sprite();
         _list.x = 5;
         _list.y = 5;
         addChild(_list);
         graphics.beginFill(0,0);
         graphics.drawRect(-3000,-3000,6000,6000);
         graphics.endFill();
         addEventListener("click",__mouseClick);
         _addpriceitem = ComponentFactory.Instance.creatComponentByStylename("addPriceBtn");
         _moveitem = ComponentFactory.Instance.creatComponentByStylename("moveGoodsBtn");
         _openitem = ComponentFactory.Instance.creatComponentByStylename("openGoodsBtn");
         _useitem = ComponentFactory.Instance.creatComponentByStylename("useGoodsBtn");
         _openBatchItem = ComponentFactory.Instance.creatComponentByStylename("openBatchGoodsBtn");
         _colorChangeItem = ComponentFactory.Instance.creatComponentByStylename("colorChangeBtn");
         _sellItem = ComponentFactory.Instance.creatComponentByStylename("sellBtn");
         _moveitem.y = 27;
         _relieveBtm = ComponentFactory.Instance.creatComponentByStylename("relieveBtn");
         _addpriceitem.addEventListener("click",__addpriceClick);
         _moveitem.addEventListener("click",__moveClick);
         _openitem.addEventListener("click",__openClick);
         _useitem.addEventListener("click",__useClick);
         _openBatchItem.addEventListener("click",__openBatchClick);
         _colorChangeItem.addEventListener("click",__colorChangeClick);
         _sellItem.addEventListener("click",__sellClick);
         _relieveBtm.addEventListener("click",__relieveClick);
      }
      
      private function __relieveClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         SoundManager.instance.play("008");
         dispatchEvent(new Event("relieve"));
         hide();
      }
      
      public function set cell(param1:BagCell) : void
      {
         _cell = param1;
      }
      
      public function get cell() : BagCell
      {
         return _cell;
      }
      
      private function __mouseClick(param1:MouseEvent) : void
      {
         hide();
         SoundManager.instance.play("008");
      }
      
      private function __addpriceClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         SoundManager.instance.play("008");
         dispatchEvent(new Event("addprice"));
         hide();
      }
      
      private function __moveClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         SoundManager.instance.play("008");
         dispatchEvent(new Event("move"));
         hide();
      }
      
      private function __openClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         SoundManager.instance.play("008");
         dispatchEvent(new Event("open"));
         hide();
      }
      
      private function __useClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         SoundManager.instance.play("008");
         if(parent)
         {
            parent.removeChild(this);
         }
         dispatchEvent(new Event("use"));
         hide();
      }
      
      private function __openBatchClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         SoundManager.instance.play("008");
         if(parent)
         {
            parent.removeChild(this);
         }
         dispatchEvent(new Event("open_batch"));
         hide();
      }
      
      private function __colorChangeClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         SoundManager.instance.play("008");
         dispatchEvent(new Event("color_change"));
         hide();
      }
      
      private function __sellClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         SoundManager.instance.play("008");
         if(parent)
         {
            parent.removeChild(this);
         }
         dispatchEvent(new Event("delete"));
         hide();
      }
      
      public function show(param1:BagCell, param2:int, param3:int) : void
      {
         _cell = param1;
         if(_cell == null)
         {
            return;
         }
         var _loc4_:ItemTemplateInfo = _cell.info;
         if(_loc4_ == null)
         {
            return;
         }
         _bg.visible = true;
         _bg2.visible = false;
         _openitem.x = 0;
         _openitem.y = 0;
         _moveitem.x = 0;
         _moveitem.y = 27;
         if(DressUtils.isDress(_loc4_ as InventoryItemInfo))
         {
            if(InventoryItemInfo(_loc4_).getRemainDate() <= 0)
            {
               _list.addChild(_addpriceitem);
            }
            else
            {
               _list.addChild(_colorChangeItem);
            }
            _list.addChild(_sellItem);
            _colorChangeItem.y = -1;
            _sellItem.y = 28;
         }
         else if(_loc4_.CategoryID == 73)
         {
            if(param1.itemInfo.ItemID != PlayerManager.Instance.curcentId)
            {
               _list.addChild(_useitem);
               _useitem.x = -2;
               _useitem.y = -2;
            }
            else if(param1.itemInfo.getRemainDate() > 0)
            {
               _list.addChild(_relieveBtm);
               _relieveBtm.x = -2;
               _relieveBtm.y = -2;
            }
            else
            {
               _list.addChild(_useitem);
               _useitem.x = -2;
               _useitem.y = -2;
            }
            _sellItem.x = -2;
            _sellItem.y = 27;
            _list.addChild(_sellItem);
         }
         else
         {
            if(InventoryItemInfo(_loc4_).getRemainDate() <= 0)
            {
               _list.addChild(_addpriceitem);
            }
            else if(_loc4_.CategoryID == 43)
            {
               _list.addChild(_openitem);
               _openitem.x = -2;
               _openitem.y = -2;
               _moveitem.x = -2;
               _moveitem.y = 27;
            }
            else if(EquipType.isCardSoule(_loc4_) || EquipType.isPackage(_loc4_) || EquipType.isGetPackage(_loc4_) || EquipType.isFireworks(_loc4_))
            {
               _list.addChild(_openitem);
               if(EquipType.isCanBatchHandler(_loc4_ as InventoryItemInfo) || isCanBatch(_loc4_.TemplateID) || EquipType.isFireworks(_loc4_))
               {
                  _list.addChild(_openBatchItem);
                  _bg.visible = false;
                  _bg2.visible = true;
                  _openitem.x = -2;
                  _openitem.y = -2;
                  _openBatchItem.x = -2;
                  _openBatchItem.y = 27;
                  _moveitem.x = -2;
                  _moveitem.y = 56;
               }
            }
            else if(EquipType.isBatchOnlyDouble(_loc4_))
            {
               _list.addChild(_useitem);
               if(EquipType.isCanBatchHandler(_loc4_ as InventoryItemInfo))
               {
                  _list.addChild(_openBatchItem);
                  _bg.visible = false;
                  _bg2.visible = true;
                  _openitem.x = -2;
                  _openitem.y = -2;
                  _openBatchItem.x = -2;
                  _openBatchItem.y = 27;
                  _moveitem.x = -2;
                  _moveitem.y = 56;
               }
            }
            else if(EquipType.isPetEgg(_loc4_.CategoryID) || _loc4_.CategoryID == 68)
            {
               _list.addChild(_openitem);
            }
            else if(EquipType.canBeUsed(_loc4_))
            {
               _list.addChild(_useitem);
               if(EquipType.isOpenBatch(_loc4_) && EquipType.isCanBatchHandler(_loc4_ as InventoryItemInfo))
               {
                  _list.addChild(_openBatchItem);
                  _bg.visible = false;
                  _bg2.visible = true;
                  _useitem.x = -2;
                  _useitem.y = -2;
                  _openBatchItem.x = -2;
                  _openBatchItem.y = 27;
                  _moveitem.x = -2;
                  _moveitem.y = 56;
               }
            }
            _list.addChild(_moveitem);
         }
         LayerManager.Instance.addToLayer(this,2);
         this.x = param2;
         this.y = param3;
      }
      
      private function isCanBatch(param1:int) : Boolean
      {
         var _loc2_:int = 121999;
         var _loc3_:int = 129999;
         if(param1 > _loc2_ && param1 <= _loc3_)
         {
            return true;
         }
         return false;
      }
      
      public function hide() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
         while(_list.numChildren > 0)
         {
            _list.removeChildAt(0);
         }
         _cell = null;
      }
      
      public function get showed() : Boolean
      {
         return stage != null;
      }
   }
}

class SingletonFoce
{
    
   
   function SingletonFoce()
   {
      super();
   }
}
