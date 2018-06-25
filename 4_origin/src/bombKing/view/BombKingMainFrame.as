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
         var place:int = 0;
         var line:* = null;
         var item:* = null;
         titleText = LanguageMgr.GetTranslation("bombKing.title");
         _bg = ComponentFactory.Instance.creat("bombKing.BG");
         addToContent(_bg);
         for(place = 2; place <= 31; )
         {
            line = new BKingLine(place);
            PositionUtils.setPos(line,"bombKing.linePos" + place);
            addToContent(line);
            _lineArr.push(line);
            _lineDic[place] = line;
            place++;
         }
         for(place = 2; place <= 31; )
         {
            item = new BKingPlayerItem(place);
            PositionUtils.setPos(item,"bombKing.itemPos" + place);
            item.addEventListener("click",__playerItemClick);
            item.buttonMode = true;
            addToContent(item);
            _itemArr.push(item);
            _itemDic[place] = item;
            place++;
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
      
      protected function __waitGameRecv(event:CrazyTankSocketEvent) : void
      {
         SocketManager.Instance.out.updateBombKingMainFrame();
      }
      
      protected function __waitGameFailed(event:CrazyTankSocketEvent) : void
      {
         SocketManager.Instance.out.updateBombKingMainFrame();
      }
      
      protected function __playerItemClick(event:MouseEvent) : void
      {
         var gp:* = null;
         var item:BKingPlayerItem = event.currentTarget as BKingPlayerItem;
         if(item && item.info && item.info.userId != 0)
         {
            event.stopPropagation();
            _playerTips.visible = true;
            _container.setChildIndex(_playerTips,_container.numChildren - 1);
            gp = globalToLocal(new Point(event.stageX,event.stageY));
            if(gp.x + _playerTips.width > 1000)
            {
               gp.x = 990 - _playerTips.width;
            }
            _playerTips.x = gp.x;
            _playerTips.y = gp.y;
            _playerTips.setUserId(item.info.userId,item.info.areaId);
            var _loc4_:Boolean = true;
            _playerTips.mouseEnabled = _loc4_;
            _playerTips.mouseChildren = _loc4_;
         }
      }
      
      protected function __onStageClick(event:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         _playerTips.mouseEnabled = _loc2_;
         _playerTips.mouseChildren = _loc2_;
         _playerTips.visible = false;
      }
      
      protected function __startBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendBombKingStartBattle();
      }
      
      protected function __rankBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _rankFrame = ComponentFactory.Instance.creatComponentByStylename("bombKing.BombKingRankFrame");
         LayerManager.Instance.addToLayer(_rankFrame,3,true,1);
      }
      
      protected function __prizeBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _prizeFrame = ComponentFactory.Instance.creatComponentByStylename("bombKing.BombKingPrizeFrame");
         LayerManager.Instance.addToLayer(_prizeFrame,3,true,1);
      }
      
      protected function __update(event:PkgEvent) : void
      {
         var i:int = 0;
         var isExist:Boolean = false;
         var info:* = null;
         var j:int = 0;
         var isExist2:Boolean = false;
         var info2:* = null;
         var characterLoader:* = null;
         var style:* = null;
         var playerInfo:* = null;
         var pkg:PackageIn = event.pkg;
         var arr:Array = [];
         for(i = 0; i < 16; )
         {
            isExist = pkg.readBoolean();
            info = new BKingPlayerInfo();
            if(isExist)
            {
               info.userId = pkg.readInt();
               info.areaId = pkg.readInt();
               info.name = pkg.readUTF();
               info.rankType = pkg.readInt();
            }
            arr.push(info);
            i++;
         }
         _top3InfoArr = [];
         _loaderArr = [];
         for(j = 0; j < 3; )
         {
            isExist2 = pkg.readBoolean();
            info2 = new BKingPlayerInfo();
            characterLoader = null;
            if(isExist2)
            {
               info2.userId = pkg.readInt();
               info2.areaId = pkg.readInt();
               info2.name = pkg.readUTF();
               style = pkg.readUTF();
               info2.style = BombKingManager.instance.cutSuitStr(style);
               info2.color = pkg.readUTF();
               info2.sex = pkg.readBoolean();
               playerInfo = new PlayerInfo();
               playerInfo.Style = info2.style;
               playerInfo.Colors = info2.color;
               playerInfo.Sex = info2.sex;
               characterLoader = CharactoryFactory.createCharacter(playerInfo) as ShowCharacter;
               characterLoader.addEventListener("complete",__characterComplete);
               characterLoader.showGun = false;
               characterLoader.setShowLight(false,null);
               characterLoader.stopAnimation();
               characterLoader.show(true,1);
               var _loc16_:* = false;
               characterLoader.mouseChildren = _loc16_;
               _loc16_ = _loc16_;
               characterLoader.mouseEnabled = _loc16_;
               characterLoader.buttonMode = _loc16_;
            }
            _loaderArr.push(characterLoader);
            _top3InfoArr.push(info2);
            _top3NameArr[j].text = info2.name;
            j++;
         }
         fillRankDic(arr);
         updateItems();
         var myScore:int = pkg.readInt();
         var myRank:int = pkg.readInt();
         if(myRank <= 0)
         {
            _rankTxt.text = LanguageMgr.GetTranslation("bombKing.outOfRank1");
         }
         else
         {
            _rankTxt.text = LanguageMgr.GetTranslation("bombKing.myRank",myRank);
         }
         _scoreTxt.text = LanguageMgr.GetTranslation("bombKing.myScore",myScore);
         _battleStage = pkg.readInt();
         _turn = pkg.readInt() + 1;
         _status = pkg.readInt();
         var deadline:Date = pkg.readDate();
         _battleEndDate = pkg.readDate();
         BombKingControl.instance.status = _status;
         setStartBtnStatus(deadline);
         setDateOfNext();
      }
      
      public function setDateOfNext() : void
      {
         var diff:int = 0;
         var m:int = 0;
         var s:int = 0;
         var now:Date = TimeManager.Instance.Now();
         if(BombKingControl.instance.isOpen)
         {
            if(!_battleEndDate)
            {
               return;
            }
            PositionUtils.setPos(_timeTxt,"bombKing.timeTxt2");
            diff = (_battleEndDate.getTime() - now.getTime()) / 1000;
            m = Math.floor(diff / 60);
            s = diff % 60;
            _timeTxt.text = LanguageMgr.GetTranslation("bombKing.nextTime",fillZero(m),fillZero(s),getTurnStr());
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
      
      private function getDayStr(openDay:int) : String
      {
         switch(int(openDay))
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
      
      private function __characterComplete(event:Event) : void
      {
         var i:int = 0;
         var figure:* = null;
         var loader:ShowCharacter = event.target as ShowCharacter;
         loader.removeEventListener("complete",__characterComplete);
         for(i = 0; i <= _loaderArr.length - 1; )
         {
            if(loader != _loaderArr[i])
            {
               i++;
               continue;
            }
            break;
         }
         figure = new Bitmap(new BitmapData(200,170));
         figure.bitmapData.copyPixels(loader.characterBitmapdata,new Rectangle(0,60,200,170),new Point(0,0));
         PositionUtils.setPos(figure,"bombKing.figurePos" + i);
         figure.scaleX = 0.3;
         figure.scaleY = 0.3;
         figure.smoothing = true;
         addToContent(figure);
         _headImgArr.push(figure);
      }
      
      private function setStartBtnStatus(deadLine:Date) : void
      {
         var now:* = null;
         var diff:int = 0;
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
               now = TimeManager.Instance.Now();
               diff = (deadLine.getTime() - now.getTime()) / 1000;
               _remain.text = diff.toString();
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
      
      protected function onNextTimer(event:TimerEvent) : void
      {
         var m:int = 0;
         var s:int = 0;
         var now:Date = TimeManager.Instance.Now();
         var diff:int = (_battleEndDate.getTime() - now.getTime()) / 1000;
         if(diff <= 0)
         {
            nextTimer.stop();
            nextTimer.removeEventListener("timer",onRemainTimer);
            nextTimer = null;
         }
         else
         {
            m = Math.floor(diff / 60);
            s = diff % 60;
            _timeTxt.text = LanguageMgr.GetTranslation("bombKing.nextTime",fillZero(m),fillZero(s),getTurnStr());
         }
      }
      
      private function fillZero(num:int) : String
      {
         if(num >= 0 && num <= 9)
         {
            return "0" + num;
         }
         return "" + num;
      }
      
      protected function onRemainTimer(event:TimerEvent) : void
      {
         var remainTime:int = 0;
         if(_remain)
         {
            remainTime = parseInt(_remain.text);
            if(remainTime <= 0)
            {
               remainTimer.stop();
               remainTimer.removeEventListener("timer",onRemainTimer);
               remainTimer = null;
            }
            else
            {
               remainTime--;
               _remain.text = remainTime.toString();
            }
         }
      }
      
      private function fillRankDic(arr:Array) : void
      {
         var i:int = 0;
         var count:int = 0;
         var place:int = 0;
         var j:int = 0;
         var info:* = null;
         var l:int = 0;
         var info2:* = null;
         var k:int = 0;
         _rankDic = new Dictionary();
         for(i = 0; i <= arr.length - 1; )
         {
            _rankDic[i + 16] = arr[i];
            count = (arr[i] as BKingPlayerInfo).rankType - 2;
            place = i + 16;
            for(j = 0; j <= count - 1; )
            {
               place = Math.floor(place / 2);
               info = new BKingPlayerInfo();
               ObjectUtils.copyProperties(info,arr[i]);
               _rankDic[place] = info;
               j++;
            }
            i++;
         }
         for(l = 2; l <= 31; )
         {
            if(!_rankDic[l])
            {
               info2 = new BKingPlayerInfo();
               _rankDic[l] = info2;
            }
            l++;
         }
         for(k = 2; k <= 15; )
         {
            if(_rankDic[k].userId != 0)
            {
               if(_rankDic[2 * k].userId == _rankDic[k].userId)
               {
                  _rankDic[2 * k].status = 1;
                  if(_rankDic[2 * k + 1].userId != 0)
                  {
                     _rankDic[2 * k + 1].status = -1;
                  }
               }
               else
               {
                  if(_rankDic[2 * k].userId != 0)
                  {
                     _rankDic[2 * k].status = -1;
                  }
                  _rankDic[2 * k + 1].status = 1;
               }
            }
            k++;
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
         var j:int = 0;
         var i:int = 0;
         var item:* = null;
         var loseStamp:* = null;
         for(j = 0; j <= _stampArr.length - 1; )
         {
            ObjectUtils.disposeObject(_stampArr[j]);
            _stampArr[j] = null;
            j++;
         }
         for(i = 2; i <= 31; )
         {
            item = _itemDic[i] as BKingPlayerItem;
            item.info = _rankDic[i];
            (_lineDic[i] as BKingLine).info = _rankDic[i];
            if(_rankDic[i] && _rankDic[i].status == -1)
            {
               loseStamp = ComponentFactory.Instance.creat("bombKing.loseStamp");
               addToContent(loseStamp);
               loseStamp.x = item.x - 15;
               loseStamp.y = item.y - 20;
               _stampArr.push(loseStamp);
            }
            i++;
         }
      }
      
      protected function __updateRequest(event:PkgEvent) : void
      {
         SocketManager.Instance.out.updateBombKingMainFrame();
         SocketManager.Instance.out.updateBombKingBattleLog();
      }
      
      protected function __battleLog(event:PkgEvent) : void
      {
         var k:int = 0;
         var i:int = 0;
         var info:* = null;
         var item:* = null;
         var pkg:PackageIn = event.pkg;
         var count:int = pkg.readInt();
         for(k = 0; k <= _logArr.length - 1; )
         {
            ObjectUtils.disposeObject(_logArr[k]);
            _logArr[k] = null;
            k++;
         }
         _logArr = [];
         for(i = 0; i <= count - 1; )
         {
            info = new BKingLogInfo();
            info.stage = pkg.readInt();
            info.userId = pkg.readInt();
            info.areaId = pkg.readInt();
            info.name = pkg.readUTF();
            info.fightId = pkg.readInt();
            info.fightAreaId = pkg.readInt();
            info.fightName = pkg.readUTF();
            info.reportId = pkg.readUTF();
            info.result = pkg.readBoolean();
            item = new BKingbattleLogItem();
            item.info = info;
            _logVBox.addChild(item);
            _logArr.push(item);
            i++;
         }
         _scrollPanel.invalidateViewport(true);
      }
      
      private function __startLoading(e:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         var alert:* = null;
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               if(_status == 2)
               {
                  alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("bombKing.cancelBattle"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
                  alert.moveEnable = false;
                  alert.addEventListener("response",_response);
                  break;
               }
               dispose();
               break;
         }
      }
      
      private function _response(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         evt.stopPropagation();
         (evt.currentTarget as BaseAlerFrame).removeEventListener("response",_response);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            GameInSocketOut.sendCancelWait();
            dispose();
         }
         ObjectUtils.disposeObject(evt.currentTarget);
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
         var i:int = 0;
         BombKingManager.instance.ShowFlag = false;
         removeEvents();
         BombKingControl.instance.frame = null;
         if(_status == 1)
         {
            GameInSocketOut.sendCancelWait();
         }
         i = 0;
         while(i <= _itemArr.length - 1)
         {
            _itemArr[i].removeEventListener("click",__playerItemClick);
            ObjectUtils.disposeObject(_itemArr[i]);
            _itemArr[i] = null;
            ObjectUtils.disposeObject(_lineArr[i]);
            _lineArr[i] = null;
            i++;
         }
         _itemArr = null;
         _itemDic = null;
         _lineArr = null;
         _lineDic = null;
         for(i = 0; i <= _stampArr.length - 1; )
         {
            ObjectUtils.disposeObject(_stampArr[i]);
            _stampArr[i] = null;
            i++;
         }
         for(i = 0; i <= _logArr.length - 1; )
         {
            ObjectUtils.disposeObject(_logArr[i]);
            _logArr[i] = null;
            i++;
         }
         for(i = 0; i <= _headImgArr.length - 1; )
         {
            ObjectUtils.disposeObject(_headImgArr[i]);
            _headImgArr[i] = null;
            i++;
         }
         for(i = 0; i <= _top3NameArr.length - 1; )
         {
            ObjectUtils.disposeObject(_top3NameArr[i]);
            _top3NameArr[i] = null;
            i++;
         }
         if(_loaderArr)
         {
            for(i = 0; i <= _loaderArr.length - 1; )
            {
               if(_loaderArr[i])
               {
                  (_loaderArr[i] as ShowCharacter).removeEventListener("complete",__characterComplete);
                  ObjectUtils.disposeObject(_loaderArr[i]);
                  _loaderArr[i] = null;
               }
               i++;
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
