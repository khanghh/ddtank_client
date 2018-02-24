package carnivalActivity.view
{
   import baglocked.BaglockedManager;
   import beadSystem.model.BeadInfo;
   import carnivalActivity.CarnivalActivityControl;
   import carnivalActivity.view.activityItem.ActivationPotentialItem;
   import carnivalActivity.view.activityItem.BuildUpgradeItem;
   import carnivalActivity.view.activityItem.PetUpgradeItem;
   import carnivalActivity.view.activityItem.PlayerRegisterRwardItem;
   import carnivalActivity.view.activityItem.TurnRoundEggItem;
   import carnivalActivity.view.activityItem.UsePropsItem;
   import carnivalActivity.view.activityItem.UseUpEnergyItem;
   import carnivalActivity.view.activityItem.WashPointCardItem;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.QualityType;
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PetInfoManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import pet.data.PetTemplateInfo;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftCurInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.GmActivityInfo;
   import wonderfulActivity.data.SendGiftInfo;
   import wonderfulActivity.views.IRightView;
   
   public class CarnivalActivityView extends Sprite implements IRightView
   {
       
      
      protected var _bg:Bitmap;
      
      private var _titleBg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _closeTimeTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _timer:TimerJuggler;
      
      private var _sumTime:Number = 0;
      
      private var _sumTimeStr:String;
      
      private var _actTxt:FilterFrameText;
      
      private var _actTimeTxt:FilterFrameText;
      
      private var _getTxt:FilterFrameText;
      
      private var _getTimeTxt:FilterFrameText;
      
      private var _descSp:Sprite;
      
      private var _descTxt:FilterFrameText;
      
      private var _allDescBg:ScaleBitmapImage;
      
      private var _allDescTxt:FilterFrameText;
      
      private var _buyBg:Bitmap;
      
      private var _priceTxt:FilterFrameText;
      
      private var _buyCountTxt:FilterFrameText;
      
      private var _dailyBuyBg:Bitmap;
      
      private var _buyBtn:TextButton;
      
      private var _gift:CarnivalActivityGift;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _type:int;
      
      private var _childType:int;
      
      private var _id:String;
      
      private var _item:GmActivityInfo;
      
      private var _buyGiftItem:GmActivityInfo;
      
      private var _buyGiftCurInfo:GiftCurInfo;
      
      private var _buyCount:int;
      
      private var _hasBuyGift:Boolean = false;
      
      private var _buyGiftLimitType:int;
      
      private var _buyGiftLimitCount:int;
      
      private var _buyGiftType:int;
      
      private var _buyGiftPrice:int;
      
      private var _buyGiftActId:String = "";
      
      private var _giftInfoVec:Vector.<GiftBagInfo>;
      
      private var _infoVec:Vector.<GmActivityInfo>;
      
      private var _itemVec:Vector.<CarnivalActivityItem>;
      
      private var _rookieRankView:RookieRankTipView;
      
      private var _rookieRankIcon:Bitmap;
      
      public function CarnivalActivityView(param1:int, param2:int = 0, param3:String = ""){super();}
      
      public function init() : void{}
      
      private function initData() : void{}
      
      private function initItem(param1:GmActivityInfo) : void{}
      
      private function updateTime() : void{}
      
      protected function __timerHandler(param1:Event) : void{}
      
      protected function initView() : void{}
      
      public function updateView() : void{}
      
      private function initEvent() : void{}
      
      protected function __showRookieTip(param1:MouseEvent) : void{}
      
      protected function __hideRookieTip(param1:MouseEvent) : void{}
      
      protected function __outHandler(param1:MouseEvent) : void{}
      
      protected function __overHandler(param1:MouseEvent) : void{}
      
      protected function __buyGiftPackHandler(param1:MouseEvent) : void{}
      
      protected function buyGift(param1:Boolean) : void{}
      
      protected function __alertBuyGift(param1:FrameEvent) : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function onResponseHander(param1:FrameEvent) : void{}
      
      private function checkMoney(param1:Boolean) : Boolean{return false;}
      
      private function removeEvent() : void{}
      
      public function content() : Sprite{return null;}
      
      public function setState(param1:int, param2:int) : void{}
      
      public function updateAwardState() : void{}
      
      public function dispose() : void{}
   }
}
