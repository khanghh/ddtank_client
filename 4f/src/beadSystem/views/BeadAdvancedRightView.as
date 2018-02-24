package beadSystem.views
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import beadSystem.controls.BeadAdvanceCell;
   import beadSystem.controls.BeadCell;
   import beadSystem.model.AdvanceBeadInfo;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class BeadAdvancedRightView extends Sprite implements Disposeable
   {
      
      private static const CELL_NUM:int = 18;
       
      
      private var _info:AdvanceBeadInfo;
      
      private var _curTabIndex:int = -1;
      
      private var _panel:ScrollPanel;
      
      private var _skillSpri:Sprite;
      
      private var _beadExchangeBtn:SimpleBitmapButton;
      
      private var _beadCellArr:Array;
      
      private var _mainCell:BeadAdvanceInfoCell;
      
      private var _secondCell:BeadAdvanceInfoCell;
      
      private var _materialsDescTxt:FilterFrameText;
      
      private var _mainBeadDescTxt:FilterFrameText;
      
      private var _secondBeadDescTxt:FilterFrameText;
      
      private var _previewsTxt:FilterFrameText;
      
      private var _btnHelp:BaseButton;
      
      private var _lookBead:BagCell;
      
      private var _confirmFrame:BaseAlerFrame;
      
      private var _clickDate:Number = 0;
      
      public function BeadAdvancedRightView(){super();}
      
      private function createCells() : void{}
      
      private function createCell(param1:int) : BeadAdvanceCell{return null;}
      
      private function initEvent() : void{}
      
      private function cellInfoClickHandler(param1:InteractiveEvent) : void{}
      
      private function cellInfoRemoveHandler(param1:InteractiveEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function exchangeHandler(param1:MouseEvent) : void{}
      
      private function __confirm(param1:FrameEvent) : void{}
      
      private function exchange() : void{}
      
      public function update(param1:AdvanceBeadInfo, param2:int) : void{}
      
      public function refresh() : void{}
      
      private function clearAdvanceBeadInfoCell() : void{}
      
      public function get info() : AdvanceBeadInfo{return null;}
      
      private function clearBeadCellInfo() : void{}
      
      private function updateBeadDesc() : void{}
      
      protected function updateData() : void{}
      
      private function createBagCellInfo(param1:int) : InventoryItemInfo{return null;}
      
      private function beadCellClickHandler(param1:InteractiveEvent) : void{}
      
      public function dispose() : void{}
   }
}
