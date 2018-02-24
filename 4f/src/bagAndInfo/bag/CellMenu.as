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
      
      public function CellMenu(param1:SingletonFoce){super();}
      
      public static function get instance() : CellMenu{return null;}
      
      private function init() : void{}
      
      private function __relieveClick(param1:MouseEvent) : void{}
      
      public function set cell(param1:BagCell) : void{}
      
      public function get cell() : BagCell{return null;}
      
      private function __mouseClick(param1:MouseEvent) : void{}
      
      private function __addpriceClick(param1:MouseEvent) : void{}
      
      private function __moveClick(param1:MouseEvent) : void{}
      
      private function __openClick(param1:MouseEvent) : void{}
      
      private function __useClick(param1:MouseEvent) : void{}
      
      private function __openBatchClick(param1:MouseEvent) : void{}
      
      private function __colorChangeClick(param1:MouseEvent) : void{}
      
      private function __sellClick(param1:MouseEvent) : void{}
      
      public function show(param1:BagCell, param2:int, param3:int) : void{}
      
      private function isCanBatch(param1:int) : Boolean{return false;}
      
      public function hide() : void{}
      
      public function get showed() : Boolean{return false;}
   }
}

class SingletonFoce
{
    
   
   function SingletonFoce(){super();}
}
