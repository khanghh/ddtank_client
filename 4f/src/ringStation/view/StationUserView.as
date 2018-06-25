package ringStation.view{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PkgEvent;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.PositionUtils;   import ddt.view.character.CharactoryFactory;   import ddt.view.character.ICharacter;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.utils.Timer;   import ringStation.event.RingStationEvent;   import road7th.comm.PackageIn;      public class StationUserView extends Sprite   {                   private var _bg:Bitmap;            private var _userInfoBg:Bitmap;            private var _countDownBg:Bitmap;            private var _awardIcon:Bitmap;            private var _countDownSprite:Sprite;            private var _rankInfo:FilterFrameText;            private var _rankNum:FilterFrameText;            private var _challengeInfo:FilterFrameText;            private var _challengeTime:FilterFrameText;            private var _challengeTimeNum:FilterFrameText;            private var _rankAwardInfo:FilterFrameText;            private var _getAwardTimeInfo:FilterFrameText;            private var _getAwardTime:FilterFrameText;            private var _getAwardNum:FilterFrameText;            private var _champion:FilterFrameText;            private var _attestBtn:ScaleFrameImage;            private var _addChallengeBtn:BaseButton;            private var _fastForwardBtn:BaseButton;            private var _battleFieldsBtn:BaseButton;            private var _heroStandingsBtn:BaseButton;            private var _player:ICharacter;            private var _armoryView:ArmoryView;            private var _battleFieldsView:BattleFieldsView;            private var _rewardBtn:SimpleBitmapButton;            private var _buyCount:int;            private var _buyPrice:int;            private var _cdPrice:int;            private var _countDownTime:Number;            private var _timer:Timer;            private var _timeFlag:Boolean;            private var signBG:Bitmap;            private var signText:FilterFrameText;            private var signBnt:BaseButton;            private var signChampionText:FilterFrameText;            private var _signInputFrame:RingStationSingInputFrame;            public function StationUserView() { super(); }
            private function initView() : void { }
            private function addSignCell() : void { }
            private function initEvent() : void { }
            protected function __onGetReward(event:PkgEvent) : void { }
            protected function __onGetRewardClickHandle(event:MouseEvent) : void { }
            public function setReardEnable(flag:Boolean) : void { }
            private function __signClick(e:MouseEvent) : void { }
            private function __updateSign(e:RingStationEvent) : void { }
            public function setRankNum(num:int) : void { }
            public function setChampionText(name:String, isAttest:Boolean) : void { }
            public function setSignText(sign:String) : void { }
            public function setChallengeNum(num:int) : void { }
            public function setChallengeTime(date:Date) : void { }
            protected function __onTimer(event:TimerEvent) : void { }
            public function setAwardNum(num:int) : void { }
            public function setAwardTime(date:Date) : void { }
            protected function __onArmoryHandle(event:MouseEvent) : void { }
            protected function __onBattleFieldsHandle(event:MouseEvent) : void { }
            protected function __onBuyCount(event:MouseEvent) : void { }
            protected function __onBuyTime(event:MouseEvent) : void { }
            protected function __buyCountOrTime(event:PkgEvent) : void { }
            protected function __alertBuyCountOrTime(event:FrameEvent) : void { }
            private function onResponseHander(e:FrameEvent) : void { }
            private function _response(evt:FrameEvent) : void { }
            private function checkMoney(isBand:Boolean) : Boolean { return false; }
            private function transSecond(num:Number) : String { return null; }
            private function removeEvent() : void { }
            public function dispose() : void { }
            public function get buyCount() : int { return 0; }
            public function set buyCount(value:int) : void { }
            public function get buyPrice() : int { return 0; }
            public function set buyPrice(value:int) : void { }
            public function get cdPrice() : int { return 0; }
            public function set cdPrice(value:int) : void { }
   }}