package midAutumnWorshipTheMoon.view
{
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.utils.ItemCellEffectMngr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import midAutumnWorshipTheMoon.WorshipTheMoonManager;
   import midAutumnWorshipTheMoon.i.IWorshipTheMoonMainFrame;
   import midAutumnWorshipTheMoon.model.WorshipTheMoonAwardsBoxInfo;
   import midAutumnWorshipTheMoon.model.WorshipTheMoonModel;
   import road7th.utils.DateUtils;
   import shop.view.ShopItemCell;
   
   public class WorshipTheMoonMainFrame extends Frame implements Disposeable, IWorshipTheMoonMainFrame
   {
       
      
      private var _model:WorshipTheMoonModel;
      
      private var _bg:Bitmap;
      
      private var _animationWorshipTheMoon:MovieClip;
      
      private var _listShiningMoonList:Vector.<DisplayObject>;
      
      private var _buyOnceBtn:SimpleBitmapButton;
      
      private var _buyTenTimesBtn:SimpleBitmapButton;
      
      private var _timesRemainTitle:Bitmap;
      
      private var _timesRemainTxt:FilterFrameText;
      
      private var _listAwardsMaybeGain:Vector.<BagCell>;
      
      private var _coolShiningFor200TimesItem:MovieClip;
      
      private var _awardsAfter200times:ShopItemCell;
      
      private var _gained200:Bitmap;
      
      private var _tipClickToGain200:Bitmap;
      
      private var _timesUsed:FilterFrameText;
      
      private var _ruleDetails:FilterFrameText;
      
      private var _timesGoingToWorship:int = 0;
      
      private var _selectBtn:SelectedCheckButton;
      
      private var confirmFrame:BaseAlerFrame;
      
      public function WorshipTheMoonMainFrame(){super();}
      
      override protected function init() : void{}
      
      private function getDateToString(param1:String) : String{return null;}
      
      private function initEvents() : void{}
      
      protected function on200AwardsBoxClick(param1:MouseEvent) : void{}
      
      protected function onFrameClick(param1:MouseEvent) : void{}
      
      private function getPrice() : int{return 0;}
      
      public function showConfirmFrame(param1:int) : void{}
      
      private function __onClickSelectedBtn(param1:MouseEvent) : void{}
      
      private function comfirmHandler(param1:FrameEvent) : void{}
      
      private function reConfirmHandler(param1:FrameEvent) : void{}
      
      public function updateTimesRemains() : void{}
      
      public function updateUsedTimes() : void{}
      
      public function updateAwardItemsCanGainList() : void{}
      
      public function update200TimesGains() : void{}
      
      public function playTenTimesAnimation() : void{}
      
      protected function timeToLightAll(param1:Event) : void{}
      
      public function playOnceAnimation() : void{}
      
      protected function timeToLightTheMoon(param1:Event) : void{}
      
      private function disableBtns() : void{}
      
      private function showGainsAwardsAndresetBtns() : void{}
      
      private function resetBtns() : void{}
      
      private function showNotification() : void{}
      
      private function showGainsAwards() : void{}
      
      override public function dispose() : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function close() : void{}
      
      public function set model(param1:WorshipTheMoonModel) : void{}
   }
}
