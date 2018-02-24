package magicHouse.magicCollection
{
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import magicHouse.MagicHouseModel;
   import magicHouse.MagicHouseTipFrame;
   import shop.view.ShopItemCell;
   
   public class MagicHouseItemCell extends Sprite implements Disposeable
   {
       
      
      private var _type:int;
      
      private var _pos:int;
      
      private var _isOpen:Boolean = false;
      
      private var _info:ItemTemplateInfo;
      
      private var _cell:ShopItemCell;
      
      private var _openBtn:SimpleBitmapButton;
      
      private var _openEnable:Boolean;
      
      private var _frame:MagicHouseTipFrame;
      
      private var _alphaCell:Sprite;
      
      private var _itemContent:Component;
      
      public function MagicHouseItemCell(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __openItem(param1:MouseEvent) : void{}
      
      private function __okBtnHandler(param1:MouseEvent) : void{}
      
      private function __cancelBtnHandler(param1:MouseEvent) : void{}
      
      private function __confirmResponse(param1:FrameEvent) : void{}
      
      public function setFilter() : void{}
      
      public function setOpened(param1:Boolean) : void{}
      
      public function set cellInfo(param1:ItemTemplateInfo) : void{}
      
      public function setTypeAndPos(param1:int, param2:int) : void{}
      
      public function get isOpen() : Boolean{return false;}
      
      private function createItemCell() : ShopItemCell{return null;}
      
      public function dispose() : void{}
   }
}
