package treasureHunting.views
{
   import bagAndInfo.cell.BaseCell;
   import baglocked.BaglockedManager;
   import com.greensock.TimelineLite;
   import com.greensock.TweenLite;
   import com.greensock.TweenProxy;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.RouletteManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.caddyII.CaddyEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   import treasureHunting.TreasureControl;
   import treasureHunting.TreasureManager;
   import treasureHunting.event.TreasureEvent;
   import treasureHunting.items.TreasureItem;
   
   public class TreasureHuntingFrame extends Frame
   {
      
      private static const RESTRICT:String = "0-9";
      
      private static const DEFAULT:String = "1";
      
      private static const LENGTH:int = 16;
      
      private static const NUMBER:int = 4;
       
      
      private var _content:Sprite;
      
      private var _bg:ScaleBitmapImage;
      
      private var _treasureTitle:ScaleBitmapImage;
      
      private var _itemList:SimpleTileList;
      
      private var _itemArr:Vector.<TreasureItem>;
      
      private var _timesTxt:FilterFrameText;
      
      private var _timesInput:FilterFrameText;
      
      private var _timesInputBg:Scale9CornerImage;
      
      private var _showPrizeBtn:BaseButton;
      
      private var _rankPrizeBtn:SimpleBitmapButton;
      
      private var _huntingBtn:BaseButton;
      
      private var _maxBtn:BaseButton;
      
      private var _glint:MovieClip;
      
      private var _myNumberTxt:FilterFrameText;
      
      private var _bagBtn:SimpleBitmapButton;
      
      private var _rankBtn:SimpleBitmapButton;
      
      private var _recordBtn:SimpleBitmapButton;
      
      private var _exchangeBtn:TextButton;
      
      private var _luckyStoneBG:Bitmap;
      
      private var _pointTxt:FilterFrameText;
      
      private var _bagView:TreasureBagView;
      
      private var _rankView:TreasureRankView;
      
      private var _recordView:TreasureRecordView;
      
      private var _glintTimer:Timer;
      
      private var _rankTimer:Timer;
      
      private var _ran:int;
      
      private var _unitPrice:int;
      
      private var totalScore:int = 0;
      
      private var _btnHelp:BaseButton;
      
      private var moveCell:BaseCell;
      
      private var luckStoneCell:BaseCell;
      
      public function TreasureHuntingFrame(){super();}
      
      private function initData() : void{}
      
      protected function updateRank(param1:TimerEvent) : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __getConverteds(param1:PkgEvent) : void{}
      
      private function _responseII(param1:FrameEvent) : void{}
      
      protected function onExchangeBtnClick(param1:MouseEvent) : void{}
      
      private function _responseIII(param1:FrameEvent) : void{}
      
      private function __getRemainScore(param1:PkgEvent) : void{}
      
      protected function onRankBtnClick(param1:MouseEvent) : void{}
      
      protected function onBagBtnClick(param1:MouseEvent) : void{}
      
      protected function onRecordBtnClick(param1:MouseEvent) : void{}
      
      private function onShowPrizeBtnClick(param1:MouseEvent) : void{}
      
      private function onRankPrizeBtnClick(param1:MouseEvent) : void{}
      
      private function _change(param1:Event) : void{}
      
      private function onHuntingBtnClick(param1:MouseEvent) : void{}
      
      private function showTransactionFrame() : void{}
      
      protected function __onSelectCheckClick(param1:MouseEvent) : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      private function onMaxBtnClick(param1:MouseEvent) : void{}
      
      private function payForHunting(param1:Boolean) : void{}
      
      private function onTimer(param1:TimerEvent) : void{}
      
      private function removeAllItemLight() : void{}
      
      private function onTimerComplete(param1:TimerEvent) : void{}
      
      public function creatMoveCell(param1:int) : void{}
      
      private function onEnterFrame(param1:Event) : void{}
      
      private function addMoveEffect(param1:DisplayObject, param2:int, param3:int) : void{}
      
      private function twComplete(param1:TimelineLite, param2:TweenProxy, param3:Bitmap) : void{}
      
      private function movieComplete() : void{}
      
      public function startTimer() : void{}
      
      public function lightUpItemArr() : void{}
      
      protected function _response(param1:FrameEvent) : void{}
      
      private function onAlertResponse(param1:FrameEvent) : void{}
      
      private function __updateLastTime(param1:CaddyEvent) : void{}
      
      private function __changeBadLuckNumber(param1:PlayerPropertyEvent) : void{}
      
      protected function __updateInfo(param1:PkgEvent) : void{}
      
      private function removeEvents() : void{}
      
      override public function dispose() : void{}
      
      public function get huntingBtn() : BaseButton{return null;}
      
      public function get bagView() : TreasureBagView{return null;}
   }
}
