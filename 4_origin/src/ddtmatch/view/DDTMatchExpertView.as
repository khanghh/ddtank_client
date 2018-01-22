package ddtmatch.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddtmatch.data.AwardInfo;
   import ddtmatch.data.DDTMatchQuestionInfo;
   import ddtmatch.event.DDTMatchEvent;
   import ddtmatch.manager.DDTMatchManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   
   public class DDTMatchExpertView extends Sprite implements Disposeable
   {
      
      private static var SELECT_NUM:int = 4;
       
      
      private var _bg:Bitmap;
      
      private var _winBtn:SimpleBitmapButton;
      
      private var _excludeBtn:SimpleBitmapButton;
      
      private var _doubleBtn:SimpleBitmapButton;
      
      private var _winTxt:FilterFrameText;
      
      private var _excludeTxt:FilterFrameText;
      
      private var _doubleTxt:FilterFrameText;
      
      private var _red1:Bitmap;
      
      private var _red2:Bitmap;
      
      private var _red3:Bitmap;
      
      private var _activityTimeTxt:FilterFrameText;
      
      private var _myrankTxt:FilterFrameText;
      
      private var _myscoreTxt:FilterFrameText;
      
      private var curQuesitionNum:FilterFrameText;
      
      private var curQuesitionCD:FilterFrameText;
      
      private var _question:FilterFrameText;
      
      private var _answer:FilterFrameText;
      
      private var _selectVec:Vector.<MovieImage>;
      
      private var _resultMovie:MovieClip;
      
      private var _totalQuestionNum:int;
      
      private var _doublePrice:int;
      
      private var _hitPrice:int;
      
      private var _excludePrice:int;
      
      private var _doubleFreeCount:int;
      
      private var _hitFreeCount:int;
      
      private var _excludeFreeCount:int;
      
      private var _alertAsk:DDTMatchAlertView;
      
      private var _rankVec:Vector.<DDTMatchExpertItem>;
      
      private var _timer:Timer;
      
      private var _countDownTime:Number;
      
      private var _currentQuestion:DDTMatchQuestionInfo;
      
      private var skillType:int;
      
      private var answerIndex1:int;
      
      private var answerIndex2:int;
      
      public function DDTMatchExpertView()
      {
         _excludePrice = ServerConfigManager.instance.getLightRiddleRemoveErrorMoney();
         super();
         initView();
         addEvent();
         SocketManager.Instance.out.sendLanternRiddlesQuestion();
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc3_:int = 0;
         _bg = ComponentFactory.Instance.creatBitmap("ddtmatch.expertBg");
         addChild(_bg);
         _winBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtmatch.expert.winBtn");
         addChild(_winBtn);
         _excludeBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtmatch.expert.excludeBtn");
         addChild(_excludeBtn);
         _doubleBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtmatch.expert.doubleBtn");
         addChild(_doubleBtn);
         _red1 = ComponentFactory.Instance.creatBitmap("ddtmatch.expert.redPoint");
         _red2 = ComponentFactory.Instance.creatBitmap("ddtmatch.expert.redPoint");
         _red3 = ComponentFactory.Instance.creatBitmap("ddtmatch.expert.redPoint");
         addChild(_red1);
         addChild(_red2);
         addChild(_red3);
         PositionUtils.setPos(_red2,"ddtmatch.expert.red2Pos");
         PositionUtils.setPos(_red3,"ddtmatch.expert.red3Pos");
         _winTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.expert.timesTxt");
         addChild(_winTxt);
         _excludeTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.expert.timesTxt");
         addChild(_excludeTxt);
         PositionUtils.setPos(_excludeTxt,"ddtmatch.expert.excludePos");
         _doubleTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.expert.timesTxt");
         addChild(_doubleTxt);
         PositionUtils.setPos(_doubleTxt,"ddtmatch.expert.doublePos");
         _activityTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.expert.activityTimeTxt");
         addChild(_activityTimeTxt);
         _myrankTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.expert.myinfoTxt");
         addChild(_myrankTxt);
         _myscoreTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.expert.myinfoTxt");
         addChild(_myscoreTxt);
         PositionUtils.setPos(_myscoreTxt,"ddtmatch.expert.myscorePos");
         _rankVec = new Vector.<DDTMatchExpertItem>();
         _loc4_ = 0;
         while(_loc4_ < 8)
         {
            _loc2_ = new DDTMatchExpertItem();
            addChild(_loc2_);
            _loc2_.x = 460;
            _loc2_.y = 189 + _loc4_ * 39;
            _rankVec.push(_loc2_);
            _loc4_++;
         }
         curQuesitionNum = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.expert.curQuesitionNum");
         addChild(curQuesitionNum);
         curQuesitionCD = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.expert.curQuesitionCD");
         addChild(curQuesitionCD);
         _question = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.expert.question");
         addChild(_question);
         _answer = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.expert.answer");
         addChild(_answer);
         _selectVec = new Vector.<MovieImage>();
         _loc3_ = 0;
         while(_loc3_ < SELECT_NUM)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("asset.ddtmatch.expert.select");
            _loc1_.buttonMode = true;
            _loc1_.movie.gotoAndStop(1);
            _loc1_.addEventListener("click",__onSelectClick);
            PositionUtils.setPos(_loc1_,"ddtmatch.expert.selectPos" + _loc3_);
            addChild(_loc1_);
            _selectVec.push(_loc1_);
            _loc3_++;
         }
      }
      
      protected function __onSelectClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         SoundManager.instance.playButtonSound();
         var _loc2_:MovieImage = param1.currentTarget as MovieImage;
         _loc3_ = 0;
         while(_loc3_ < _selectVec.length)
         {
            if(_loc2_ == _selectVec[_loc3_])
            {
               _selectVec[_loc3_].movie.gotoAndStop(2);
               _currentQuestion.Option = _loc3_ + 1;
               SocketManager.Instance.out.sendLanternRiddlesAnswer(_currentQuestion.QuestionID,_currentQuestion.QuestionIndex,_currentQuestion.Option);
            }
            _selectVec[_loc3_].filters = ComponentFactory.Instance.creatFilters("grayFilter");
            _selectVec[_loc3_].removeEventListener("click",__onSelectClick);
            _loc3_++;
         }
         _excludeBtn.enable = false;
      }
      
      private function setCDTime(param1:Date) : void
      {
         _countDownTime = param1.time - TimeManager.Instance.Now().time;
         if(_countDownTime > 0)
         {
            _countDownTime = _countDownTime / 1000;
            curQuesitionCD.visible = true;
            curQuesitionCD.text = LanguageMgr.GetTranslation("ddt.DDTMatch.expertView.currentQuestionCD",transSecond(_countDownTime));
            if(!_timer)
            {
               _timer = new Timer(1000);
               _timer.addEventListener("timer",__onTimer);
            }
            _timer.start();
         }
         else
         {
            curQuesitionCD.visible = false;
            if(_timer)
            {
               _timer.stop();
               _timer.reset();
            }
         }
      }
      
      private function __onTimer(param1:TimerEvent) : void
      {
         _countDownTime = Number(_countDownTime) - 1;
         if(_countDownTime < 0)
         {
            _timer.stop();
            _timer.reset();
            _timer.removeEventListener("timer",__onTimer);
            _timer = null;
         }
         else if(curQuesitionCD)
         {
            curQuesitionCD.text = LanguageMgr.GetTranslation("ddt.DDTMatch.expertView.currentQuestionCD",transSecond(_countDownTime));
         }
      }
      
      private function setQuestion(param1:DDTMatchQuestionInfo) : void
      {
         _currentQuestion = param1;
         curQuesitionNum.text = LanguageMgr.GetTranslation("ddt.DDTMatch.expertView.currentQuestion",param1.QuestionIndex,_totalQuestionNum);
         _question.text = param1.QuestionContent;
         _answer.text = LanguageMgr.GetTranslation("ddt.DDTMatch.expert.answer",param1.Option1,param1.Option2,param1.Option3,param1.Option4);
         setCDTime(param1.EndDate);
         setAnswerFlag(param1.Option);
      }
      
      private function transSecond(param1:Number) : String
      {
         return (String("0" + Math.floor(param1 % 60))).substr(-2);
      }
      
      private function addEvent() : void
      {
         _doubleBtn.addEventListener("click",_btnclickHandler);
         _excludeBtn.addEventListener("click",_btnclickHandler);
         _winBtn.addEventListener("click",_btnclickHandler);
         DDTMatchManager.instance.addEventListener("lanternRiddles_question",__onSetQuestionInfo);
         DDTMatchManager.instance.addEventListener("lanternRiddles_rankinfo",__onSetRankInfo);
         DDTMatchManager.instance.addEventListener("lanternRiddles_skill",__onSetBtnEnable);
         DDTMatchManager.instance.addEventListener("lanternRiddles_answer",__onAnswerResult);
      }
      
      protected function __onSetBtnEnable(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:Boolean = _loc3_.readBoolean();
         skillType = _loc3_.readInt();
         answerIndex1 = _loc3_.readInt();
         answerIndex2 = _loc3_.readInt();
         if(skillType == 1)
         {
            setSelectBtnEnable(false);
            _winBtn.enable = !_loc2_;
            _excludeBtn.enable = !_loc2_;
         }
         else if(skillType == 2)
         {
            _doubleBtn.enable = !_loc2_;
         }
         else if(skillType == 3)
         {
            _excludeBtn.enable = !_loc2_;
            if(_loc2_)
            {
               _selectVec[answerIndex1 - 1].movie.gotoAndStop(1);
               _selectVec[answerIndex1 - 1].filters = ComponentFactory.Instance.creatFilters("grayFilter");
               _selectVec[answerIndex1 - 1].removeEventListener("click",__onSelectClick);
               _selectVec[answerIndex2 - 1].movie.gotoAndStop(1);
               _selectVec[answerIndex2 - 1].filters = ComponentFactory.Instance.creatFilters("grayFilter");
               _selectVec[answerIndex2 - 1].removeEventListener("click",__onSelectClick);
            }
         }
      }
      
      protected function __onSetQuestionInfo(param1:CrazyTankSocketEvent) : void
      {
         var _loc9_:* = null;
         var _loc5_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc3_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:PackageIn = param1.pkg;
         var _loc4_:int = _loc8_.readInt();
         var _loc6_:int = _loc8_.readInt();
         var _loc12_:DDTMatchQuestionInfo = DDTMatchManager.instance.info[_loc6_];
         if(_loc12_)
         {
            _totalQuestionNum = _loc8_.readInt();
            _loc9_ = _loc8_.readDate();
            _doubleFreeCount = _loc8_.readInt();
            _doublePrice = _loc8_.readInt();
            _hitFreeCount = _loc8_.readInt();
            _hitPrice = _loc8_.readInt();
            _loc5_ = _loc8_.readInt();
            _myscoreTxt.text = _loc5_.toString();
            _loc10_ = _loc8_.readInt();
            _loc11_ = _loc8_.readInt();
            _loc3_ = _loc8_.readBoolean();
            _loc2_ = _loc8_.readBoolean();
            _excludeFreeCount = _loc8_.readInt();
            _loc7_ = _loc8_.readBoolean();
            answerIndex1 = _loc8_.readInt();
            answerIndex2 = _loc8_.readInt();
            _loc12_.QuestionIndex = _loc4_;
            _loc12_.QuestionID = _loc6_;
            _loc12_.Option = _loc11_;
            _loc12_.EndDate = _loc9_;
            setSelectBtnEnable(true);
            setQuestion(_loc12_);
            _winTxt.text = String(_hitFreeCount);
            _excludeTxt.text = String(_excludeFreeCount);
            _doubleTxt.text = String(_doubleFreeCount);
            if(_countDownTime > 0)
            {
               _doubleBtn.enable = !_loc2_;
               _winBtn.enable = !_loc3_;
               _excludeBtn.enable = !!_loc3_?false:!_loc7_;
               if(!_winBtn.enable)
               {
                  setSelectBtnEnable(false);
               }
            }
            else
            {
               setSelectBtnEnable(false);
               _doubleBtn.enable = false;
               _winBtn.enable = false;
               _excludeBtn.enable = false;
            }
            SocketManager.Instance.out.sendLanternRiddlesRankInfo();
            if(_alertAsk)
            {
               _alertAsk.dispose();
               _alertAsk = null;
            }
         }
      }
      
      protected function __onSetRankInfo(param1:CrazyTankSocketEvent) : void
      {
         var _loc10_:int = 0;
         var _loc9_:* = null;
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc5_:PackageIn = param1.pkg;
         var _loc8_:Array = [];
         _myrankTxt.text = String(_loc5_.readInt());
         var _loc4_:int = _loc5_.readInt();
         _loc10_ = 0;
         while(_loc10_ < _loc4_)
         {
            _loc9_ = new DDTMatchQuestionInfo();
            _loc9_.Rank = _loc5_.readInt();
            _loc9_.NickName = _loc5_.readUTF();
            _loc9_.TypeVIP = _loc5_.readByte();
            _loc9_.Integer = _loc5_.readInt();
            _loc2_ = _loc5_.readInt();
            _loc7_ = 0;
            while(_loc7_ < _loc2_)
            {
               _loc3_ = new AwardInfo();
               _loc3_.TempId = _loc5_.readInt();
               _loc3_.AwardNum = _loc5_.readInt();
               _loc3_.IsBind = _loc5_.readBoolean();
               _loc3_.ValidDate = _loc5_.readInt();
               _loc9_.AwardInfoVec.push(_loc3_);
               _loc7_++;
            }
            _loc8_.push(_loc9_);
            _loc10_++;
         }
         _loc8_.sortOn("Rank",16);
         _loc6_ = 0;
         while(_loc6_ < _loc8_.length)
         {
            _rankVec[_loc6_].info = _loc8_[_loc6_];
            _loc6_++;
         }
      }
      
      protected function __onAnswerResult(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc3_:Boolean = _loc4_.readBoolean();
         var _loc2_:Boolean = _loc4_.readBoolean();
         var _loc6_:int = _loc4_.readInt();
         var _loc5_:String = _loc4_.readUTF();
         if(_loc2_)
         {
            setAnswerFlag(_loc6_);
         }
         if(_loc3_)
         {
            _resultMovie = ComponentFactory.Instance.creat("ddtmatch.expert.correct");
         }
         else
         {
            _resultMovie = ComponentFactory.Instance.creat("ddtmatch.expert.error");
         }
         LayerManager.Instance.addToLayer(_resultMovie,0,false,1);
         _resultMovie["result"]["awardText"].autoSize = "center";
         _resultMovie["result"]["awardText"].text = _loc5_;
         _resultMovie.x = (StageReferance.stage.stageWidth - _resultMovie.width) / 2;
         _resultMovie.y = 290;
         addEventListener("enterFrame",__onEnterFrame);
      }
      
      private function setAnswerFlag(param1:int) : void
      {
         if(param1 > 0)
         {
            setSelectBtnEnable(false);
            _selectVec[param1 - 1].movie.gotoAndStop(2);
         }
      }
      
      public function setSelectBtnEnable(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _selectVec.length)
         {
            _selectVec[_loc2_].movie.gotoAndStop(1);
            if(param1)
            {
               if(answerIndex1 == _loc2_ + 1 || answerIndex2 == _loc2_ + 1)
               {
                  _selectVec[_loc2_].filters = ComponentFactory.Instance.creatFilters("grayFilter");
                  _selectVec[_loc2_].removeEventListener("click",__onSelectClick);
               }
               else
               {
                  _selectVec[_loc2_].filters = null;
                  _selectVec[_loc2_].addEventListener("click",__onSelectClick);
               }
            }
            else
            {
               _selectVec[_loc2_].filters = ComponentFactory.Instance.creatFilters("grayFilter");
               _selectVec[_loc2_].removeEventListener("click",__onSelectClick);
            }
            _loc2_++;
         }
      }
      
      protected function __onEnterFrame(param1:Event) : void
      {
         if(_resultMovie && _resultMovie.parent && _resultMovie.currentFrame == 40)
         {
            _resultMovie.parent.removeChild(_resultMovie);
            _resultMovie = null;
            removeEventListener("enterFrame",__onEnterFrame);
         }
      }
      
      private function _btnclickHandler(param1:MouseEvent) : void
      {
         if(!DDTMatchManager.instance.expertIsBegin)
         {
            return;
         }
         var _loc2_:* = param1.currentTarget;
         if(_winBtn !== _loc2_)
         {
            if(_excludeBtn !== _loc2_)
            {
               if(_doubleBtn === _loc2_)
               {
                  skillType = 2;
                  if(_doubleFreeCount <= 0)
                  {
                     if(!SharedManager.Instance.isBuyInteger)
                     {
                        if(PlayerManager.Instance.Self.bagLocked)
                        {
                           BaglockedManager.Instance.show();
                           return;
                        }
                        _alertAsk = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.expert.alertView");
                        _alertAsk.text = LanguageMgr.GetTranslation("ddt.DDTmatch.expert.buyDouble.alertInfo",_doublePrice);
                        LayerManager.Instance.addToLayer(_alertAsk,3,true,1);
                        _alertAsk.addEventListener("expertSelect",__onAlertSelect);
                        _alertAsk.addEventListener("response",__onBuyHandle);
                     }
                     else if(payment(SharedManager.Instance.isBuyIntegerBind))
                     {
                        SocketManager.Instance.out.sendLanternRiddlesUseSkill(_currentQuestion.QuestionID,_currentQuestion.QuestionIndex,1,SharedManager.Instance.isBuyIntegerBind);
                     }
                  }
                  else if(!_winBtn.enable || _currentQuestion.Option != 0)
                  {
                     SocketManager.Instance.out.sendLanternRiddlesUseSkill(_currentQuestion.QuestionID,_currentQuestion.QuestionIndex,1);
                  }
                  else
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("lanternRiddles.view.doubleClick.tipsInfo"));
                  }
               }
            }
            else
            {
               skillType = 3;
               if(_excludeFreeCount <= 0)
               {
                  if(!SharedManager.Instance.isBuyHit)
                  {
                     if(PlayerManager.Instance.Self.bagLocked)
                     {
                        BaglockedManager.Instance.show();
                        return;
                     }
                     _alertAsk = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.expert.alertView");
                     _alertAsk.text = LanguageMgr.GetTranslation("ddt.DDTmatch.expert.buyexclude.alertInfo",_excludePrice);
                     LayerManager.Instance.addToLayer(_alertAsk,3,true,1);
                     _alertAsk.addEventListener("expertSelect",__onAlertSelect);
                     _alertAsk.addEventListener("response",__onBuyHandle);
                  }
                  else if(payment(SharedManager.Instance.isBuyexcludeBind))
                  {
                     SocketManager.Instance.out.sendLanternRiddlesUseSkill(_currentQuestion.QuestionID,_currentQuestion.QuestionIndex,2,SharedManager.Instance.isBuyexcludeBind);
                  }
               }
               else
               {
                  SocketManager.Instance.out.sendLanternRiddlesUseSkill(_currentQuestion.QuestionID,_currentQuestion.QuestionIndex,2);
               }
            }
         }
         else
         {
            skillType = 1;
            if(_hitFreeCount <= 0)
            {
               if(!SharedManager.Instance.isBuyHit)
               {
                  if(PlayerManager.Instance.Self.bagLocked)
                  {
                     BaglockedManager.Instance.show();
                     return;
                  }
                  _alertAsk = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.expert.alertView");
                  _alertAsk.text = LanguageMgr.GetTranslation("ddt.DDTmatch.expert.buyWin.alertInfo",_hitPrice);
                  LayerManager.Instance.addToLayer(_alertAsk,3,true,1);
                  _alertAsk.addEventListener("expertSelect",__onAlertSelect);
                  _alertAsk.addEventListener("response",__onBuyHandle);
               }
               else
               {
                  if(payment(SharedManager.Instance.isBuyHitBind))
                  {
                     SocketManager.Instance.out.sendLanternRiddlesUseSkill(_currentQuestion.QuestionID,_currentQuestion.QuestionIndex,0,SharedManager.Instance.isBuyHitBind);
                  }
                  _winBtn.enable = false;
               }
            }
            else
            {
               SocketManager.Instance.out.sendLanternRiddlesUseSkill(_currentQuestion.QuestionID,_currentQuestion.QuestionIndex,0);
               _winBtn.enable = false;
            }
         }
      }
      
      private function payment(param1:Boolean) : Boolean
      {
         var _loc2_:* = null;
         if(param1)
         {
            if(!checkMoney(true))
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("buried.alertInfo.noBindMoney"),"",LanguageMgr.GetTranslation("cancel"),true,false,false,2);
               _loc2_.addEventListener("response",onResponseHander);
               return false;
            }
         }
         else if(!checkMoney(false))
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            _loc2_.addEventListener("response",_response);
            return false;
         }
         return true;
      }
      
      private function _response(param1:FrameEvent) : void
      {
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_response);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function onResponseHander(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",onResponseHander);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            if(!checkMoney(false))
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               _loc2_.addEventListener("response",_response);
               return;
            }
            SocketManager.Instance.out.sendLanternRiddlesUseSkill(_currentQuestion.QuestionID,_currentQuestion.QuestionIndex,skillType - 1,false);
         }
         param1.currentTarget.dispose();
      }
      
      private function checkMoney(param1:Boolean) : Boolean
      {
         var _loc2_:int = 0;
         if(skillType == 1)
         {
            _loc2_ = _hitPrice;
         }
         else if(skillType == 2)
         {
            _loc2_ = _doublePrice;
         }
         else if(skillType == 3)
         {
            _loc2_ = _excludePrice;
         }
         if(param1)
         {
            if(PlayerManager.Instance.Self.BandMoney < _loc2_)
            {
               return false;
            }
         }
         else if(PlayerManager.Instance.Self.Money < _loc2_)
         {
            return false;
         }
         return true;
      }
      
      protected function __onBuyHandle(param1:FrameEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("expertSelect",__onAlertSelect);
         _loc2_.removeEventListener("response",__onBuyHandle);
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(skillType == 1)
               {
                  SharedManager.Instance.isBuyHitBind = _loc2_.isBand;
                  _loc3_ = _hitPrice;
               }
               else if(skillType == 2)
               {
                  SharedManager.Instance.isBuyIntegerBind = _loc2_.isBand;
                  _loc3_ = _doublePrice;
               }
               else if(skillType == 3)
               {
                  SharedManager.Instance.isBuyexcludeBind = _loc2_.isBand;
                  _loc3_ = _excludePrice;
               }
               if(payment(_loc2_.isBand) && PlayerManager.Instance.Self.Money >= _loc3_)
               {
                  SocketManager.Instance.out.sendLanternRiddlesUseSkill(_currentQuestion.QuestionID,_currentQuestion.QuestionIndex,skillType - 1,_loc2_.isBand);
               }
               _winBtn.enable = false;
         }
         _loc2_.dispose();
         _loc2_ = null;
      }
      
      protected function __onAlertSelect(param1:DDTMatchEvent) : void
      {
         setBindFlag(param1.flag);
      }
      
      private function setBindFlag(param1:Boolean) : void
      {
         if(skillType == 1)
         {
            SharedManager.Instance.isBuyHit = param1;
         }
         else if(skillType == 2)
         {
            SharedManager.Instance.isBuyInteger = param1;
         }
         else if(skillType == 3)
         {
            SharedManager.Instance.isBuyexclude = param1;
         }
      }
      
      private function removeEvent() : void
      {
         _doubleBtn.removeEventListener("click",_btnclickHandler);
         _excludeBtn.removeEventListener("click",_btnclickHandler);
         _winBtn.removeEventListener("click",_btnclickHandler);
         DDTMatchManager.instance.removeEventListener("lanternRiddles_question",__onSetQuestionInfo);
         DDTMatchManager.instance.removeEventListener("lanternRiddles_rankinfo",__onSetRankInfo);
         DDTMatchManager.instance.removeEventListener("lanternRiddles_skill",__onSetBtnEnable);
         DDTMatchManager.instance.removeEventListener("lanternRiddles_answer",__onAnswerResult);
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         ObjectUtils.disposeObject(_doubleBtn);
         _doubleBtn = null;
         ObjectUtils.disposeObject(_excludeBtn);
         _excludeBtn = null;
         ObjectUtils.disposeObject(_winBtn);
         _winBtn = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_winTxt);
         _winTxt = null;
         ObjectUtils.disposeObject(_excludeTxt);
         _excludeTxt = null;
         ObjectUtils.disposeObject(_doubleTxt);
         _doubleTxt = null;
         ObjectUtils.disposeObject(_activityTimeTxt);
         _activityTimeTxt = null;
         ObjectUtils.disposeObject(_myrankTxt);
         _myrankTxt = null;
         ObjectUtils.disposeObject(_myscoreTxt);
         _myscoreTxt = null;
         ObjectUtils.disposeObject(_red1);
         _red1 = null;
         ObjectUtils.disposeObject(_red2);
         _red2 = null;
         ObjectUtils.disposeObject(_red3);
         _red3 = null;
         ObjectUtils.disposeObject(curQuesitionNum);
         curQuesitionNum = null;
         ObjectUtils.disposeObject(curQuesitionCD);
         curQuesitionCD = null;
         ObjectUtils.disposeObject(_question);
         _question = null;
         ObjectUtils.disposeObject(_answer);
         _answer = null;
         if(_selectVec)
         {
            _loc1_ = 0;
            while(_loc1_ < _selectVec.length)
            {
               _selectVec[_loc1_].removeEventListener("click",__onSelectClick);
               _selectVec[_loc1_].dispose();
               _selectVec[_loc1_] = null;
               _loc1_++;
            }
            _selectVec.length = 0;
            _selectVec = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
