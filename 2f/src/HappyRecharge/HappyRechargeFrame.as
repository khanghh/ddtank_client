package HappyRecharge
{
   import bagAndInfo.cell.BagCell;
   import com.greensock.TweenLite;
   import com.greensock.easing.Linear;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.roulette.TurnSoundControl;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import invite.InviteManager;
   
   public class HappyRechargeFrame extends Frame implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _helpFrame:Frame;
      
      private var _bgHelp:Scale9CornerImage;
      
      private var _content:FilterFrameText;
      
      private var _btnOk:TextButton;
      
      private var _prizeArr:Array;
      
      private var _lotteryCountArr:Array;
      
      private var _prizeCountArr:Array;
      
      private var _prizeCell:BagCell;
      
      private var _startBtn:SimpleBitmapButton;
      
      private var _startAllBtn:SimpleBitmapButton;
      
      private var _stopAutoBtn:SimpleBitmapButton;
      
      private var _haloMc:MovieClip;
      
      private var _pointerMc:MovieClip;
      
      private var _bottomBack:MovieClip;
      
      private var _cellShine:MovieClip;
      
      private var _shineObject:Component;
      
      private var _bigYellowCircle:Bitmap;
      
      private var _smallCircleBack:Bitmap;
      
      private var _recordContents:VBox;
      
      private var _recordPanel:ScrollPanel;
      
      private var _exchangeContents:VBox;
      
      private var _exchangePanel:ScrollPanel;
      
      private var _activityData:FilterFrameText;
      
      private var _rotationArr:Array;
      
      private var _currentRotation:int;
      
      private var _frameIndex:int;
      
      private var _cellShineIndex:int;
      
      private var _sound:TurnSoundControl;
      
      public function HappyRechargeFrame(){super();}
      
      public function updateView(param1:HappyRechargeRecordItem = null) : void{}
      
      public function startTurn(param1:int = 6) : void{}
      
      private function __startroll(param1:Event) : void{}
      
      public function autoStartTuren(param1:int) : void{}
      
      private function _stopRoll() : void{}
      
      private function _showHaloMc() : void{}
      
      private function _hideHaloMc() : void{}
      
      private function _createCellShine() : void{}
      
      private function _removeCellShine() : void{}
      
      private function __cellShineHandler(param1:Event) : void{}
      
      private function _cellShineScale() : void{}
      
      private function _cellFlyToBag() : void{}
      
      private function _cellFlyToBagComplete() : void{}
      
      private function _initView() : void{}
      
      private function _initEvent() : void{}
      
      private function updateState(param1:int = 0) : void{}
      
      private function __onClickStopAuto(param1:MouseEvent) : void{}
      
      private function __onClickStartAll(param1:MouseEvent) : void{}
      
      private function ___startBtnHandler(param1:MouseEvent) : void{}
      
      public function startTrun() : void{}
      
      private function _removeEvent() : void{}
      
      private function refreshLotteryCount() : void{}
      
      private function refreshPrizeCount() : void{}
      
      private function setPrizeCell() : void{}
      
      private function setPrizeAreaCell() : void{}
      
      private function createExchangeView() : void{}
      
      private function createRecord() : void{}
      
      private function createPrizeAreaCellInfoForTest() : Array{return null;}
      
      private function createExchangeItems() : Array{return null;}
      
      private function createTestRecordData() : Array{return null;}
      
      private function __response(param1:FrameEvent) : void{}
      
      private function __helpBtnHandler(param1:MouseEvent) : void{}
      
      private function __helpFrameRespose(param1:FrameEvent) : void{}
      
      private function __closeHelpFrame(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
