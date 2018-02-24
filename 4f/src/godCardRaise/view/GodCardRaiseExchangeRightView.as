package godCardRaise.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import godCardRaise.GodCardRaiseManager;
   import godCardRaise.info.GodCardListGroupInfo;
   
   public class GodCardRaiseExchangeRightView extends Sprite implements Disposeable
   {
      
      private static var notAlertAgain:Boolean;
       
      
      private var _rightBg:Bitmap;
      
      private var _exchangeCellBg:Bitmap;
      
      private var _exchangeCell:BagCell;
      
      private var _exchangeBtn:BaseButton;
      
      private var _remainCountTxt:FilterFrameText;
      
      private var _cards:Sprite;
      
      private var _info:GodCardListGroupInfo;
      
      private var _canUseUniversalCard:Boolean;
      
      public function GodCardRaiseExchangeRightView(){super();}
      
      private function initView() : void{}
      
      public function changeView(param1:GodCardListGroupInfo) : void{}
      
      private function addCards() : void{}
      
      public function updateView() : void{}
      
      private function reset() : void{}
      
      private function initEvent() : void{}
      
      private function __exchangeBtnHandler(param1:MouseEvent) : void{}
      
      protected function __onSelectCheckClick(param1:MouseEvent) : void{}
      
      protected function __onAlertConfirm(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
