package magicStone.components
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CellEvent;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MgStoneCell extends BagCell
   {
       
      
      private var _lockIcon:Bitmap;
      
      protected var _nameTxt:FilterFrameText;
      
      public function MgStoneCell(param1:int = 0, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null){super(null,null,null,null);}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      override protected function onMouseOver(param1:MouseEvent) : void{}
      
      override protected function onMouseClick(param1:MouseEvent) : void{}
      
      protected function onClick(param1:InteractiveEvent) : void{}
      
      protected function onDoubleClick(param1:InteractiveEvent) : void{}
      
      override public function dragStart() : void{}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      override public function dragStop(param1:DragEffect) : void{}
      
      private function dragHidePicTxt() : void{}
      
      private function dragShowPicTxt() : void{}
      
      public function lockMgStone() : void{}
      
      override public function set info(param1:ItemTemplateInfo) : void{}
      
      override protected function createLoading() : void{}
      
      override public function dispose() : void{}
   }
}
