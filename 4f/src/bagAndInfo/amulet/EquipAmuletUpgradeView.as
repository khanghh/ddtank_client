package bagAndInfo.amulet
{
   import bagAndInfo.amulet.vo.EquipAmuletVo;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class EquipAmuletUpgradeView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _upgradeBtn:SimpleBitmapButton;
      
      private var _promote:Bitmap;
      
      private var _maxLevel:Bitmap;
      
      private var _oldCell:BagCell;
      
      private var _newCell:BagCell;
      
      private var _oldLevelText:FilterFrameText;
      
      private var _oldHpText:FilterFrameText;
      
      private var _newLevelText:FilterFrameText;
      
      private var _newHpText:FilterFrameText;
      
      private var _upgradeTipText:FilterFrameText;
      
      private var _propCell:BagCell;
      
      private var _upgradeAllBtn:SelectedCheckButton;
      
      private var _currentTime:Number;
      
      private var _info:InventoryItemInfo;
      
      public function EquipAmuletUpgradeView(){super();}
      
      private function init() : void{}
      
      private function initCell() : void{}
      
      protected function __onClickUpgradeBtn(param1:MouseEvent) : void{}
      
      public function update(param1:Boolean = true) : void{}
      
      private function __onUpgradeComplete(param1:PkgEvent) : void{}
      
      private function __onAlertCompleteFrame(param1:FrameEvent) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function get stoneTemtID() : int{return 0;}
      
      public function dispose() : void{}
   }
}
