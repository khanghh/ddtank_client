package chickActivation.view
{
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import battleGroud.BattleGroudControl;
   import chickActivation.ChickActivationManager;
   import chickActivation.data.ChickActivationInfo;
   import chickActivation.event.ChickActivationEvent;
   import chickActivation.model.ChickActivationModel;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.DropGoodsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import shop.view.ShopPlayerCell;
   
   public class ChickActivationViewFrame extends Frame
   {
       
      
      private var _mainBg:Bitmap;
      
      private var _mainTitle:Bitmap;
      
      private var _helpTitle:Bitmap;
      
      private var _helpPanel:ScrollPanel;
      
      private var _helpTxt:FilterFrameText;
      
      private var _remainingTimeTxt:FilterFrameText;
      
      private var _group:SelectedButtonGroup;
      
      private var _selectBtn1:SelectedTextButton;
      
      private var _selectBtn2:SelectedTextButton;
      
      private var _groupTwo:SelectedButtonGroup;
      
      private var _selectEveryDay:SelectedButton;
      
      private var _selectWeekly:SelectedButton;
      
      private var _selectAfterThreeDays:SelectedButton;
      
      private var _selectLevelPacks:SelectedButton;
      
      private var _promptMovies:Array;
      
      private var _priceBitmap:Bitmap;
      
      private var _priceView:ChickActivationCoinsView;
      
      private var _moneyIcon:Bitmap;
      
      private var _lineBitmap1:Bitmap;
      
      private var _inputBg:Bitmap;
      
      private var _inputTxt:FilterFrameText;
      
      private var _activationBtn:BaseButton;
      
      private var _lineBitmap2:Bitmap;
      
      private var _receiveBtn:BaseButton;
      
      private var _levelPacks:ChickActivationLevelPacks;
      
      private var _ativationItems:ChickActivationItems;
      
      private var _clickRate:Number = 0;
      
      private var CHICKACTIVATION_CARDID:int = 201316;
      
      private var buyItemInfo:ShopItemInfo;
      
      public function ChickActivationViewFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __updateDataHandler(param1:ChickActivationEvent) : void{}
      
      private function updateView() : void{}
      
      private function updateShine() : void{}
      
      private function updateGetBtn() : void{}
      
      private function getNowGainArrIndex() : int{return 0;}
      
      private function __getRewardHandler(param1:ChickActivationEvent) : void{}
      
      private function __selectBtnHandler(param1:Event) : void{}
      
      private function __selectBtnTwoHandler(param1:Event) : void{}
      
      private function tabHandler() : void{}
      
      private function updatePriceView() : void{}
      
      private function findDataUpdateActivationItems() : void{}
      
      private function showBottomPriceAndButton(param1:Boolean) : void{}
      
      private function showBottomActivationButton() : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function __inputTxtHandler(param1:MouseEvent) : void{}
      
      private function __activationBtnHandler(param1:MouseEvent) : void{}
      
      private function showBuyFrame() : void{}
      
      private function __buyFrameResponse(param1:FrameEvent) : void{}
      
      public function clickRateGo() : Boolean{return false;}
      
      private function __receiveBtnHandler(param1:MouseEvent) : void{}
      
      private function playDropGoodsMovie(param1:Array) : void{}
      
      private function getQualityKey() : String{return null;}
      
      private function __clickLevelPacksHandler(param1:ChickActivationEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
