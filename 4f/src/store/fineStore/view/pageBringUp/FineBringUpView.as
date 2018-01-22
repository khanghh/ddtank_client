package store.fineStore.view.pageBringUp
{
   import bagAndInfo.bag.RichesButton;
   import bagAndInfo.cell.LockableBagCell;
   import baglocked.BaglockedManager;
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CEvent;
   import ddt.events.CellEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.OneLineTip;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import flash.utils.setTimeout;
   import latentEnergy.LatentEnergyEvent;
   import shop.view.BuyJewelryExperienceView;
   import store.FineBringUpController;
   import store.forge.ForgeRightBgView;
   import trainer.view.NewHandContainer;
   
   public class FineBringUpView extends Sprite implements Disposeable, IObserver
   {
      
      public static var isEatStatus:Boolean = false;
       
      
      private var _leftBg:MovieClip;
      
      private var _rightBgView:ForgeRightBgView;
      
      private var _bgCell:Bitmap;
      
      private var _upgrade:MovieClip;
      
      private var _eatExp:MovieClip;
      
      private var _bringUpItemCell:FineBringUpCell;
      
      private var _bagList:FineBringUpBagListView;
      
      private var _rightDrapSprite:FineBringUpRightDragSprite;
      
      private var _leftDrapSprite:FineBringUpLeftDragSprite;
      
      private var _buyExpBtn:SimpleBitmapButton;
      
      private var _bringUpEatAllBtn:SimpleBitmapButton;
      
      private var _bringUpEatBtn:SimpleBitmapButton;
      
      private var _bringUpLockBtn:SelectedButton;
      
      private var _mouseLockImg:Sprite;
      
      private var _mouseEatImg:Sprite;
      
      private var _helpBtn:BaseButton;
      
      private var _progress:MovieClip;
      
      private var _progressTips:OneLineTip;
      
      private var _progressTxt:FilterFrameText;
      
      private var _listData:BagInfo;
      
      private var _usingEatMouse:Boolean = false;
      
      private var _moneyBoard:Sprite;
      
      private var showMoneyBG:MutipleImage;
      
      private var moneyTxt:FilterFrameText;
      
      private var bindMoneyTxt:FilterFrameText;
      
      private var medelTxt:FilterFrameText;
      
      private var _moneyButton:RichesButton;
      
      private var _bindMoneyButton:RichesButton;
      
      private var _medelButton:RichesButton;
      
      private var _scrollPanel:ListPanel;
      
      private var _refreshTooFast:Boolean = false;
      
      public function FineBringUpView(){super();}
      
      public function update(param1:Object) : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __updateInventorySlot(param1:CEvent) : void{}
      
      protected function onProgressOut(param1:MouseEvent) : void{}
      
      protected function onProgressOver(param1:MouseEvent) : void{}
      
      public function __propertyChange(param1:PlayerPropertyEvent) : void{}
      
      private function updateMoney() : void{}
      
      protected function onBuyExpBtnClick(param1:MouseEvent) : void{}
      
      protected function onBringUpEatResult(param1:CEvent) : void{}
      
      protected function onEatBtnClick(param1:MouseEvent) : void{}
      
      private function eatStatusChange() : void{}
      
      protected function onEatMouseClick(param1:MouseEvent) : void{}
      
      private function onEatClick(param1:InventoryItemInfo) : void{}
      
      protected function onEatAllClick(param1:MouseEvent) : void{}
      
      private function onLockBtnClick(param1:MouseEvent) : void{}
      
      private function lockStatusChange() : void{}
      
      protected function onLockMouseClick(param1:MouseEvent) : void{}
      
      private function createAcceptDragSprite() : void{}
      
      public function refreshBagList() : void{}
      
      private function cellClickHandler(param1:CellEvent) : void{}
      
      protected function __cellDoubleClick(param1:CellEvent) : void{}
      
      private function equipChangeHandler(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}
