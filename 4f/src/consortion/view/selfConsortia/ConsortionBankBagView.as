package consortion.view.selfConsortia
{
   import bagAndInfo.bag.BagView;
   import bagAndInfo.bag.CellMenu;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.data.BagInfo;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.CellEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import magicHouse.MagicHouseManager;
   import magicHouse.MagicHouseModel;
   import playerDress.PlayerDressManager;
   import playerDress.components.DressUtils;
   import playerDress.data.DressVo;
   
   public class ConsortionBankBagView extends BagView
   {
      
      private static var LIST_WIDTH:int = 330;
      
      private static var LIST_HEIGHT:int = 320;
       
      
      private var _bank:ConsortionBankListView;
      
      private var _titleText2:FilterFrameText;
      
      private var _changeToConsortion:SimpleBitmapButton;
      
      private const MAX_HEIGHT:int = 455;
      
      public function ConsortionBankBagView(){super();}
      
      override protected function init() : void{}
      
      private function setInit() : void{}
      
      override public function setBagType(param1:int) : void{}
      
      override protected function set_breakBtn_enable() : void{}
      
      override protected function initEvent() : void{}
      
      override protected function removeEvents() : void{}
      
      override protected function initBackGround() : void{}
      
      override protected function __listChange(param1:Event) : void{}
      
      override protected function __cellDoubleClick(param1:CellEvent) : void{}
      
      private function __jumpToMagicHouse(param1:MouseEvent) : void{}
      
      private function __bankCellClick(param1:CellEvent) : void{}
      
      private function __bankCellDoubleClick(param1:CellEvent) : void{}
      
      private function getItemBagType(param1:InventoryItemInfo) : int{return 0;}
      
      private function __upConsortiaStroeLevel(param1:PlayerPropertyEvent) : void{}
      
      private function __addToStageHandler(param1:Event) : void{}
      
      public function setData(param1:SelfInfo) : void{}
      
      override protected function __cellClick(param1:CellEvent) : void{}
      
      override protected function __cellMove(param1:Event) : void{}
      
      private function checkDressSaved(param1:InventoryItemInfo) : Boolean{return false;}
      
      override protected function __sortBagClick(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
