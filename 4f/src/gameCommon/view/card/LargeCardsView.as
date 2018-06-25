package gameCommon.view.card{   import com.greensock.TweenLite;   import com.greensock.easing.Quint;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.events.Event;   import flash.geom.Point;   import flash.utils.clearInterval;   import flash.utils.setTimeout;   import gameCommon.model.Player;   import road7th.comm.PackageIn;   import room.RoomManager;      public class LargeCardsView extends SmallCardsView   {            public static const LARGE_CARD_TIME:uint = 15;            public static const LARGE_CARD_CNT:uint = 21;            public static const LARGE_CARD_COLUMNS:uint = 7;            public static const LARGE_CARD_VIEW_TIME:uint = 1;                   protected var _systemToken:Boolean;            private var _showCardInfos:Array;            protected var _instructionTxt:Bitmap;            private var _vipDiscountBg:Image;            private var _vipIcon:Image;            private var _vipDescTxt:FilterFrameText;            private var _isShowAllCard:Boolean = false;            protected var _cardGetNote:DisplayObject;            public function LargeCardsView() { super(); }
            override protected function init() : void { }
            protected function deleteVipInfo() : void { }
            private function drawCardGetNote() : void { }
            override protected function initEvent() : void { }
            override protected function __takeOut(e:CrazyTankSocketEvent) : void { }
            private function changeCardsToPayType() : void { }
            private function __showAllCard(e:CrazyTankSocketEvent) : void { }
            override protected function __timerForViewComplete(event:* = null) : void { }
            protected function showAllCard() : void { }
            override protected function createCards() : void { }
            override protected function startTween(e:Event = null) : void { }
            override protected function __countDownComplete(event:Event) : void { }
            private function timeOutHandler(event:Event) : void { }
            override public function dispose() : void { }
   }}