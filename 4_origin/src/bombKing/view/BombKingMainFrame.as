package bombKing.view
{
   import bombKing.BombKingControl;
   import bombKing.BombKingManager;
   import bombKing.components.BKingLine;
   import bombKing.components.BKingPlayerItem;
   import bombKing.components.BKingPlayerTip;
   import bombKing.components.BKingbattleLogItem;
   import bombKing.data.BKingLogInfo;
   import bombKing.data.BKingPlayerInfo;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ShowCharacter;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import gameCommon.GameControl;
   import road7th.comm.PackageIn;
   
   public class BombKingMainFrame extends Frame
   {
      
      private static var HeadWidth:int = 120;
      
      private static var HeadHeight:int = 120;
       
      
      private var _bg:Bitmap;
      
      private var _startBtn:SimpleBitmapButton;
      
      private var _timeTxt:FilterFrameText;
      
      private var _rankBtn:SimpleBitmapButton;
      
      private var _rankTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _prizeBtn:SimpleBitmapButton;
      
      private var _ruleBtn:SimpleBitmapButton;
      
      private var _purpleIcon:Bitmap;
      
      private var _redIcon:Bitmap;
      
      private var _blueIcon:Bitmap;
      
      private var _firstName:FilterFrameText;
      
      private var _secondName:FilterFrameText;
      
      private var _thirdName:FilterFrameText;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _logVBox:VBox;
      
      private var _battleSoon:Bitmap;
      
      private var _remain:FilterFrameText;
      
      private var _firstStageInPlay:Bitmap;
      
      private var _secondStageInPlay:Bitmap;
      
      private var _finalStageInPlay:Bitmap;
      
      private var _rankFrame:BombKingRankFrame;
      
      private var _prizeFrame:BombKingPrizeFrame;
      
      private var _playerTips:BKingPlayerTip;
      
      private var _itemArr:Array;
      
      private var _lineArr:Array;
      
      private var _stampArr:Array;
      
      private var _itemDic:Dictionary;
      
      private var _lineDic:Dictionary;
      
      private var _rankDic:Dictionary;
      
      private var _top3InfoArr:Array;
      
      private var _top3NameArr:Array;
      
      private var _logArr:Array;
      
      private var _headImgArr:Array;
      
      private var _loaderArr:Array;
      
      private var _battleStage:int;
      
      private var _turn:int;
      
      private var _status:int;
      
      private var _battleEndDate:Date;
      
      private var _tipSprite:Component;
      
      private var nextTimer:Timer;
      
      private var remainTimer:Timer;
      
      public function BombKingMainFrame()
      {
         super();
         initData();
         initView();
         initEvents();
         SocketManager.Instance.out.updateBombKingMainFrame();
         SocketManager.Instance.out.updateBombKingBattleLog();
      }
      
      private function initData() : void
      {
         _itemArr = [];
         _lineArr = [];
         _itemDic = new Dictionary();
         _lineDic = new Dictionary();
         _stampArr = [];
         _headImgArr = [];
         SocketManager.Instance.out.sendUpdateSysDate();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         titleText = LanguageMgr.GetTranslation("bombKing.title");
         _bg = ComponentFactory.Instance.creat("bombKing.BG");
         addToContent(_bg);
         _loc3_ = 2;
         while(_loc3_ <= 31)
         {
            _loc2_ = new BKingLine(_loc3_);
            PositionUtils.setPos(_loc2_,"bombKing.linePos" + _loc3_);
            addToContent(_loc2_);
            _lineArr.push(_loc2_);
            _lineDic[_loc3_] = _loc2_;
            _loc3_++;
         }
         _loc3_ = 2;
         while(_loc3_ <= 31)
         {
            _loc1_ = new BKingPlayerItem(_loc3_);
            PositionUtils.setPos(_loc1_,"bombKing.itemPos" + _loc3_);
            _loc1_.addEventListener("click",__playerItemClick);
            _loc1_.buttonMode = true;
            addToContent(_loc1_);
            _itemArr.push(_loc1_);
            _itemDic[_loc3_] = _loc1_;
            _loc3_++;
         }
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("bombKing.startBtn");
         addToContent(_startBtn);
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("bombKing.timeTxt");
         addToContent(_timeTxt);
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("bombKing.rankBtn");
         addToContent(_rankBtn);
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("bombKing.rankInfoTxt");
         addToContent(_rankTxt);
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("bombKing.rankInfoTxt");
         PositionUtils.setPos(_scoreTxt,"bombKing.scoreTxtPos");
         addToContent(_scoreTxt);
         _prizeBtn = ComponentFactory.Instance.creatComponentByStylename("bombKing.prizeBtn");
         addToContent(_prizeBtn);
         _ruleBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"bombKing.ruleBtn",null,LanguageMgr.GetTranslation("bombKing.rules"),"bombKing.helpTxt",504,484) as SimpleBitmapButton;
         _purpleIcon = ComponentFactory.Instance.creat("bombKing.purpleIcon");
         addToContent(_purpleIcon);
         _redIcon = ComponentFactory.Instance.creat("bombKing.redIcon");
         addToContent(_redIcon);
         _blueIcon = ComponentFactory.Instance.creat("bombKing.blueIcon");
         addToContent(_blueIcon);
         _firstName = ComponentFactory.Instance.creatComponentByStylename("bombKing.nameTxt");
         PositionUtils.setPos(_firstName,"bombKing.firstNamePos");
         addToContent(_firstName);
         _secondName = ComponentFactory.Instance.creatComponentByStylename("bombKing.nameTxt");
         PositionUtils.setPos(_secondName,"bombKing.secondNamePos");
         addToContent(_secondName);
         _thirdName = ComponentFactory.Instance.creatComponentByStylename("bombKing.nameTxt");
         PositionUtils.setPos(_thirdName,"bombKing.thirdNamePos");
         addToContent(_thirdName);
         _logVBox = ComponentFactory.Instance.creatComponentByStylename("bombKing.Log.logVBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("bombKing.Log.scrollPanel");
         _scrollPanel.setView(_logVBox);
         addToContent(_scrollPanel);
         _battleSoon = ComponentFactory.Instance.creat("bombKing.battleSoon");
         addToContent(_battleSoon);
         _battleSoon.visible = false;
         _remain = ComponentFactory.Instance.creatComponentByStylename("bombKing.remainTxt");
         addToContent(_remain);
         _remain.text = "60";
         _remain.visible = false;
         _firstStageInPlay = ComponentFactory.Instance.creat("bombKing.battling1");
         addToContent(_firstStageInPlay);
         _firstStageInPlay.visible = false;
         _secondStageInPlay = ComponentFactory.Instance.creat("bombKing.battling2");
         addToContent(_secondStageInPlay);
         _secondStageInPlay.visible = false;
         _finalStageInPlay = ComponentFactory.Instance.creat("bombKing.battling3");
         addToContent(_finalStageInPlay);
         _finalStageInPlay.visible = false;
         _startBtn.enable = false;
         _playerTips = new BKingPlayerTip();
         addToContent(_playerTips);
         _playerTips.visible = false;
         _logArr = [];
         _top3NameArr = [];
         _top3NameArr.push(_firstName);
         _top3NameArr.push(_secondName);
         _top3NameArr.push(_thirdName);
         _tipSprite = new Component();
         _tipSprite.graphics.beginFill(0,0);
         _tipSprite.graphics.drawRect(0,0,_prizeBtn.width,_prizeBtn.height);
         _tipSprite.graphics.endFill();
         _tipSprite.x = _prizeBtn.x;
         _tipSprite.y = _prizeBtn.y;
         _tipSprite.tipStyle = "ddt.view.tips.OneLineTip";
         _tipSprite.tipDirctions = "7";
         _tipSprite.tipData = LanguageMgr.GetTranslation("bombKing.levelLimit");
         _tipSprite.visible = false;
      }
      
      private function initEvents() : void
      {
         addEventListener("response",__frameEventHandler);
         _startBtn.addEventListener("click",__startBtnClick);
         _rankBtn.addEventListener("click",__rankBtnClick);
         _prizeBtn.addEventListener("click",__prizeBtnClick);
         SocketManager.Instance.addEventListener(PkgEvent.format(263,3),__update);
         SocketManager.Instance.addEventListener(PkgEvent.format(263,7),__updateRequest);
         SocketManager.Instance.addEventListener(PkgEvent.format(263,4),__battleLog);
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
         SocketManager.Instance.addEventListener("GameWaitFailed",__waitGameFailed);
         SocketManager.Instance.addEventListener("recvGameWait",__waitGameRecv);
         StageReferance.stage.addEventListener("click",__onStageClick);
      }
      
      protected function __waitGameRecv(param1:CrazyTankSocketEvent) : void
      {
         SocketManager.Instance.out.updateBombKingMainFrame();
      }
      
      protected function __waitGameFailed(param1:CrazyTankSocketEvent) : void
      {
         SocketManager.Instance.out.updateBombKingMainFrame();
      }
      
      protected function __playerItemClick(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:BKingPlayerItem = param1.currentTarget as BKingPlayerItem;
         if(_loc2_ && _loc2_.info && _loc2_.info.userId != 0)
         {
            param1.stopPropagation();
            _playerTips.visible = true;
            _container.setChildIndex(_playerTips,_container.numChildren - 1);
            _loc3_ = globalToLocal(new Point(param1.stageX,param1.stageY));
            if(_loc3_.x + _playerTips.width > 1000)
            {
               _loc3_.x = 990 - _playerTips.width;
            }
            _playerTips.x = _loc3_.x;
            _playerTips.y = _loc3_.y;
            _playerTips.setUserId(_loc2_.info.userId,_loc2_.info.areaId);
            var _loc4_:Boolean = true;
            _playerTips.mouseEnabled = _loc4_;
            _playerTips.mouseChildren = _loc4_;
         }
      }
      
      protected function __onStageClick(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         _playerTips.mouseEnabled = _loc2_;
         _playerTips.mouseChildren = _loc2_;
         _playerTips.visible = false;
      }
      
      protected function __startBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendBombKingStartBattle();
      }
      
      protected function __rankBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _rankFrame = ComponentFactory.Instance.creatComponentByStylename("bombKing.BombKingRankFrame");
         LayerManager.Instance.addToLayer(_rankFrame,3,true,1);
      }
      
      protected function __prizeBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _prizeFrame = ComponentFactory.Instance.creatComponentByStylename("bombKing.BombKingPrizeFrame");
         LayerManager.Instance.addToLayer(_prizeFrame,3,true,1);
      }
      
      protected function __update(param1:PkgEvent) : void
      {
         var _loc7_:int = 0;
         var _loc3_:Boolean = false;
         var _loc8_:* = null;
         var _loc6_:int = 0;
         var _loc9_:Boolean = false;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc10_:* = null;
         var _loc12_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < 16)
         {
            _loc3_ = _loc4_.readBoolean();
            _loc8_ = new BKingPlayerInfo();
            if(_loc3_)
            {
               _loc8_.userId = _loc4_.readInt();
               _loc8_.areaId = _loc4_.readInt();
               _loc8_.name = _loc4_.readUTF();
               _loc8_.rankType = _loc4_.readInt();
            }
            _loc2_.push(_loc8_);
            _loc7_++;
         }
         _top3InfoArr = [];
         _loaderArr = [];
         _loc6_ = 0;
         while(_loc6_ < 3)
         {
            _loc9_ = _loc4_.readBoolean();
            _loc14_ = new BKingPlayerInfo();
            _loc15_ = null;
            if(_loc9_)
            {
               _loc14_.userId = _loc4_.readInt();
               _loc14_.areaId = _loc4_.readInt();
               _loc14_.name = _loc4_.readUTF();
               _loc10_ = _loc4_.readUTF();
               _loc14_.style = BombKingManager.instance.cutSuitStr(_loc10_);
               _loc14_.color = _loc4_.readUTF();
               _loc14_.sex = _loc4_.readBoolean();
               _loc12_ = new PlayerInfo();
               _loc12_.Style = _loc14_.style;
               _loc12_.Colors = _loc14_.color;
               _loc12_.Sex = _loc14_.sex;
               _loc15_ = CharactoryFactory.createCharacter(_loc12_) as ShowCharacter;
               _loc15_.addEventListener("complete",__characterComplete);
               _loc15_.showGun = false;
               _loc15_.setShowLight(false,null);
               _loc15_.stopAnimation();
               _loc15_.show(true,1);
               var _loc16_:* = false;
               _loc15_.mouseChildren = _loc16_;
               _loc16_ = _loc16_;
               _loc15_.mouseEnabled = _loc16_;
               _loc15_.buttonMode = _loc16_;
            }
            _loaderArr.push(_loc15_);
            _top3InfoArr.push(_loc14_);
            _top3NameArr[_loc6_].text = _loc14_.name;
            _loc6_++;
         }
         fillRankDic(_loc2_);
         updateItems();
         var _loc5_:int = _loc4_.readInt();
         var _loc11_:int = _loc4_.readInt();
         if(_loc11_ <= 0)
         {
            _rankTxt.text = LanguageMgr.GetTranslation("bombKing.outOfRank1");
         }
         else
         {
            _rankTxt.text = LanguageMgr.GetTranslation("bombKing.myRank",_loc11_);
         }
         _scoreTxt.text = LanguageMgr.GetTranslation("bombKing.myScore",_loc5_);
         _battleStage = _loc4_.readInt();
         _turn = _loc4_.readInt() + 1;
         _status = _loc4_.readInt();
         var _loc13_:Date = _loc4_.readDate();
         _battleEndDate = _loc4_.readDate();
         BombKingControl.instance.status = _status;
         setStartBtnStatus(_loc13_);
         setDateOfNext();
      }
      
      public function setDateOfNext() : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:Date = TimeManager.Instance.Now();
         if(BombKingControl.instance.isOpen)
         {
            if(!_battleEndDate)
            {
               return;
            }
            PositionUtils.setPos(_timeTxt,"bombKing.timeTxt2");
            _loc2_ = (_battleEndDate.getTime() - _loc3_.getTime()) / 1000;
            _loc4_ = Math.floor(_loc2_ / 60);
            _loc1_ = _loc2_ % 60;
            _timeTxt.text = LanguageMgr.GetTranslation("bombKing.nextTime",fillZero(_loc4_),fillZero(_loc1_),getTurnStr());
            if(nextTimer)
            {
               nextTimer.stop();
               nextTimer.removeEventListener("timer",onNextTimer);
               nextTimer = null;
            }
            nextTimer = new Timer(1000);
            nextTimer.addEventListener("timer",onNextTimer);
            nextTimer.start();
         }
         else
         {
            _timeTxt.text = "";
         }
      }
      
      private function getTurnStr() : String
      {
         if(_battleStage <= 2)
         {
            return _turn + "/10";
         }
         switch(int(_battleStage) - 3)
         {
            case 0:
               return "1/4";
            case 1:
               return "2/4";
            case 2:
               return "3/4";
            case 3:
               return "4/4";
         }
      }
      
      private function getDayStr(param1:int) : String
      {
         switch(int(param1))
         {
            case 0:
               return "周日";
            case 1:
               return "周一";
            case 2:
               return "周二";
            case 3:
               return "周三";
            case 4:
               return "周四";
            case 5:
               return "周五";
            case 6:
               return "周六";
         }
      }
      
      private function __characterComplete(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:ShowCharacter = param1.target as ShowCharacter;
         _loc3_.removeEventListener("complete",__characterComplete);
         _loc4_ = 0;
         while(_loc4_ <= _loaderArr.length - 1)
         {
            if(_loc3_ != _loaderArr[_loc4_])
            {
               _loc4_++;
               continue;
            }
            break;
         }
         _loc2_ = new Bitmap(new BitmapData(200,170));
         _loc2_.bitmapData.copyPixels(_loc3_.characterBitmapdata,new Rectangle(0,60,200,170),new Point(0,0));
         PositionUtils.setPos(_loc2_,"bombKing.figurePos" + _loc4_);
         _loc2_.scaleX = 0.3;
         _loc2_.scaleY = 0.3;
         _loc2_.smoothing = true;
         addToContent(_loc2_);
         _headImgArr.push(_loc2_);
      }
      
      private function setStartBtnStatus(param1:Date) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         if(PlayerManager.Instance.Self.Grade < 30)
         {
            _startBtn.visible = true;
            _startBtn.enable = false;
            _firstStageInPlay.visible = false;
            _secondStageInPlay.visible = false;
            _finalStageInPlay.visible = false;
            _battleSoon.visible = false;
            _remain.visible = false;
            _tipSprite.visible = true;
            return;
         }
         switch(int(_status))
         {
            case 0:
               _startBtn.visible = true;
               _startBtn.enable = true;
               _firstStageInPlay.visible = false;
               _secondStageInPlay.visible = false;
               _finalStageInPlay.visible = false;
               _battleSoon.visible = false;
               _remain.visible = false;
               _tipSprite.visible = false;
               break;
            case 1:
               _startBtn.visible = true;
               _startBtn.enable = false;
               _firstStageInPlay.visible = false;
               _secondStageInPlay.visible = false;
               _finalStageInPlay.visible = false;
               _battleSoon.visible = false;
               _remain.visible = false;
               _tipSprite.visible = false;
               break;
            case 2:
               _startBtn.visible = false;
               _firstStageInPlay.visible = false;
               _secondStageInPlay.visible = false;
               _finalStageInPlay.visible = false;
               _battleSoon.visible = true;
               _remain.visible = true;
               _tipSprite.visible = false;
               _loc3_ = TimeManager.Instance.Now();
               _loc2_ = (param1.getTime() - _loc3_.getTime()) / 1000;
               _remain.text = _loc2_.toString();
               if(remainTimer)
               {
                  remainTimer.stop();
                  remainTimer.removeEventListener("timer",onRemainTimer);
                  remainTimer = null;
               }
               remainTimer = new Timer(1000);
               remainTimer.addEventListener("timer",onRemainTimer);
               remainTimer.start();
               break;
            case 3:
               _startBtn.visible = false;
               _battleSoon.visible = false;
               _remain.visible = false;
               _tipSprite.visible = false;
               switch(int(_battleStage) - 1)
               {
                  case 0:
                     _firstStageInPlay.visible = true;
                     _secondStageInPlay.visible = false;
                     _finalStageInPlay.visible = false;
                     break;
                  case 1:
                     _firstStageInPlay.visible = false;
                     _secondStageInPlay.visible = true;
                     _finalStageInPlay.visible = false;
                     break;
                  case 2:
                  case 3:
                  case 4:
                  case 5:
                     _firstStageInPlay.visible = false;
                     _secondStageInPlay.visible = false;
                     _finalStageInPlay.visible = true;
               }
         }
      }
      
      protected function onNextTimer(param1:TimerEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:Date = TimeManager.Instance.Now();
         var _loc3_:int = (_battleEndDate.getTime() - _loc4_.getTime()) / 1000;
         if(_loc3_ <= 0)
         {
            nextTimer.stop();
            nextTimer.removeEventListener("timer",onRemainTimer);
            nextTimer = null;
         }
         else
         {
            _loc5_ = Math.floor(_loc3_ / 60);
            _loc2_ = _loc3_ % 60;
            _timeTxt.text = LanguageMgr.GetTranslation("bombKing.nextTime",fillZero(_loc5_),fillZero(_loc2_),getTurnStr());
         }
      }
      
      private function fillZero(param1:int) : String
      {
         if(param1 >= 0 && param1 <= 9)
         {
            return "0" + param1;
         }
         return "" + param1;
      }
      
      protected function onRemainTimer(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         if(_remain)
         {
            _loc2_ = parseInt(_remain.text);
            if(_loc2_ <= 0)
            {
               remainTimer.stop();
               remainTimer.removeEventListener("timer",onRemainTimer);
               remainTimer = null;
            }
            else
            {
               _loc2_--;
               _remain.text = _loc2_.toString();
            }
         }
      }
      
      private function fillRankDic(param1:Array) : void
      {
         var _loc9_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:* = null;
         var _loc3_:int = 0;
         var _loc7_:* = null;
         var _loc6_:int = 0;
         _rankDic = new Dictionary();
         _loc9_ = 0;
         while(_loc9_ <= param1.length - 1)
         {
            _rankDic[_loc9_ + 16] = param1[_loc9_];
            _loc2_ = (param1[_loc9_] as BKingPlayerInfo).rankType - 2;
            _loc5_ = _loc9_ + 16;
            _loc4_ = 0;
            while(_loc4_ <= _loc2_ - 1)
            {
               _loc5_ = Math.floor(_loc5_ / 2);
               _loc8_ = new BKingPlayerInfo();
               ObjectUtils.copyProperties(_loc8_,param1[_loc9_]);
               _rankDic[_loc5_] = _loc8_;
               _loc4_++;
            }
            _loc9_++;
         }
         _loc3_ = 2;
         while(_loc3_ <= 31)
         {
            if(!_rankDic[_loc3_])
            {
               _loc7_ = new BKingPlayerInfo();
               _rankDic[_loc3_] = _loc7_;
            }
            _loc3_++;
         }
         _loc6_ = 2;
         while(_loc6_ <= 15)
         {
            if(_rankDic[_loc6_].userId != 0)
            {
               if(_rankDic[2 * _loc6_].userId == _rankDic[_loc6_].userId)
               {
                  _rankDic[2 * _loc6_].status = 1;
                  if(_rankDic[2 * _loc6_ + 1].userId != 0)
                  {
                     _rankDic[2 * _loc6_ + 1].status = -1;
                  }
               }
               else
               {
                  if(_rankDic[2 * _loc6_].userId != 0)
                  {
                     _rankDic[2 * _loc6_].status = -1;
                  }
                  _rankDic[2 * _loc6_ + 1].status = 1;
               }
            }
            _loc6_++;
         }
         if(_top3InfoArr[0].userId != 0)
         {
            if(_top3InfoArr[0].userId == _rankDic[2].userId)
            {
               _rankDic[2].status = 1;
               _rankDic[3].status = -1;
            }
            else
            {
               _rankDic[2].status = -1;
               _rankDic[3].status = 1;
            }
         }
      }
      
      private function updateItems() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _loc3_ = 0;
         while(_loc3_ <= _stampArr.length - 1)
         {
            ObjectUtils.disposeObject(_stampArr[_loc3_]);
            _stampArr[_loc3_] = null;
            _loc3_++;
         }
         _loc4_ = 2;
         while(_loc4_ <= 31)
         {
            _loc2_ = _itemDic[_loc4_] as BKingPlayerItem;
            _loc2_.info = _rankDic[_loc4_];
            (_lineDic[_loc4_] as BKingLine).info = _rankDic[_loc4_];
            if(_rankDic[_loc4_] && _rankDic[_loc4_].status == -1)
            {
               _loc1_ = ComponentFactory.Instance.creat("bombKing.loseStamp");
               addToContent(_loc1_);
               _loc1_.x = _loc2_.x - 15;
               _loc1_.y = _loc2_.y - 20;
               _stampArr.push(_loc1_);
            }
            _loc4_++;
         }
      }
      
      protected function __updateRequest(param1:PkgEvent) : void
      {
         SocketManager.Instance.out.updateBombKingMainFrame();
         SocketManager.Instance.out.updateBombKingBattleLog();
      }
      
      protected function __battleLog(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         _loc5_ = 0;
         while(_loc5_ <= _logArr.length - 1)
         {
            ObjectUtils.disposeObject(_logArr[_loc5_]);
            _logArr[_loc5_] = null;
            _loc5_++;
         }
         _logArr = [];
         _loc7_ = 0;
         while(_loc7_ <= _loc2_ - 1)
         {
            _loc6_ = new BKingLogInfo();
            _loc6_.stage = _loc4_.readInt();
            _loc6_.userId = _loc4_.readInt();
            _loc6_.areaId = _loc4_.readInt();
            _loc6_.name = _loc4_.readUTF();
            _loc6_.fightId = _loc4_.readInt();
            _loc6_.fightAreaId = _loc4_.readInt();
            _loc6_.fightName = _loc4_.readUTF();
            _loc6_.reportId = _loc4_.readUTF();
            _loc6_.result = _loc4_.readBoolean();
            _loc3_ = new BKingbattleLogItem();
            _loc3_.info = _loc6_;
            _logVBox.addChild(_loc3_);
            _logArr.push(_loc3_);
            _loc7_++;
         }
         _scrollPanel.invalidateViewport(true);
      }
      
      private function __startLoading(param1:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               if(_status == 2)
               {
                  _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("bombKing.cancelBattle"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
                  _loc2_.moveEnable = false;
                  _loc2_.addEventListener("response",_response);
                  break;
               }
               dispose();
               break;
         }
      }
      
      private function _response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         param1.stopPropagation();
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_response);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            GameInSocketOut.sendCancelWait();
            dispose();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function removeEvents() : void
      {
         if(StageReferance.stage.hasEventListener("click"))
         {
            StageReferance.stage.removeEventListener("click",__onStageClick);
         }
         if(_startBtn)
         {
            _startBtn.removeEventListener("click",__startBtnClick);
         }
         if(_rankBtn)
         {
            _rankBtn.removeEventListener("click",__rankBtnClick);
         }
         if(_prizeBtn)
         {
            _prizeBtn.removeEventListener("click",__prizeBtnClick);
         }
         GameControl.Instance.removeEventListener("StartLoading",__startLoading);
         SocketManager.Instance.removeEventListener(PkgEvent.format(263,3),__update);
         SocketManager.Instance.removeEventListener(PkgEvent.format(263,7),__updateRequest);
         SocketManager.Instance.removeEventListener(PkgEvent.format(263,4),__battleLog);
         SocketManager.Instance.removeEventListener("GameWaitFailed",__waitGameFailed);
         SocketManager.Instance.removeEventListener("recvGameWait",__waitGameRecv);
         removeEventListener("response",__frameEventHandler);
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         BombKingManager.instance.ShowFlag = false;
         removeEvents();
         BombKingControl.instance.frame = null;
         if(_status == 1)
         {
            GameInSocketOut.sendCancelWait();
         }
         _loc1_ = 0;
         while(_loc1_ <= _itemArr.length - 1)
         {
            _itemArr[_loc1_].removeEventListener("click",__playerItemClick);
            ObjectUtils.disposeObject(_itemArr[_loc1_]);
            _itemArr[_loc1_] = null;
            ObjectUtils.disposeObject(_lineArr[_loc1_]);
            _lineArr[_loc1_] = null;
            _loc1_++;
         }
         _itemArr = null;
         _itemDic = null;
         _lineArr = null;
         _lineDic = null;
         _loc1_ = 0;
         while(_loc1_ <= _stampArr.length - 1)
         {
            ObjectUtils.disposeObject(_stampArr[_loc1_]);
            _stampArr[_loc1_] = null;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ <= _logArr.length - 1)
         {
            ObjectUtils.disposeObject(_logArr[_loc1_]);
            _logArr[_loc1_] = null;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ <= _headImgArr.length - 1)
         {
            ObjectUtils.disposeObject(_headImgArr[_loc1_]);
            _headImgArr[_loc1_] = null;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ <= _top3NameArr.length - 1)
         {
            ObjectUtils.disposeObject(_top3NameArr[_loc1_]);
            _top3NameArr[_loc1_] = null;
            _loc1_++;
         }
         if(_loaderArr)
         {
            _loc1_ = 0;
            while(_loc1_ <= _loaderArr.length - 1)
            {
               if(_loaderArr[_loc1_])
               {
                  (_loaderArr[_loc1_] as ShowCharacter).removeEventListener("complete",__characterComplete);
                  ObjectUtils.disposeObject(_loaderArr[_loc1_]);
                  _loaderArr[_loc1_] = null;
               }
               _loc1_++;
            }
         }
         if(remainTimer)
         {
            remainTimer.stop();
            remainTimer.removeEventListener("timer",onRemainTimer);
            remainTimer = null;
         }
         if(nextTimer)
         {
            nextTimer.stop();
            nextTimer.removeEventListener("timer",onRemainTimer);
            nextTimer = null;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_rankBtn);
         _rankBtn = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_prizeBtn);
         _prizeBtn = null;
         ObjectUtils.disposeObject(_ruleBtn);
         _ruleBtn = null;
         ObjectUtils.disposeObject(_purpleIcon);
         _purpleIcon = null;
         ObjectUtils.disposeObject(_redIcon);
         _redIcon = null;
         ObjectUtils.disposeObject(_blueIcon);
         _blueIcon = null;
         ObjectUtils.disposeObject(_firstName);
         _firstName = null;
         ObjectUtils.disposeObject(_secondName);
         _secondName = null;
         ObjectUtils.disposeObject(_thirdName);
         _thirdName = null;
         ObjectUtils.disposeObject(_logVBox);
         _logVBox = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_battleSoon);
         _battleSoon = null;
         ObjectUtils.disposeObject(_remain);
         _remain = null;
         ObjectUtils.disposeObject(_playerTips);
         _playerTips = null;
         ObjectUtils.disposeObject(_firstStageInPlay);
         _firstStageInPlay = null;
         ObjectUtils.disposeObject(_secondStageInPlay);
         _secondStageInPlay = null;
         ObjectUtils.disposeObject(_finalStageInPlay);
         _finalStageInPlay = null;
         super.dispose();
      }
   }
}
