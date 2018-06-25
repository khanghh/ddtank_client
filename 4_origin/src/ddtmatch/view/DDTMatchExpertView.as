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
         var i:int = 0;
         var item:* = null;
         var select:* = null;
         var j:int = 0;
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
         for(i = 0; i < 8; )
         {
            item = new DDTMatchExpertItem();
            addChild(item);
            item.x = 460;
            item.y = 189 + i * 39;
            _rankVec.push(item);
            i++;
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
         for(j = 0; j < SELECT_NUM; )
         {
            select = ComponentFactory.Instance.creatComponentByStylename("asset.ddtmatch.expert.select");
            select.buttonMode = true;
            select.movie.gotoAndStop(1);
            select.addEventListener("click",__onSelectClick);
            PositionUtils.setPos(select,"ddtmatch.expert.selectPos" + j);
            addChild(select);
            _selectVec.push(select);
            j++;
         }
      }
      
      protected function __onSelectClick(event:MouseEvent) : void
      {
         var i:int = 0;
         SoundManager.instance.playButtonSound();
         var select:MovieImage = event.currentTarget as MovieImage;
         for(i = 0; i < _selectVec.length; )
         {
            if(select == _selectVec[i])
            {
               _selectVec[i].movie.gotoAndStop(2);
               _currentQuestion.Option = i + 1;
               SocketManager.Instance.out.sendLanternRiddlesAnswer(_currentQuestion.QuestionID,_currentQuestion.QuestionIndex,_currentQuestion.Option);
            }
            _selectVec[i].filters = ComponentFactory.Instance.creatFilters("grayFilter");
            _selectVec[i].removeEventListener("click",__onSelectClick);
            i++;
         }
         _excludeBtn.enable = false;
      }
      
      private function setCDTime(date:Date) : void
      {
         _countDownTime = date.time - TimeManager.Instance.Now().time;
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
      
      private function __onTimer(event:TimerEvent) : void
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
      
      private function setQuestion(info:DDTMatchQuestionInfo) : void
      {
         _currentQuestion = info;
         curQuesitionNum.text = LanguageMgr.GetTranslation("ddt.DDTMatch.expertView.currentQuestion",info.QuestionIndex,_totalQuestionNum);
         _question.text = info.QuestionContent;
         _answer.text = LanguageMgr.GetTranslation("ddt.DDTMatch.expert.answer",info.Option1,info.Option2,info.Option3,info.Option4);
         setCDTime(info.EndDate);
         setAnswerFlag(info.Option);
      }
      
      private function transSecond(num:Number) : String
      {
         return (String("0" + Math.floor(num % 60))).substr(-2);
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
      
      protected function __onSetBtnEnable(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var flag:Boolean = pkg.readBoolean();
         skillType = pkg.readInt();
         answerIndex1 = pkg.readInt();
         answerIndex2 = pkg.readInt();
         if(skillType == 1)
         {
            setSelectBtnEnable(false);
            _winBtn.enable = !flag;
            _excludeBtn.enable = !flag;
         }
         else if(skillType == 2)
         {
            _doubleBtn.enable = !flag;
         }
         else if(skillType == 3)
         {
            _excludeBtn.enable = !flag;
            if(flag)
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
      
      protected function __onSetQuestionInfo(event:CrazyTankSocketEvent) : void
      {
         var endDate:* = null;
         var integer:int = 0;
         var rightNum:int = 0;
         var option:int = 0;
         var hitFlag:Boolean = false;
         var doubleFlag:Boolean = false;
         var excludeCountFlag:Boolean = false;
         var pkg:PackageIn = event.pkg;
         var index:int = pkg.readInt();
         var questionID:int = pkg.readInt();
         var info:DDTMatchQuestionInfo = DDTMatchManager.instance.info[questionID];
         if(info)
         {
            _totalQuestionNum = pkg.readInt();
            endDate = pkg.readDate();
            _doubleFreeCount = pkg.readInt();
            _doublePrice = pkg.readInt();
            _hitFreeCount = pkg.readInt();
            _hitPrice = pkg.readInt();
            integer = pkg.readInt();
            _myscoreTxt.text = integer.toString();
            rightNum = pkg.readInt();
            option = pkg.readInt();
            hitFlag = pkg.readBoolean();
            doubleFlag = pkg.readBoolean();
            _excludeFreeCount = pkg.readInt();
            excludeCountFlag = pkg.readBoolean();
            answerIndex1 = pkg.readInt();
            answerIndex2 = pkg.readInt();
            info.QuestionIndex = index;
            info.QuestionID = questionID;
            info.Option = option;
            info.EndDate = endDate;
            setSelectBtnEnable(true);
            setQuestion(info);
            _winTxt.text = String(_hitFreeCount);
            _excludeTxt.text = String(_excludeFreeCount);
            _doubleTxt.text = String(_doubleFreeCount);
            if(_countDownTime > 0)
            {
               _doubleBtn.enable = !doubleFlag;
               _winBtn.enable = !hitFlag;
               _excludeBtn.enable = !!hitFlag?false:!excludeCountFlag;
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
      
      protected function __onSetRankInfo(event:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var rankInfo:* = null;
         var awardNum:int = 0;
         var j:int = 0;
         var awardInfo:* = null;
         var m:int = 0;
         var pkg:PackageIn = event.pkg;
         var infoArray:Array = [];
         _myrankTxt.text = String(pkg.readInt());
         var length:int = pkg.readInt();
         for(i = 0; i < length; )
         {
            rankInfo = new DDTMatchQuestionInfo();
            rankInfo.Rank = pkg.readInt();
            rankInfo.NickName = pkg.readUTF();
            rankInfo.TypeVIP = pkg.readByte();
            rankInfo.Integer = pkg.readInt();
            awardNum = pkg.readInt();
            for(j = 0; j < awardNum; )
            {
               awardInfo = new AwardInfo();
               awardInfo.TempId = pkg.readInt();
               awardInfo.AwardNum = pkg.readInt();
               awardInfo.IsBind = pkg.readBoolean();
               awardInfo.ValidDate = pkg.readInt();
               rankInfo.AwardInfoVec.push(awardInfo);
               j++;
            }
            infoArray.push(rankInfo);
            i++;
         }
         infoArray.sortOn("Rank",16);
         for(m = 0; m < infoArray.length; )
         {
            _rankVec[m].info = infoArray[m];
            m++;
         }
      }
      
      protected function __onAnswerResult(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var correct:Boolean = pkg.readBoolean();
         var hitFlag:Boolean = pkg.readBoolean();
         var option:int = pkg.readInt();
         var msg:String = pkg.readUTF();
         if(hitFlag)
         {
            setAnswerFlag(option);
         }
         if(correct)
         {
            _resultMovie = ComponentFactory.Instance.creat("ddtmatch.expert.correct");
         }
         else
         {
            _resultMovie = ComponentFactory.Instance.creat("ddtmatch.expert.error");
         }
         LayerManager.Instance.addToLayer(_resultMovie,0,false,1);
         _resultMovie["result"]["awardText"].autoSize = "center";
         _resultMovie["result"]["awardText"].text = msg;
         _resultMovie.x = (StageReferance.stage.stageWidth - _resultMovie.width) / 2;
         _resultMovie.y = 290;
         addEventListener("enterFrame",__onEnterFrame);
      }
      
      private function setAnswerFlag(option:int) : void
      {
         if(option > 0)
         {
            setSelectBtnEnable(false);
            _selectVec[option - 1].movie.gotoAndStop(2);
         }
      }
      
      public function setSelectBtnEnable(flag:Boolean) : void
      {
         var i:int = 0;
         for(i = 0; i < _selectVec.length; )
         {
            _selectVec[i].movie.gotoAndStop(1);
            if(flag)
            {
               if(answerIndex1 == i + 1 || answerIndex2 == i + 1)
               {
                  _selectVec[i].filters = ComponentFactory.Instance.creatFilters("grayFilter");
                  _selectVec[i].removeEventListener("click",__onSelectClick);
               }
               else
               {
                  _selectVec[i].filters = null;
                  _selectVec[i].addEventListener("click",__onSelectClick);
               }
            }
            else
            {
               _selectVec[i].filters = ComponentFactory.Instance.creatFilters("grayFilter");
               _selectVec[i].removeEventListener("click",__onSelectClick);
            }
            i++;
         }
      }
      
      protected function __onEnterFrame(event:Event) : void
      {
         if(_resultMovie && _resultMovie.parent && _resultMovie.currentFrame == 40)
         {
            _resultMovie.parent.removeChild(_resultMovie);
            _resultMovie = null;
            removeEventListener("enterFrame",__onEnterFrame);
         }
      }
      
      private function _btnclickHandler(e:MouseEvent) : void
      {
         if(!DDTMatchManager.instance.expertIsBegin)
         {
            return;
         }
         var _loc2_:* = e.currentTarget;
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
      
      private function payment(isBand:Boolean) : Boolean
      {
         var alertFrame:* = null;
         if(isBand)
         {
            if(!checkMoney(true))
            {
               alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("buried.alertInfo.noBindMoney"),"",LanguageMgr.GetTranslation("cancel"),true,false,false,2);
               alertFrame.addEventListener("response",onResponseHander);
               return false;
            }
         }
         else if(!checkMoney(false))
         {
            alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            alertFrame.addEventListener("response",_response);
            return false;
         }
         return true;
      }
      
      private function _response(evt:FrameEvent) : void
      {
         (evt.currentTarget as BaseAlerFrame).removeEventListener("response",_response);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(evt.currentTarget);
      }
      
      private function onResponseHander(e:FrameEvent) : void
      {
         var alertFrame:* = null;
         (e.currentTarget as BaseAlerFrame).removeEventListener("response",onResponseHander);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            if(!checkMoney(false))
            {
               alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               alertFrame.addEventListener("response",_response);
               return;
            }
            SocketManager.Instance.out.sendLanternRiddlesUseSkill(_currentQuestion.QuestionID,_currentQuestion.QuestionIndex,skillType - 1,false);
         }
         e.currentTarget.dispose();
      }
      
      private function checkMoney(isBand:Boolean) : Boolean
      {
         var money:int = 0;
         if(skillType == 1)
         {
            money = _hitPrice;
         }
         else if(skillType == 2)
         {
            money = _doublePrice;
         }
         else if(skillType == 3)
         {
            money = _excludePrice;
         }
         if(isBand)
         {
            if(PlayerManager.Instance.Self.BandMoney < money)
            {
               return false;
            }
         }
         else if(PlayerManager.Instance.Self.Money < money)
         {
            return false;
         }
         return true;
      }
      
      protected function __onBuyHandle(event:FrameEvent) : void
      {
         var money:int = 0;
         var frame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         frame.removeEventListener("expertSelect",__onAlertSelect);
         frame.removeEventListener("response",__onBuyHandle);
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               if(skillType == 1)
               {
                  SharedManager.Instance.isBuyHitBind = frame.isBand;
                  money = _hitPrice;
               }
               else if(skillType == 2)
               {
                  SharedManager.Instance.isBuyIntegerBind = frame.isBand;
                  money = _doublePrice;
               }
               else if(skillType == 3)
               {
                  SharedManager.Instance.isBuyexcludeBind = frame.isBand;
                  money = _excludePrice;
               }
               if(payment(frame.isBand) && PlayerManager.Instance.Self.Money >= money)
               {
                  SocketManager.Instance.out.sendLanternRiddlesUseSkill(_currentQuestion.QuestionID,_currentQuestion.QuestionIndex,skillType - 1,frame.isBand);
               }
               _winBtn.enable = false;
         }
         frame.dispose();
         frame = null;
      }
      
      protected function __onAlertSelect(event:DDTMatchEvent) : void
      {
         setBindFlag(event.flag);
      }
      
      private function setBindFlag(flag:Boolean) : void
      {
         if(skillType == 1)
         {
            SharedManager.Instance.isBuyHit = flag;
         }
         else if(skillType == 2)
         {
            SharedManager.Instance.isBuyInteger = flag;
         }
         else if(skillType == 3)
         {
            SharedManager.Instance.isBuyexclude = flag;
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
         var i:int = 0;
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
            for(i = 0; i < _selectVec.length; )
            {
               _selectVec[i].removeEventListener("click",__onSelectClick);
               _selectVec[i].dispose();
               _selectVec[i] = null;
               i++;
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
