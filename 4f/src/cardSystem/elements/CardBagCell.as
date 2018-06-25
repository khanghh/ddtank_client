package cardSystem.elements{   import baglocked.BaglockedManager;   import cardSystem.CardControl;   import cardSystem.CardManager;   import cardSystem.data.CardInfo;   import cardSystem.data.GrooveInfo;   import com.greensock.TimelineMax;   import com.greensock.TweenLite;   import com.greensock.events.TweenEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class CardBagCell extends CardCell   {                   private var _upGradeBtn:BaseButton;            private var _buttonAndNumBG:Bitmap;            private var _count:FilterFrameText;            private var _timeLine:TimelineMax;            private var _isMouseOver:Boolean;            private var _tween0:TweenLite;            private var _tween1:TweenLite;            private var _tween2:TweenLite;            private var _tween3:TweenLite;            private var _mainCardBaiJin:Bitmap;            private var _mainCardJin:Bitmap;            private var _mainCardYin:Bitmap;            private var _mainCardTong:Bitmap;            private var _mainFont:Bitmap;            private var _deputy:Bitmap;            private var _collectCard:Boolean;            public function CardBagCell(bg:DisplayObject, place:int = -1, $info:CardInfo = null, showLoading:Boolean = false, showTip:Boolean = true) { super(null,null,null,null,null); }
            override protected function createChildren() : void { }
            override protected function onMouseOver(evt:MouseEvent) : void { }
            override protected function onMouseOut(evt:MouseEvent) : void { }
            private function __timelineComplete(event:TweenEvent = null) : void { }
            protected function __upGrade(event:MouseEvent) : void { }
            override public function set cardInfo(value:CardInfo) : void { }
            override public function get width() : Number { return 0; }
            override public function get height() : Number { return 0; }
            public function get collectCard() : Boolean { return false; }
            public function set collectCard(value:Boolean) : void { }
            override public function dispose() : void { }
            override protected function updateSize(sp:Sprite) : void { }
            override protected function createContentComplete() : void { }
            override public function set locked(value:Boolean) : void { }
   }}