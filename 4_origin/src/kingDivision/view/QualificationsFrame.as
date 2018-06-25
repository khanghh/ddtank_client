package kingDivision.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import kingDivision.KingDivisionManager;
   import kingDivision.data.KingDivisionConsortionItemInfo;
   
   public class QualificationsFrame extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _awardsBtn:BaseButton;
      
      private var _ruleTxt:FilterFrameText;
      
      private var _list:VBox;
      
      private var _panel:ScrollPanel;
      
      private var _points:FilterFrameText;
      
      private var _titleName:Array;
      
      private var _titleNameTxt:FilterFrameText;
      
      private var index:int;
      
      private var _numberImg:Bitmap;
      
      private var _numberTxt:FilterFrameText;
      
      private var _startBtn:SimpleBitmapButton;
      
      private var _cancelBtn:SimpleBitmapButton;
      
      private var _consortionList:KingDivisionConsortionList;
      
      private var _consorPanel:ScrollPanel;
      
      private var _blind:Bitmap;
      
      private var _match:Bitmap;
      
      private var _timeTxt:FilterFrameText;
      
      private var _timer:Timer;
      
      private var _timerUpdate:Timer;
      
      private var _proBar:ProgressBarView;
      
      private var _info:Vector.<KingDivisionConsortionItemInfo>;
      
      private var isConsortiaID:Boolean;
      
      private var isTrue:Boolean;
      
      public function QualificationsFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.kingdivision.qualificationsframe");
         _awardsBtn = ComponentFactory.Instance.creat("qualificationsFrame.awardsBtn");
         _points = ComponentFactory.Instance.creatComponentByStylename("qualificationsFrame.pointsTxt");
         _points.text = KingDivisionManager.Instance.points.toString();
         _ruleTxt = ComponentFactory.Instance.creatComponentByStylename("qualificationsFrame.ruleTxt");
         _ruleTxt.text = LanguageMgr.GetTranslation("ddt.qualificationsFrame.ruleTxt");
         _list = ComponentFactory.Instance.creatComponentByStylename("assets.qualificationsFrame.ruleTxtVBox");
         _list.addChild(_ruleTxt);
         _panel = ComponentFactory.Instance.creatComponentByStylename("assets.qualificationsFrame.ruleTxtScrollpanel");
         _panel.setView(_list);
         _panel.invalidateViewport();
         _titleName = LanguageMgr.GetTranslation("ddt.qualificationsFrame.titleNameTxt").split(",");
         _numberImg = ComponentFactory.Instance.creatBitmap("asset.qualificationsframe.number");
         _numberTxt = ComponentFactory.Instance.creatComponentByStylename("qualificationsFrame.numberTxt");
         _numberTxt.text = KingDivisionManager.Instance.gameNum.toString();
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("qualificationsFrame.startBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("qualificationsFrame.cancelBtn");
         _cancelBtn.visible = false;
         _consortionList = ComponentFactory.Instance.creatComponentByStylename("kingDivision.consortionList");
         _consorPanel = ComponentFactory.Instance.creatComponentByStylename("assets.qualificationsFrame.consorPanel");
         _consorPanel.setView(_consortionList);
         _blind = ComponentFactory.Instance.creatBitmap("asset.qualificationsFrame.smallblind");
         _blind.visible = false;
         _match = ComponentFactory.Instance.creatBitmap("asset.qualificationsFrame.smallmatch");
         _match.visible = false;
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("asset.qualificationsFrame.timeTxt");
         addChild(_bg);
         addChild(_awardsBtn);
         addChild(_panel);
         addChild(_points);
         addChild(_numberImg);
         addChild(_numberTxt);
         addChild(_startBtn);
         addChild(_cancelBtn);
         addChild(_consorPanel);
         addChild(_blind);
         addChild(_match);
         addChild(_timeTxt);
         addTitleName(_titleName,_titleName.length);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timer);
         _timerUpdate = new Timer(60000);
         _timerUpdate.addEventListener("timer",__updateConsortionMessage);
         _timerUpdate.start();
         playerIsConsortion();
         checkGameStartTimer();
         if(KingDivisionManager.Instance.states == 2)
         {
            isShowStartBtn();
         }
      }
      
      private function addEvent() : void
      {
         _startBtn.addEventListener("click",__onStartBtnClick);
         _cancelBtn.addEventListener("click",__onCancelBtnClick);
         _awardsBtn.addEventListener("click",__onClickAwardsBtn);
      }
      
      private function removeEvent() : void
      {
         _startBtn.removeEventListener("click",__onStartBtnClick);
         _cancelBtn.removeEventListener("click",__onCancelBtnClick);
         _awardsBtn.removeEventListener("click",__onClickAwardsBtn);
         _timer.removeEventListener("timer",__timer);
         _timerUpdate.removeEventListener("timer",__updateConsortionMessage);
      }
      
      private function playerIsConsortion() : void
      {
         if(PlayerManager.Instance.Self.ConsortiaID <= 0)
         {
            _startBtn.visible = false;
            _cancelBtn.visible = false;
            _blind.visible = false;
            _match.visible = false;
            if(_numberImg)
            {
               ObjectUtils.disposeObject(_numberImg);
               _numberImg = null;
            }
            if(_numberTxt)
            {
               ObjectUtils.disposeObject(_numberTxt);
               _numberTxt = null;
            }
            return;
         }
         _startBtn.visible = true;
      }
      
      public function updateMessage(score:int, gameNum:int) : void
      {
         _points.text = score.toString();
         _numberTxt.text = gameNum.toString();
      }
      
      public function updateConsortiaMessage() : void
      {
         if(_consortionList && _consorPanel)
         {
            ObjectUtils.disposeObject(_consortionList);
            _consortionList = null;
            ObjectUtils.disposeObject(_consorPanel);
            _consorPanel = null;
         }
         _consortionList = ComponentFactory.Instance.creatComponentByStylename("kingDivision.consortionList");
         _consorPanel = ComponentFactory.Instance.creatComponentByStylename("assets.qualificationsFrame.consorPanel");
         _consorPanel.setView(_consortionList);
         addChild(_consorPanel);
      }
      
      private function __timer(evt:TimerEvent) : void
      {
         var min:uint = _timer.currentCount / 60;
         var sec:uint = _timer.currentCount % 60;
         _timeTxt.text = sec > 9?sec.toString():"0" + sec;
      }
      
      public function updateButtons() : void
      {
         _startBtn.visible = false;
         _cancelBtn.visible = true;
         if(_blind)
         {
            ObjectUtils.disposeObject(_blind);
            _blind = null;
         }
         if(_match)
         {
            ObjectUtils.disposeObject(_match);
            _match = null;
         }
         _blind = ComponentFactory.Instance.creatBitmap("asset.qualificationsFrame.smallblind");
         _match = ComponentFactory.Instance.creatBitmap("asset.qualificationsFrame.smallmatch");
         addChild(_blind);
         addChild(_match);
         if(_timer && !_timer.running)
         {
            if(_timeTxt)
            {
               ObjectUtils.disposeObject(_timeTxt);
               _timeTxt = null;
            }
            _timeTxt = ComponentFactory.Instance.creatComponentByStylename("asset.qualificationsFrame.timeTxt");
            addChild(_timeTxt);
            _timeTxt.text = "00";
            _timer.start();
         }
      }
      
      private function isShowStartBtn() : void
      {
         var i:int = 0;
         _info = KingDivisionManager.Instance.model.conItemInfo;
         if(_info != null)
         {
            for(i = 0; i < _info.length; )
            {
               if(PlayerManager.Instance.Self.ConsortiaID == _info[i].consortionIDArea && PlayerManager.Instance.Self.ZoneID == _info[i].areaID || isConsortiaID)
               {
                  isConsortiaID = true;
               }
               else
               {
                  isConsortiaID = false;
               }
               i++;
            }
         }
         if(!isConsortiaID)
         {
            if(_numberImg)
            {
               ObjectUtils.disposeObject(_numberImg);
               _numberImg = null;
            }
            if(_numberTxt)
            {
               ObjectUtils.disposeObject(_numberTxt);
               _numberTxt = null;
            }
            _startBtn.visible = false;
            _cancelBtn.visible = false;
            _blind.visible = false;
            _match.visible = false;
         }
      }
      
      private function __onStartBtnClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _timerUpdate.stop();
         if(!KingDivisionManager.Instance.checkGameTimeIsOpen())
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.kingdivision.checkGameTimesIsOpen"));
            return;
         }
         if(KingDivisionManager.Instance.gameNum <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.kingdivision.gameNum"));
            return;
         }
         if(PlayerManager.Instance.Self.Grade < KingDivisionManager.Instance.level)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.kingdivision.gameLevel",KingDivisionManager.Instance.level));
            return;
         }
         if(KingDivisionManager.Instance.checkCanStartGame())
         {
            startGame();
         }
      }
      
      private function startGame() : void
      {
         var type:int = 0;
         if(KingDivisionManager.Instance.states == 1)
         {
            type = 3;
         }
         else if(KingDivisionManager.Instance.states == 2)
         {
            type = 4;
         }
         GameInSocketOut.sendKingDivisionGameStart(type);
      }
      
      private function __onCancelBtnClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         cancelMatch();
      }
      
      private function __onClickAwardsBtn(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var rewView:RewardView = ComponentFactory.Instance.creatComponentByStylename("qualificationsFrame.RewardView");
         LayerManager.Instance.addToLayer(rewView,3,true,1);
      }
      
      private function addTitleName(arr:Array, len:int) : void
      {
         if(index > len - 1)
         {
            return;
         }
         _titleNameTxt = ComponentFactory.Instance.creatComponentByStylename("qualificationsFrame.titleNameTxt" + index);
         _titleNameTxt.text = arr[index];
         index = Number(index) + 1;
         addChild(_titleNameTxt);
         addTitleName(arr,len);
      }
      
      private function __updateConsortionMessage(evt:TimerEvent) : void
      {
         if(!isTrue)
         {
            checkGameStartTimer();
         }
         KingDivisionManager.Instance.updateConsotionMessage();
      }
      
      public function set progressBarView(value:ProgressBarView) : void
      {
         _proBar = value;
      }
      
      public function setDateStages(arr:Array) : void
      {
         var i:int = 0;
         var date:Date = TimeManager.Instance.Now();
         for(i = 0; i < arr.length; )
         {
            if(arr[i] == date.date)
            {
               _proBar.proBarAllMovie.gotoAndStop(i + 1);
               break;
            }
            if(arr[i] < date.date)
            {
               _proBar.proBarAllMovie.gotoAndStop(5);
            }
            i++;
         }
      }
      
      public function cancelMatch() : void
      {
         _timerUpdate.start();
         _startBtn.visible = true;
         _cancelBtn.visible = false;
         _blind.visible = false;
         _match.visible = false;
         _timeTxt.text = "";
         _timer.stop();
         _timer.reset();
         GameInSocketOut.sendCancelWait();
      }
      
      private function checkGameStartTimer() : void
      {
         if(!KingDivisionManager.Instance.checkGameTimeIsOpen())
         {
            _startBtn.enable = false;
            _startBtn.mouseEnabled = false;
            _startBtn.mouseChildren = false;
         }
         else
         {
            _startBtn.enable = true;
            _startBtn.mouseEnabled = true;
            _startBtn.mouseChildren = true;
            isTrue = true;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         isTrue = false;
         ObjectUtils.disposeObject(_awardsBtn);
         _awardsBtn = null;
         ObjectUtils.disposeObject(_ruleTxt);
         _ruleTxt = null;
         ObjectUtils.disposeObject(_points);
         _points = null;
         ObjectUtils.disposeObject(_titleNameTxt);
         _titleNameTxt = null;
         ObjectUtils.disposeObject(_numberTxt);
         _numberTxt = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         if(_timer)
         {
            _timer.stop();
            ObjectUtils.disposeObject(_timer);
            _timer = null;
         }
         if(_timerUpdate)
         {
            _timerUpdate.stop();
            ObjectUtils.disposeObject(_timerUpdate);
            _timerUpdate = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
