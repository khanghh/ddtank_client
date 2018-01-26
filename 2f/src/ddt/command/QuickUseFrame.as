package ddt.command
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class QuickUseFrame extends BaseAlerFrame
   {
       
      
      private var _itemId:int;
      
      private var _cellNum:int;
      
      private var _cell:BagCell;
      
      private var _textInfo:FilterFrameText;
      
      private var _numBg:Scale9CornerImage;
      
      private var _num:FilterFrameText;
      
      private var _maxBtn:SimpleBitmapButton;
      
      public function QuickUseFrame(){super();}
      
      private function initView() : void{}
      
      public function setItemInfo(param1:int, param2:int, param3:int, param4:int) : void{}
      
      private function updateItemCellCount(param1:int) : void{}
      
      private function initEvent() : void{}
      
      protected function __onMouseClick(param1:MouseEvent) : void{}
      
      protected function __onTextInput(param1:Event) : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
