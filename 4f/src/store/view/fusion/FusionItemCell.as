package store.view.fusion
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.geom.Point;
   import store.StoreCell;
   import store.StrengthDataManager;
   import store.view.StoneCellFrame;
   
   public class FusionItemCell extends StoreCell
   {
      
      public static const SHINE_XY:int = 8;
      
      public static const SHINE_SIZE:int = 76;
       
      
      private var bg:Sprite;
      
      private var canMouseEvt:Boolean;
      
      private var _cellBg:StoneCellFrame;
      
      private var _autoSplit:Boolean;
      
      public function FusionItemCell(param1:int){super(null,null);}
      
      public function set bgVisible(param1:Boolean) : void{}
      
      override public function startShine() : void{}
      
      public function set mouseEvt(param1:Boolean) : void{}
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      override protected function __clickHandler(param1:InteractiveEvent) : void{}
      
      override public function dragStart() : void{}
      
      override public function dragStop(param1:DragEffect) : void{}
      
      override protected function updateSize(param1:Sprite) : void{}
      
      override protected function createChildren() : void{}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      private function _alerSell(param1:FusionSelectEvent) : void{}
      
      private function _alerNotSell(param1:FusionSelectEvent) : void{}
      
      override public function dispose() : void{}
   }
}
