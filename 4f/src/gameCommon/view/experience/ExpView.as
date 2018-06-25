package gameCommon.view.experience{   import com.greensock.TweenMax;   import com.greensock.easing.Quint;   import com.greensock.plugins.MotionBlurPlugin;   import com.greensock.plugins.TweenPlugin;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.SelfInfo;   import ddt.events.GameEvent;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Shape;   import flash.display.Sprite;   import flash.events.Event;   import flash.filters.BlurFilter;   import flash.utils.setTimeout;   import game.GameManager;   import gameCommon.GameControl;   import gameCommon.model.GameInfo;   import gameCommon.model.Living;   import gameCommon.model.Player;   import gameCommon.view.card.LargeCardsView;   import gameCommon.view.card.SmallCardsView;   import gameCommon.view.card.TakeOutCardController;   import room.RoomManager;      [Event(name="expshowed",type="ddt.events.GameEvent")]   public class ExpView extends Sprite implements Disposeable   {            public static const GAME_OVER_TYPE_0:uint = 0;            public static const GAME_OVER_TYPE_1:uint = 1;            public static const GAME_OVER_TYPE_2:uint = 2;            public static const GAME_OVER_TYPE_3:uint = 3;            public static const GAME_OVER_TYPE_4:uint = 4;            public static const GAME_OVER_TYPE_5:uint = 5;            public static const GAME_OVER_TYPE_6:uint = 6;                   private var _bg:Bitmap;            private var _leftView:ExpLeftView;            private var _rightView:Sprite;            private var _shape:Shape;            private var _resultSeal:ExpResultSeal;            private var _titleBitmap:Bitmap;            private var _fightView:ExpFightExpItem;            private var _attatchView:ExpAttatchExpItem;            private var _exploitView:ExpExploitItem;            private var _totalView:ExpTotalItem;            private var _cardController:TakeOutCardController;            private var _smallCardsView:SmallCardsView;            private var _largeCardsView:LargeCardsView;            private var _blurStep:int;            private var _blurFilter:BlurFilter;            private var _totalExploit:int;            private var _fightNums:Array;            private var _attatchNums:Array;            private var _exploitNums:Array;            private var _prestigeNums:Array;            private var _gameInfo:GameInfo;            private var _isOnlyLeftOut:Boolean;            private var _isNoCardView:Boolean;            private var _luckyExp:Boolean = false;            private var _luckyOffer:Boolean = false;            private var _expObj:Object;            private var _survivalBg:Bitmap;            private var _survivalArr:Vector.<ExpSurvivalItem>;            public function ExpView(bg:Bitmap = null) { super(); }
            public function show() : void { }
            private function creatExpSurvivalView() : void { }
            private function sortGameInfoByKillNum() : Array { return null; }
            private function validateData(arr:Array) : void { }
            private function fastComplete() : void { }
            private function changeDark() : void { }
            private function leftView() : void { }
            private function resultSealView() : void { }
            private function titleView() : void { }
            private function fightView() : void { }
            private function attatchView() : void { }
            private function exploitView() : void { }
            private function __updateTotalExp(event:Event) : void { }
            private function equalsZero(element:*, index:int, arr:Array) : Boolean { return false; }
            private function __updateTotalExploit(event:Event) : void { }
            public function close() : void { }
            public function showCard() : void { }
            private function onAllComplete() : void { }
            private function showSmallCardView(view:DisplayObject) : void { }
            private function showLargeCardView(view:DisplayObject) : void { }
            private function blurTween(e:Event = null) : void { }
            private function setDefyInfo() : void { }
            public function dispose() : void { }
   }}