package rescue.views
{
   import baglocked.BaglockedManager;
   import catchInsect.data.RescueSceneInfo;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import gameCommon.GameControl;
   import rescue.RescueControl;
   import rescue.RescueManager;
   import rescue.components.RescuePrizeItem;
   import rescue.components.RescueSceneItem;
   import rescue.components.RescueShopItem;
   import rescue.data.RescueRewardInfo;
   import road7th.comm.PackageIn;
   
   public class RescueMainFrame extends Frame
   {
      
      private static const NUM:int = 3;
       
      
      private var _bg:Bitmap;
      
      private var _sceneArr:Vector.<RescueSceneItem>;
      
      private var _tileList:SimpleTileList;
      
      private var _txtImg:Bitmap;
      
      private var _arrowTxt:FilterFrameText;
      
      private var _bloodPackTxt:FilterFrameText;
      
      private var _kingBlessTxt:FilterFrameText;
      
      private var _shopVBox:VBox;
      
      private var _prizeHBox:HBox;
      
      private var _prizeArr:Vector.<RescuePrizeItem>;
      
      private var _challengeBtn:SimpleBitmapButton;
      
      private var _CDTimeBg:ScaleBitmapImage;
      
      private var _CDTimeTxt:FilterFrameText;
      
      private var _accelerateBtn:SimpleBitmapButton;
      
      private var _countTxt:FilterFrameText;
      
      private var _help:BaseButton;
      
      private var _remainSecond:int;
      
      private var _curIndex:int;
      
      private var _cleanCDcount:int;
      
      private var _CDTimer:Timer;
      
      private var _infoDic:Dictionary;
      
      private var _curPage:int;
      
      private var _totalPage:int;
      
      private var _prevBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageBg:Scale9CornerImage;
      
      private var _pageTxt:FilterFrameText;
      
      public function RescueMainFrame(){super();}
      
      private function initData() : void{}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      protected function __prevBtnClick(param1:MouseEvent) : void{}
      
      protected function __nextBtnClick(param1:MouseEvent) : void{}
      
      private function __startLoading(param1:Event) : void{}
      
      protected function __updateItem(param1:PkgEvent) : void{}
      
      protected function __buyItem(param1:PkgEvent) : void{}
      
      protected function __cleanCD(param1:PkgEvent) : void{}
      
      protected function __accelerateBtnClick(param1:MouseEvent) : void{}
      
      private function comfirmHandler(param1:FrameEvent) : void{}
      
      private function reConfirmHandler(param1:FrameEvent) : void{}
      
      private function getNeedMoney() : int{return 0;}
      
      protected function __challengeBtnClick(param1:MouseEvent) : void{}
      
      protected function __updateView(param1:PkgEvent) : void{}
      
      private function getTotalPage() : int{return 0;}
      
      private function pageChange() : void{}
      
      private function updateSceneItem(param1:int, param2:RescueSceneInfo) : void{}
      
      protected function __onCDTimer(param1:TimerEvent) : void{}
      
      private function parseDate(param1:int) : String{return null;}
      
      protected function __itemClick(param1:MouseEvent) : void{}
      
      private function updatePrize() : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      private function removeEvents() : void{}
      
      override public function dispose() : void{}
   }
}
