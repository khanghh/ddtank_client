package superWinner.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddt.view.chat.ChatView;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import superWinner.controller.SuperWinnerController;
   import superWinner.data.SuperWinnerAwardsMode;
   import superWinner.event.SuperWinnerEvent;
   import superWinner.manager.SuperWinnerManager;
   import superWinner.model.SuperWinnerModel;
   import superWinner.view.bigAwards.SuperWinnerBigAwardView;
   import superWinner.view.smallAwards.SuperWinnerSmallAwardView;
   
   public class SuperWinnerView extends Sprite implements Disposeable
   {
       
      
      private var _model:SuperWinnerModel;
      
      private var _contro:SuperWinnerController;
      
      private var _dicesbanner:DicesBanner;
      
      private var _championDicesbanner:DicesBanner;
      
      private var _dicesMovie:DicesMovieSprite;
      
      private var _progressBar:SuperWinnerProgressBar;
      
      private var _rollDiceBtn:BaseButton;
      
      private var _playerList:SuperWinnerPlayerListView;
      
      private var _awardView:SuperWinnerBigAwardView;
      
      private var _myAwardView:SuperWinnerSmallAwardView;
      
      private var returnBtn:SuperWinnerReturn;
      
      private var _champion:SuperWinnerPlayerItem;
      
      private var _chatView:ChatView;
      
      private var _endTimeTxt:FilterFrameText;
      
      private var _time:Timer;
      
      private var _remainTime:uint = 0;
      
      private var _helpBtn:BaseButton;
      
      private var championBg:Bitmap;
      
      private var noChampionBg:Bitmap;
      
      private var cot:uint;
      
      private var _awardsTip:SuperWinnerAwardsTip;
      
      public function SuperWinnerView($contro:SuperWinnerController)
      {
         _time = new Timer(1000);
         this._contro = $contro;
         this._model = SuperWinnerController.instance.model;
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         addChild(ComponentFactory.Instance.creatBitmap("superwinner.bg"));
         addChild(ComponentFactory.Instance.creatBitmap("asset.superWinner.translucentArticle"));
         addChild(ComponentFactory.Instance.creatComponentByStylename("superWinner.ChatViewBg"));
         noChampionBg = ComponentFactory.Instance.creatBitmap("asset.superWinner.noChampionBg");
         addChild(noChampionBg);
         championBg = ComponentFactory.Instance.creatBitmap("asset.superWinner.championBg");
         championBg.visible = false;
         addChild(championBg);
         addChild(ComponentFactory.Instance.creatBitmap("asset.superWinner.championIcon"));
         returnBtn = ComponentFactory.Instance.creat("asset.superWinner.returnMenu");
         addChild(ComponentFactory.Instance.creatBitmap("asset.superWinner.myPrizeBg"));
         addChild(ComponentFactory.Instance.creatBitmap("asset.superWinner.lastRound"));
         addChild(ComponentFactory.Instance.creatBitmap("asset.superWinner.rollDiceTxt"));
         addChild(ComponentFactory.Instance.creatBitmap("asset.superWinner.prizeBg"));
         _dicesMovie = ComponentFactory.Instance.creat("asset.superWinner.DicesMovieSprite");
         _progressBar = ComponentFactory.Instance.creat("asset.superWinner.progressBar");
         _progressBar.resetProgressBar();
         _rollDiceBtn = ComponentFactory.Instance.creat("asset.superWinner.rollDice");
         _rollDiceBtn.enable = false;
         _dicesbanner = new DicesBanner();
         PositionUtils.setPos(_dicesbanner,"asset.superWinner.DicesBanner");
         _dicesbanner.visible = false;
         _championDicesbanner = new DicesBanner(34);
         PositionUtils.setPos(_championDicesbanner,"asset.superWinner.DicesBanner2");
         _championDicesbanner.visible = false;
         _endTimeTxt = ComponentFactory.Instance.creatComponentByStylename("superWinner.endTimeTxt");
         _playerList = new SuperWinnerPlayerListView(_model.getPlayerList());
         PositionUtils.setPos(_playerList,"playerList.bg.point");
         _awardView = ComponentFactory.Instance.creat("asset.superWinner.superWinnerBigAwardView");
         _myAwardView = ComponentFactory.Instance.creat("asset.superWinner.superWinnerSmallAwardView");
         _champion = new SuperWinnerPlayerItem();
         _champion.sexIcon.visible = false;
         _champion.visible = false;
         PositionUtils.setPos(_champion,"asset.superWinner.Champion");
         _helpBtn = ComponentFactory.Instance.creat("superWinner.helpBtn");
         _awardsTip = new SuperWinnerAwardsTip();
         _awardsTip.visible = false;
         ChatManager.Instance.state = 31;
         _chatView = ChatManager.Instance.view;
         ChatManager.Instance.setFocus();
         ChatManager.Instance.lock = false;
         addChild(_champion);
         addChild(returnBtn);
         addChild(_dicesbanner);
         addChild(_championDicesbanner);
         addChild(_dicesMovie);
         addChild(_progressBar);
         addChild(_endTimeTxt);
         addChild(_rollDiceBtn);
         addChild(_playerList);
         addChild(_awardView);
         addChild(_myAwardView);
         addChild(_chatView);
         addChild(_helpBtn);
         addChild(_awardsTip);
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.superWinner.waitStart"));
      }
      
      private function count(evt:Event) : void
      {
         if(!_model.endData)
         {
            return;
         }
         var seconds:int = TimeManager.Instance.TotalSecondToNow(_model.endData);
         updateTime(seconds);
      }
      
      public function endGame() : void
      {
         var str:* = null;
         var i:int = 0;
         var awardsNum:int = 0;
         for(i = 0; i < 5; )
         {
            awardsNum = awardsNum + _model.awards[i];
            i++;
         }
         if(awardsNum == 0)
         {
            str = LanguageMgr.GetTranslation("ddt.superWinner.endTxt1");
         }
         else
         {
            str = LanguageMgr.GetTranslation("ddt.superWinner.endTxt2");
         }
         var alertFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),str,LanguageMgr.GetTranslation("ok"),"",false,true,true,2);
         alertFrame.cancelButtonEnable = false;
         alertFrame.addEventListener("response",outRoom);
         count30s(alertFrame);
      }
      
      private function count30s(alertFrame:BaseAlerFrame) : void
      {
         alertFrame = alertFrame;
         cot = setTimeout(function():void
         {
            clearTimeout(cot);
            alertFrame.dispatchEvent(new FrameEvent(1));
         },30000);
      }
      
      private function outRoom(e:FrameEvent) : void
      {
         if(cot)
         {
            clearTimeout(cot);
         }
         var alert:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",outRoom);
         alert.dispose();
         returnBtn.dispachReturnEvent();
      }
      
      private function initEvent() : void
      {
         SuperWinnerManager.instance.addEventListener("return_hall",__onReturn);
         _model.addEventListener("return_dices",__returnDices);
         _model.addEventListener("start_roll_dices",__startRollDices);
         _model.addEventListener("progress_time_up",__progressTimesUp);
         _model.addEventListener("champion_change",__championChange);
         _model.addEventListener("notice",__sendNotice);
         _awardView.addEventListener("showtip",__showTip);
         _awardView.addEventListener("hidetip",__hideTip);
         _rollDiceBtn.addEventListener("click",__rollDiceFunc);
         _helpBtn.addEventListener("click",__openHelpFrame);
         _time.addEventListener("timer",count);
         _time.start();
      }
      
      public function removeEvent() : void
      {
         SuperWinnerManager.instance.removeEventListener("return_hall",__onReturn);
         if(_model)
         {
            _model.removeEventListener("return_dices",__returnDices);
            _model.removeEventListener("start_roll_dices",__startRollDices);
            _model.removeEventListener("progress_time_up",__progressTimesUp);
            _model.removeEventListener("champion_change",__championChange);
            _model.removeEventListener("notice",__sendNotice);
         }
         if(_awardView)
         {
            _awardView.removeEventListener("showtip",__showTip);
            _awardView.removeEventListener("hidetip",__hideTip);
         }
         if(_rollDiceBtn)
         {
            _rollDiceBtn.removeEventListener("click",__rollDiceFunc);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__openHelpFrame);
         }
         if(_time)
         {
            _time.removeEventListener("timer",count);
         }
      }
      
      private function __showTip(e:SuperWinnerEvent) : void
      {
         var i:* = 0;
         var mode:* = null;
         var awardType:uint = e.resultData as uint;
         var awardsArr:Vector.<Object> = SuperWinnerManager.instance.awardsVector;
         var awards:Vector.<SuperWinnerAwardsMode> = awardsArr[awardType - 1] as Vector.<SuperWinnerAwardsMode>;
         var str:String = "";
         for(i = uint(0); i < awards.length; )
         {
            mode = awards[i];
            str = str + (mode.goodName + " ×" + mode.count);
            if(i < awards.length - 1)
            {
               str = str + "\r";
            }
            i++;
         }
         _awardsTip.tipData = str;
         PositionUtils.setPos(_awardsTip,"superWinner.awardTip" + awardType);
         _awardsTip.visible = true;
      }
      
      private function __hideTip(e:SuperWinnerEvent) : void
      {
         _awardsTip.visible = false;
         _awardsTip.tipData = "";
      }
      
      private function __startRollDices(e:SuperWinnerEvent) : void
      {
         _rollDiceBtn.enable = true;
         _progressBar.playBar();
      }
      
      public function updateTime(second:int) : void
      {
         _remainTime = Math.abs(second);
         var _hours:int = _remainTime / 3600;
         var _minute:int = _remainTime / 60 % 60;
         var _second:int = _remainTime % 60;
         var _roomStr:String = "";
         var str:String = _roomStr + LanguageMgr.GetTranslation("ddt.superWinner.endTimeTxt");
         if(_hours < 10)
         {
            str = str + ("0" + _hours);
         }
         else
         {
            str = str + _hours;
         }
         str = str + "：";
         if(_minute < 10)
         {
            str = str + ("0" + _minute);
         }
         else
         {
            str = str + _minute;
         }
         str = str + "：";
         if(_second < 10)
         {
            str = str + ("0" + _second);
         }
         else
         {
            str = str + _second;
         }
         _endTimeTxt.text = str;
         if(_remainTime == 0)
         {
            if(_time)
            {
               _time.stop();
               _time.removeEventListener("timer",count);
               _time = null;
            }
         }
      }
      
      protected function __openHelpFrame(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var movie:MovieClip = ComponentFactory.Instance.creatCustomObject("asset.superWinner.help");
         var frame:SuperWinnerHelpFrame = ComponentFactory.Instance.creat("ddt.superWinner.helpFrame");
         frame.setView(movie);
         frame.submitButtonPos = "superWinner.helpFrame.submitBtnPos";
         frame.titleText = LanguageMgr.GetTranslation("store.view.HelpButtonText");
         frame.addEventListener("response",__frameEvent);
         LayerManager.Instance.addToLayer(frame,2,true,1,true);
      }
      
      protected function __frameEvent(event:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var frame:Disposeable = event.target as Disposeable;
         frame.dispose();
         frame = null;
      }
      
      private function __rollDiceFunc(e:MouseEvent) : void
      {
         _rollDiceBtn.enable = false;
         SoundManager.instance.play("008");
         SocketManager.Instance.out.rollDiceInSuperWinner();
      }
      
      private function __progressTimesUp(e:SuperWinnerEvent) : void
      {
         _rollDiceBtn.enable = false;
         showLastDices();
         _dicesMovie.resetDice();
         _progressBar.resetProgressBar();
      }
      
      private function __sendNotice(e:SuperWinnerEvent) : void
      {
         var msg:String = e.resultData as String;
         ChatManager.Instance.sysChatYellow(msg);
      }
      
      private function __championChange(e:SuperWinnerEvent) : void
      {
         if(_model.isShowChampionMsg)
         {
            showChampionMsg(e.resultData as Boolean);
         }
         noChampionBg.visible = false;
         championBg.visible = true;
         _champion.visible = true;
         _champion.setCellValue(_model.championItem);
         _championDicesbanner.visible = true;
         _championDicesbanner.showLastDices(_model.championDices);
      }
      
      private function __returnDices(e:SuperWinnerEvent) : void
      {
         showSystemMsg();
         if(_model.currentDicePoints)
         {
            _model.lastDicePoints = _model.currentDicePoints;
         }
         if(_model.currentAwardLevel > 0)
         {
            _rollDiceBtn.enable = false;
         }
         _dicesMovie.playMovie(_model.currentDicePoints);
      }
      
      private function showLastDices() : void
      {
         if(_model.lastDicePoints)
         {
            _dicesbanner.visible = true;
            _dicesbanner.showLastDices(_model.lastDicePoints);
         }
      }
      
      private function showSystemMsg() : void
      {
         var str:* = null;
         if(!_model.isCurrentDiceGetAward && _model.currentAwardLevel > 0)
         {
            if(_model.currentAwardLevel == 6)
            {
               str = LanguageMgr.GetTranslation("ddt.superWinner.passTheChampion");
            }
            else
            {
               str = LanguageMgr.GetTranslation("ddt.superWinner.rollRightDiceNoAward",_model.getAwardNameByLevel(_model.currentAwardLevel));
            }
            ChatManager.Instance.sysChatYellow(str);
         }
      }
      
      private function showChampionMsg(hadChampion:Boolean) : void
      {
         var str:* = null;
         if(hadChampion)
         {
            str = LanguageMgr.GetTranslation("ddt.superWinner.biggerThanLastChampion",_model.championItem.NickName);
         }
         else
         {
            str = LanguageMgr.GetTranslation("ddt.superWinner.firstChampion",_model.championItem.NickName);
         }
         ChatManager.Instance.sysChatYellow(str);
      }
      
      private function __onReturn(e:SuperWinnerEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.outSuperWinner();
         StateManager.setState("main");
      }
      
      public function dispose() : void
      {
         removeEvent();
         _contro = null;
         if(_time)
         {
            _time.stop();
            _time = null;
         }
         _model = null;
         _dicesbanner = null;
         _championDicesbanner = null;
         _dicesMovie = null;
         _progressBar = null;
         _rollDiceBtn = null;
         _playerList = null;
         _awardView = null;
         _myAwardView = null;
         _awardsTip = null;
         returnBtn = null;
         _champion = null;
         _chatView = null;
         _endTimeTxt = null;
         _helpBtn = null;
         championBg = null;
         noChampionBg = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
