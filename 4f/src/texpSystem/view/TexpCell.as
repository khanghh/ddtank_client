package texpSystem.view
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.ShineObject;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import texpSystem.data.TexpInfo;
   
   public class TexpCell extends BagCell
   {
       
      
      private var _texpInfo:TexpInfo;
      
      private var _shiner:ShineObject;
      
      private var _texpCountSelectFrame:TexpCountSelectFrame;
      
      public function TexpCell(){super(null,null,null,null);}
      
      override protected function initEvent() : void{}
      
      override protected function removeEvent() : void{}
      
      private function getNeedCount(param1:int) : int{return 0;}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      private function __ontexpCountResponse(param1:FrameEvent) : void{}
      
      override protected function createChildren() : void{}
      
      override protected function onMouseOver(param1:MouseEvent) : void{}
      
      override protected function onMouseOut(param1:MouseEvent) : void{}
      
      public function startShine() : void{}
      
      public function stopShine() : void{}
      
      private function __clickHandler(param1:InteractiveEvent) : void{}
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      override public function dispose() : void{}
      
      public function get texpInfo() : TexpInfo{return null;}
      
      public function set texpInfo(param1:TexpInfo) : void{}
   }
}
