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
      
      public function SuperWinnerView(param1:SuperWinnerController)
      {
         _time = new Timer(1000);
         this._contro = param1;
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
      
      private function count(param1:Event) : void
      {
         if(!_model.endData)
         {
            return;
         }
         var _loc2_:int = TimeManager.Instance.TotalSecondToNow(_model.endData);
         updateTime(_loc2_);
      }
      
      public function endGame() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            _loc3_ = _loc3_ + _model.awards[_loc4_];
            _loc4_++;
         }
         if(_loc3_ == 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("ddt.superWinner.endTxt1");
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("ddt.superWinner.endTxt2");
         }
         var _loc1_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc2_,LanguageMgr.GetTranslation("ok"),"",false,true,true,2);
         _loc1_.cancelButtonEnable = false;
         _loc1_.addEventListener("response",outRoom);
         count30s(_loc1_);
      }
      
      private function count30s(param1:BaseAlerFrame) : void
      {
         alertFrame = param1;
         cot = setTimeout(function():void
         {
            clearTimeout(cot);
            alertFrame.dispatchEvent(new FrameEvent(1));
         },30000);
      }
      
      private function outRoom(param1:FrameEvent) : void
      {
         if(cot)
         {
            clearTimeout(cot);
         }
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",outRoom);
         _loc2_.dispose();
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
      
      private function __showTip(param1:SuperWinnerEvent) : void
      {
         var _loc7_:* = 0;
         var _loc6_:* = null;
         var _loc2_:uint = param1.resultData as uint;
         var _loc5_:Vector.<Object> = SuperWinnerManager.instance.awardsVector;
         var _loc4_:Vector.<SuperWinnerAwardsMode> = _loc5_[_loc2_ - 1] as Vector.<SuperWinnerAwardsMode>;
         var _loc3_:String = "";
         _loc7_ = uint(0);
         while(_loc7_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc7_];
            _loc3_ = _loc3_ + (_loc6_.goodName + " ×" + _loc6_.count);
            if(_loc7_ < _loc4_.length - 1)
            {
               _loc3_ = _loc3_ + "\r";
            }
            _loc7_++;
         }
         _awardsTip.tipData = _loc3_;
         PositionUtils.setPos(_awardsTip,"superWinner.awardTip" + _loc2_);
         _awardsTip.visible = true;
      }
      
      private function __hideTip(param1:SuperWinnerEvent) : void
      {
         _awardsTip.visible = false;
         _awardsTip.tipData = "";
      }
      
      private function __startRollDices(param1:SuperWinnerEvent) : void
      {
         _rollDiceBtn.enable = true;
         _progressBar.playBar();
      }
      
      public function updateTime(param1:int) : void
      {
         _remainTime = Math.abs(param1);
         var _loc3_:int = _remainTime / 3600;
         var _loc2_:int = _remainTime / 60 % 60;
         var _loc6_:int = _remainTime % 60;
         var _loc4_:String = "";
         var _loc5_:String = _loc4_ + LanguageMgr.GetTranslation("ddt.superWinner.endTimeTxt");
         if(_loc3_ < 10)
         {
            _loc5_ = _loc5_ + ("0" + _loc3_);
         }
         else
         {
            _loc5_ = _loc5_ + _loc3_;
         }
         _loc5_ = _loc5_ + "：";
         if(_loc2_ < 10)
         {
            _loc5_ = _loc5_ + ("0" + _loc2_);
         }
         else
         {
            _loc5_ = _loc5_ + _loc2_;
         }
         _loc5_ = _loc5_ + "：";
         if(_loc6_ < 10)
         {
            _loc5_ = _loc5_ + ("0" + _loc6_);
         }
         else
         {
            _loc5_ = _loc5_ + _loc6_;
         }
         _endTimeTxt.text = _loc5_;
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
      
      protected function __openHelpFrame(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc3_:MovieClip = ComponentFactory.Instance.creatCustomObject("asset.superWinner.help");
         var _loc2_:SuperWinnerHelpFrame = ComponentFactory.Instance.creat("ddt.superWinner.helpFrame");
         _loc2_.setView(_loc3_);
         _loc2_.submitButtonPos = "superWinner.helpFrame.submitBtnPos";
         _loc2_.titleText = LanguageMgr.GetTranslation("store.view.HelpButtonText");
         _loc2_.addEventListener("response",__frameEvent);
         LayerManager.Instance.addToLayer(_loc2_,2,true,1,true);
      }
      
      protected function __frameEvent(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:Disposeable = param1.target as Disposeable;
         _loc2_.dispose();
         _loc2_ = null;
      }
      
      private function __rollDiceFunc(param1:MouseEvent) : void
      {
         _rollDiceBtn.enable = false;
         SoundManager.instance.play("008");
         SocketManager.Instance.out.rollDiceInSuperWinner();
      }
      
      private function __progressTimesUp(param1:SuperWinnerEvent) : void
      {
         _rollDiceBtn.enable = false;
         showLastDices();
         _dicesMovie.resetDice();
         _progressBar.resetProgressBar();
      }
      
      private function __sendNotice(param1:SuperWinnerEvent) : void
      {
         var _loc2_:String = param1.resultData as String;
         ChatManager.Instance.sysChatYellow(_loc2_);
      }
      
      private function __championChange(param1:SuperWinnerEvent) : void
      {
         if(_model.isShowChampionMsg)
         {
            showChampionMsg(param1.resultData as Boolean);
         }
         noChampionBg.visible = false;
         championBg.visible = true;
         _champion.visible = true;
         _champion.setCellValue(_model.championItem);
         _championDicesbanner.visible = true;
         _championDicesbanner.showLastDices(_model.championDices);
      }
      
      private function __returnDices(param1:SuperWinnerEvent) : void
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
         var _loc1_:* = null;
         if(!_model.isCurrentDiceGetAward && _model.currentAwardLevel > 0)
         {
            if(_model.currentAwardLevel == 6)
            {
               _loc1_ = LanguageMgr.GetTranslation("ddt.superWinner.passTheChampion");
            }
            else
            {
               _loc1_ = LanguageMgr.GetTranslation("ddt.superWinner.rollRightDiceNoAward",_model.getAwardNameByLevel(_model.currentAwardLevel));
            }
            ChatManager.Instance.sysChatYellow(_loc1_);
         }
      }
      
      private function showChampionMsg(param1:Boolean) : void
      {
         var _loc2_:* = null;
         if(param1)
         {
            _loc2_ = LanguageMgr.GetTranslation("ddt.superWinner.biggerThanLastChampion",_model.championItem.NickName);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("ddt.superWinner.firstChampion",_model.championItem.NickName);
         }
         ChatManager.Instance.sysChatYellow(_loc2_);
      }
      
      private function __onReturn(param1:SuperWinnerEvent) : void
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
