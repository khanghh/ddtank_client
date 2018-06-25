package magpieBridge.view{   import bagAndInfo.cell.BagCell;   import baglocked.BaglockedManager;   import com.greensock.TweenLite;   import com.greensock.TweenMax;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.PkgEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.states.BaseStateView;   import ddt.utils.PositionUtils;   import ddt.view.BuriedBox;   import ddt.view.DiceRoll;   import ddt.view.SimpleReturnBar;   import ddt.view.sceneCharacter.SceneCharacterDirection;   import ddtBuried.BuriedManager;   import ddtBuried.event.BuriedEvent;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.events.MouseEvent;   import flash.geom.Point;   import magpieBridge.MagpieBridgeManager;   import magpieBridge.event.MagpieBridgeEvent;   import road7th.comm.PackageIn;      public class MagPieBridgeView extends BaseStateView implements Disposeable   {                   private var _playerPosArray:Array;            private var _diceArray:Array;            private var _bg:Bitmap;            private var _returnBtn:SimpleReturnBar;            private var _magpieView:MagpieView;            private var _helpBtn:BaseButton;            private var _controlBg:Bitmap;            private var _diceRoll:DiceRoll;            private var _duckBtn:BaseButton;            private var _lastNum:FilterFrameText;            private var _buyCountBtn:SimpleBitmapButton;            private var _magpieMap:MagpieBridgeMap;            private var _selfPlayer:MagpiePlayer;            private var _walkArray:Array;            private var _magpiePos:int;            private var _addMagpie0:MovieClip;            private var _addMagpie1:MovieClip;            private var _awardCell:BagCell;            private var _awardBox:BuriedBox;            private var _desPos:int;            private var _closeIconFlag:Boolean;            private var _getAwardFlag:Boolean;            private var _addMagpieFlag:Boolean;            private var _stepFlag:Boolean;            private var _addCountFlag:Boolean;            private var _magpieEndNum:int;            private var _endFlag:Boolean;            public function MagPieBridgeView() { super(); }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            private function initView() : void { }
            private function initEvent() : void { }
            private function exitHandler() : void { }
            protected function __onHelpBtnClick(event:MouseEvent) : void { }
            private function frameEvent(event:FrameEvent) : void { }
            override public function refresh() : void { }
            protected function __onMagpieNum(event:PkgEvent) : void { }
            private function addMagpie() : void { }
            private function playMagpieAnimation() : void { }
            private function setMagpieNum() : void { }
            protected function __onGetAward(event:PkgEvent) : void { }
            private function flyGoods() : void { }
            private function complete() : void { }
            protected function __onUpdatePlayerPos(event:PkgEvent) : void { }
            protected function __onWalkOver(event:MagpieBridgeEvent) : void { }
            private function showPromptInfo(offPos:int) : void { }
            private function __onBoxMovieOver(event:BuriedEvent) : void { }
            private function onMapOverResponse(e:FrameEvent) : void { }
            protected function __onCloseIcon(event:PkgEvent) : void { }
            protected function __onBuyCountClick(event:MouseEvent) : void { }
            protected function __onBuyCount(event:PkgEvent) : void { }
            protected function __onSetCount(event:PkgEvent) : void { }
            protected function __onSetBtnEnable(event:MagpieBridgeEvent) : void { }
            private function setBtnEnable(flag:Boolean) : void { }
            protected function __onDuckClick(event:MouseEvent) : void { }
            protected function __onRollDice(event:PkgEvent) : void { }
            protected function __onDiceOver(event:BuriedEvent) : void { }
            private function setPlayerWalk(desNum:int) : void { }
            private function roleCallback(role:MagpiePlayer, isLoadSucceed:Boolean, vFlag:int) : void { }
            override public function getType() : String { return null; }
            override public function getBackType() : String { return null; }
            private function removeEvent() : void { }
            override public function leaving(next:BaseStateView) : void { }
   }}