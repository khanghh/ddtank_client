package lanternriddles.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import lanternriddles.LanternRiddlesControl;
   import lanternriddles.LanternRiddlesManager;
   import lanternriddles.data.LanternAwardInfo;
   import lanternriddles.data.LanternInfo;
   import lanternriddles.event.LanternEvent;
   import road7th.comm.PackageIn;
   
   public class LanternRiddlesView extends Frame
   {
      
      private static var RANK_NUM:int = 8;
       
      
      private var _bg:Bitmap;
      
      private var _questionView:QuestionView;
      
      private var _doubleBtn:BaseButton;
      
      private var _hitBtn:BaseButton;
      
      private var _freeDouble:FilterFrameText;
      
      private var _freeHit:FilterFrameText;
      
      private var _careInfo:FilterFrameText;
      
      private var _questionNum:FilterFrameText;
      
      private var _myRank:FilterFrameText;
      
      private var _myInteger:FilterFrameText;
      
      private var _rankVec:Vector.<LanternRankItem>;
      
      private var _offY:int = 40;
      
      private var _doubleFreeCount:int;
      
      private var _hitFreeCount:int;
      
      private var _doublePrice:int;
      
      private var _hitPrice:int;
      
      private var _hitFlag:Boolean;
      
      private var _alertAsk:LanternAlertView;
      
      public function LanternRiddlesView()
      {
         super();
         initView();
         initEvent();
         sendPkg();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("lanternRiddles.view.Title");
         _bg = ComponentFactory.Instance.creat("lantern.view.bg");
         addToContent(_bg);
         _questionView = new QuestionView();
         addToContent(_questionView);
         _doubleBtn = ComponentFactory.Instance.creat("lantern.view.doubleBtn");
         addToContent(_doubleBtn);
         _freeDouble = ComponentFactory.Instance.creatComponentByStylename("lantern.view.freeDouble");
         _doubleBtn.addChild(_freeDouble);
         _hitBtn = ComponentFactory.Instance.creat("lantern.view.hitBtn");
         addToContent(_hitBtn);
         _freeHit = ComponentFactory.Instance.creatComponentByStylename("lantern.view.freeHit");
         _hitBtn.addChild(_freeHit);
         _careInfo = ComponentFactory.Instance.creatComponentByStylename("lantern.view.careInfo");
         _careInfo.text = LanguageMgr.GetTranslation("lanternRiddles.view.careInfoText");
         addToContent(_careInfo);
         _questionNum = ComponentFactory.Instance.creatComponentByStylename("lantern.view.questionNum");
         addToContent(_questionNum);
         _myRank = ComponentFactory.Instance.creatComponentByStylename("lantern.view.rank");
         addToContent(_myRank);
         _myInteger = ComponentFactory.Instance.creatComponentByStylename("lantern.view.integer");
         addToContent(_myInteger);
         _rankVec = new Vector.<LanternRankItem>();
         addRankView();
      }
      
      private function addRankView() : void
      {
         var rank:* = null;
         var i:int = 0;
         for(i = 0; i < RANK_NUM; )
         {
            rank = new LanternRankItem();
            rank.buttonMode = true;
            PositionUtils.setPos(rank,"lantern.view.rankPos");
            rank.y = rank.y + i * _offY;
            addToContent(rank);
            _rankVec.push(rank);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _doubleBtn.addEventListener("click",_onDoubleBtnClick);
         _hitBtn.addEventListener("click",__onHitBtnClick);
         LanternRiddlesManager.instance.addEventListener("lanternRiddles_question",__onSetQuestionInfo);
         LanternRiddlesManager.instance.addEventListener("lanternRiddles_rankinfo",__onSetRankInfo);
         LanternRiddlesManager.instance.addEventListener("lanternRiddles_skill",__onSetBtnEnable);
      }
      
      protected function __onSetBtnEnable(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var flag:Boolean = pkg.readBoolean();
         if(_hitFlag)
         {
            _questionView.setSelectBtnEnable(false);
            _hitBtn.enable = !flag;
         }
         else
         {
            _doubleBtn.enable = !flag;
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
         var pkg:PackageIn = event.pkg;
         var index:int = pkg.readInt();
         var questionID:int = pkg.readInt();
         var info:LanternInfo = LanternRiddlesManager.instance.info[questionID];
         if(info)
         {
            _questionView.count = pkg.readInt();
            endDate = pkg.readDate();
            _doubleFreeCount = pkg.readInt();
            _doublePrice = pkg.readInt();
            _hitFreeCount = pkg.readInt();
            _hitPrice = pkg.readInt();
            integer = pkg.readInt();
            rightNum = pkg.readInt();
            option = pkg.readInt();
            hitFlag = pkg.readBoolean();
            doubleFlag = pkg.readBoolean();
            info.QuestionIndex = index;
            info.QuestionID = questionID;
            info.Option = option;
            info.EndDate = endDate;
            _questionView.setSelectBtnEnable(true);
            _questionView.info = info;
            _freeDouble.text = LanguageMgr.GetTranslation("lanternRiddles.view.freeText",_doubleFreeCount);
            _freeHit.text = LanguageMgr.GetTranslation("lanternRiddles.view.freeText",_hitFreeCount);
            _myInteger.text = integer.toString();
            _questionNum.text = LanguageMgr.GetTranslation("lanternRiddles.view.questionNumText",rightNum);
            if(_questionView.countDownTime > 0)
            {
               _doubleBtn.enable = !doubleFlag;
               _hitBtn.enable = !hitFlag;
               if(!_hitBtn.enable)
               {
                  _questionView.setSelectBtnEnable(false);
               }
            }
            else
            {
               _questionView.setSelectBtnEnable(false);
               _doubleBtn.enable = false;
               _hitBtn.enable = false;
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
         _myRank.text = String(pkg.readInt());
         var length:int = pkg.readInt();
         for(i = 0; i < length; )
         {
            rankInfo = new LanternInfo();
            rankInfo.Rank = pkg.readInt();
            rankInfo.NickName = pkg.readUTF();
            rankInfo.TypeVIP = pkg.readByte();
            rankInfo.Integer = pkg.readInt();
            awardNum = pkg.readInt();
            for(j = 0; j < awardNum; )
            {
               awardInfo = new LanternAwardInfo();
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
      
      protected function _onDoubleBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _hitFlag = false;
         if(_doubleFreeCount <= 0)
         {
            if(!SharedManager.Instance.isBuyInteger)
            {
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  return;
               }
               _alertAsk = ComponentFactory.Instance.creatComponentByStylename("lantern.view.alertView");
               _alertAsk.text = LanguageMgr.GetTranslation("lanternRiddles.view.buyDoubleInteger.alertInfo",_doublePrice);
               LayerManager.Instance.addToLayer(_alertAsk,3,true,1);
               _alertAsk.addEventListener("lanternSelect",__onLanternAlertSelect);
               _alertAsk.addEventListener("response",__onBuyHandle);
            }
            else if(payment(SharedManager.Instance.isBuyIntegerBind))
            {
               SocketManager.Instance.out.sendLanternRiddlesUseSkill(_questionView.info.QuestionID,_questionView.info.QuestionIndex,1,SharedManager.Instance.isBuyIntegerBind);
            }
         }
         else if(!_hitBtn.enable || _questionView.info.Option != 0)
         {
            SocketManager.Instance.out.sendLanternRiddlesUseSkill(_questionView.info.QuestionID,_questionView.info.QuestionIndex,1);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("lanternRiddles.view.doubleClick.tipsInfo"));
         }
      }
      
      protected function __onLanternAlertSelect(event:LanternEvent) : void
      {
         setBindFlag(event.flag);
      }
      
      protected function __onBuyHandle(event:FrameEvent) : void
      {
         var frame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         frame.removeEventListener("lanternSelect",__onLanternAlertSelect);
         frame.removeEventListener("response",__onBuyHandle);
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               if(_hitFlag)
               {
                  SharedManager.Instance.isBuyHitBind = frame.isBand;
               }
               else
               {
                  SharedManager.Instance.isBuyIntegerBind = frame.isBand;
               }
               if(payment(frame.isBand))
               {
                  SocketManager.Instance.out.sendLanternRiddlesUseSkill(_questionView.info.QuestionID,_questionView.info.QuestionIndex,!!_hitFlag?0:1,frame.isBand);
               }
               _hitBtn.enable = false;
         }
         frame.dispose();
         frame = null;
      }
      
      private function setBindFlag(flag:Boolean) : void
      {
         if(_hitFlag)
         {
            SharedManager.Instance.isBuyHit = flag;
         }
         else
         {
            SharedManager.Instance.isBuyInteger = flag;
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
      
      protected function __onHitBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _hitFlag = true;
         if(_hitFreeCount <= 0)
         {
            if(!SharedManager.Instance.isBuyHit)
            {
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  return;
               }
               _alertAsk = ComponentFactory.Instance.creatComponentByStylename("lantern.view.alertView");
               _alertAsk.text = LanguageMgr.GetTranslation("lanternRiddles.view.buyHit.alertInfo",_hitPrice);
               LayerManager.Instance.addToLayer(_alertAsk,3,true,1);
               _alertAsk.addEventListener("lanternSelect",__onLanternAlertSelect);
               _alertAsk.addEventListener("response",__onBuyHandle);
            }
            else
            {
               if(payment(SharedManager.Instance.isBuyHitBind))
               {
                  SocketManager.Instance.out.sendLanternRiddlesUseSkill(_questionView.info.QuestionID,_questionView.info.QuestionIndex,0,SharedManager.Instance.isBuyHitBind);
               }
               _hitBtn.enable = false;
            }
         }
         else
         {
            SocketManager.Instance.out.sendLanternRiddlesUseSkill(_questionView.info.QuestionID,_questionView.info.QuestionIndex,0);
            _hitBtn.enable = false;
         }
      }
      
      private function sendPkg() : void
      {
         SocketManager.Instance.out.sendLanternRiddlesQuestion();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _doubleBtn.removeEventListener("click",_onDoubleBtnClick);
         _hitBtn.removeEventListener("click",__onHitBtnClick);
         LanternRiddlesManager.instance.removeEventListener("lanternRiddles_question",__onSetQuestionInfo);
         LanternRiddlesManager.instance.removeEventListener("lanternRiddles_rankinfo",__onSetRankInfo);
         LanternRiddlesManager.instance.removeEventListener("lanternRiddles_skill",__onSetBtnEnable);
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               LanternRiddlesControl.instance.hide();
         }
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
            SocketManager.Instance.out.sendLanternRiddlesUseSkill(_questionView.info.QuestionID,_questionView.info.QuestionIndex,!!_hitFlag?0:1,false);
         }
         e.currentTarget.dispose();
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
      
      private function checkMoney(isBand:Boolean) : Boolean
      {
         var money:int = !!_hitFlag?_hitPrice:int(_doublePrice);
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
      
      override public function dispose() : void
      {
         var i:int = 0;
         super.dispose();
         removeEvent();
         if(_bg)
         {
            _bg.bitmapData.dispose();
            _bg = null;
         }
         if(_questionView)
         {
            _questionView.dispose();
            _questionView = null;
         }
         if(_doubleBtn)
         {
            _doubleBtn.dispose();
            _doubleBtn = null;
         }
         if(_hitBtn)
         {
            _hitBtn.dispose();
            _hitBtn = null;
         }
         if(_freeDouble)
         {
            _freeDouble.dispose();
            _freeDouble = null;
         }
         if(_freeHit)
         {
            _freeHit.dispose();
            _freeHit = null;
         }
         if(_careInfo)
         {
            _careInfo.dispose();
            _careInfo = null;
         }
         if(_myRank)
         {
            _myRank.dispose();
            _myRank = null;
         }
         if(_myInteger)
         {
            _myInteger.dispose();
            _myInteger = null;
         }
         if(_rankVec)
         {
            for(i = 0; i < _rankVec.length; )
            {
               _rankVec[i].dispose();
               _rankVec[i] = null;
               i++;
            }
            _rankVec.length = 0;
            _rankVec = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
