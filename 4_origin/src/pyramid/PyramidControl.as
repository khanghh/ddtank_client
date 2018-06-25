package pyramid
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.NumberSelecter;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PyramidModel;
   import ddt.events.PyramidEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PyramidManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import hall.HallStateView;
   import road7th.comm.PackageIn;
   
   public class PyramidControl extends EventDispatcher
   {
      
      private static var _instance:PyramidControl;
       
      
      private var _movieLock:Boolean = false;
      
      private var _clickRate:Number = 0;
      
      public var isShowBuyFrameSelectedCheck:Boolean = true;
      
      public var isShowReviveBuyFrameSelectedCheck:Boolean = true;
      
      public var isShowAutoOpenFrameSelectedCheck:Boolean = true;
      
      private var _isAutoOpenCard:Boolean = false;
      
      private var _hall:HallStateView;
      
      private var _tipsframe:BaseAlerFrame;
      
      private var _selectedCheckButton:SelectedCheckButton;
      
      private var _tipsType:int;
      
      private var _tipsData:Object;
      
      public var autoCount:int;
      
      private var _numberSelecter:NumberSelecter;
      
      private var _text:FilterFrameText;
      
      public function PyramidControl(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : PyramidControl
      {
         if(_instance == null)
         {
            _instance = new PyramidControl();
         }
         return _instance;
      }
      
      public function set movieLock(value:Boolean) : void
      {
         this._movieLock = value;
         dispatchEvent(new PyramidEvent("movie_lock"));
      }
      
      public function get movieLock() : Boolean
      {
         return this._movieLock;
      }
      
      public function get isAutoOpenCard() : Boolean
      {
         return _isAutoOpenCard;
      }
      
      public function set isAutoOpenCard(value:Boolean) : void
      {
         if(_isAutoOpenCard != value)
         {
            _isAutoOpenCard = value;
            dispatchEvent(new PyramidEvent("auto_openCard"));
            if(_isAutoOpenCard)
            {
               isShowReviveBuyFrameSelectedCheck = false;
            }
            else
            {
               isShowReviveBuyFrameSelectedCheck = true;
            }
         }
      }
      
      public function get clickRateGo() : Boolean
      {
         var temp:Number = new Date().time;
         if(temp - _clickRate > 500)
         {
            _clickRate = temp;
            return false;
         }
         return true;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         PyramidManager.instance.addEventListener("start_or_stop",__onStartOrStop);
         PyramidManager.instance.addEventListener("card_result",__onCardResult);
         PyramidManager.instance.addEventListener("die_event",__onDieEvent);
         PyramidManager.instance.addEventListener("score_convert",__onScoreConvert);
      }
      
      private function __onStartOrStop(event:PyramidEvent) : void
      {
         var pkg:PackageIn = event.Pkg;
         var model:PyramidModel = PyramidManager.instance.model;
         model.isPyramidStart = pkg.readBoolean();
         if(!model.isPyramidStart)
         {
            model.totalPoint = pkg.readInt();
            model.turnPoint = pkg.readInt();
            model.pointRatio = pkg.readInt();
            model.currentLayer = pkg.readInt();
            model.currentReviveCount = 0;
         }
         model.selectLayerItems = new Dictionary();
         model.dataChange("start_or_stop");
         clearFrame();
         if(autoCount > 0 && model.isPyramidStart == false && isAutoOpenCard)
         {
            GameInSocketOut.sendPyramidStartOrstop(true);
            return;
         }
         if(!model.isPyramidStart)
         {
            isAutoOpenCard = false;
         }
      }
      
      private function __onCardResult(event:PyramidEvent) : void
      {
         var pkg:PackageIn = event.Pkg;
         var model:PyramidModel = PyramidManager.instance.model;
         model.templateID = pkg.readInt();
         model.position = pkg.readInt();
         model.isPyramidDie = pkg.readBoolean();
         model.isUp = pkg.readBoolean();
         model.currentLayer = pkg.readInt();
         model.maxLayer = pkg.readInt();
         model.totalPoint = pkg.readInt();
         model.turnPoint = pkg.readInt();
         model.pointRatio = pkg.readInt();
         model.currentFreeCount = pkg.readInt();
         var tempLayer:int = model.currentLayer;
         if(model.isUp)
         {
            tempLayer--;
         }
         var dic:Dictionary = model.selectLayerItems[tempLayer];
         if(!dic)
         {
            dic = new Dictionary();
         }
         dic[model.position] = model.templateID;
         model.selectLayerItems[tempLayer] = dic;
         model.dataChange("card_result");
      }
      
      private function __onDieEvent(event:PyramidEvent) : void
      {
         var pkg:PackageIn = event.Pkg;
         var model:PyramidModel = PyramidManager.instance.model;
         model.isPyramidStart = pkg.readBoolean();
         model.currentLayer = pkg.readInt();
         model.totalPoint = pkg.readInt();
         model.turnPoint = pkg.readInt();
         model.pointRatio = pkg.readInt();
         model.currentReviveCount = pkg.readInt();
         model.dataChange("die_event");
         clearFrame();
      }
      
      private function __onScoreConvert(event:PyramidEvent) : void
      {
         var pkg:PackageIn = event.Pkg;
         var model:PyramidModel = PyramidManager.instance.model;
         model.totalPoint = pkg.readInt();
         model.dataChange("score_convert");
      }
      
      public function onClickPyramidIcon(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         GameInSocketOut.sendRequestEnterPyramidSystem();
         if(StateManager.currentStateType != "pyramid")
         {
            StateManager.setState("pyramid");
         }
      }
      
      public function showFrame(_type:int, dataObj:Object = null) : void
      {
         var revieMoney:int = 0;
         var _cardFrameReviveCount:* = null;
         var tipText:* = null;
         var model:PyramidModel = PyramidManager.instance.model;
         _tipsType = _type;
         switch(int(_tipsType) - 1)
         {
            case 0:
               revieMoney = model.revivePrice[model.currentReviveCount];
               _tipsframe = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("ddt.pyramid.cardFrameReviveTitle"),LanguageMgr.GetTranslation("ddt.pyramid.cardFrameReviveContent",revieMoney),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2);
               _cardFrameReviveCount = ComponentFactory.Instance.creatComponentByStylename("pyramid.view.cardFrameReviveCount");
               _cardFrameReviveCount.text = LanguageMgr.GetTranslation("ddt.pyramid.cardFrameReviveCount",model.revivePrice.length - model.currentReviveCount,model.revivePrice.length);
               _tipsframe.addToContent(_cardFrameReviveCount);
               break;
            case 1:
               _tipsframe = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.pyramid.cardFrameReviveEndContent"),"","",true,false,false,2,null,"SimpleAlert",50,true,0);
               break;
            case 2:
               _tipsframe = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.pyramid.stopMsg"),"",LanguageMgr.GetTranslation("cancel"),true,false,false,2);
               break;
            case 3:
               _tipsframe = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.pyramid.scoreConvertMsg"),"","",true,false,false,2);
               break;
            case 4:
               _tipsData = dataObj;
               _tipsframe = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.pyramid.turnCardMoneyMsg",model.turnCardPrice),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2,null,"pyramid.SimpleAlert1");
               _selectedCheckButton = ComponentFactory.Instance.creatComponentByStylename("pyramid.buyFrameSelectedCheckButton");
               _selectedCheckButton.text = LanguageMgr.GetTranslation("ddt.pyramid.buyFrameSelectedCheckButtonTextMsg");
               _selectedCheckButton.addEventListener("click",__onselectedCheckButtoClick);
               _tipsframe.addToContent(_selectedCheckButton);
               break;
            case 5:
               _tipsframe = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.pyramid.endScoreConvertTime"),"","",true,false,false,2);
               break;
            case 6:
               _tipsframe = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.pyramid.cardFrameReviveEndContent2"),"","",true,false,false,2);
               break;
            case 7:
               _tipsframe = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.pyramid.autoOpenCardFrameMsg"),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2);
               _tipsframe.height = 250;
               _text = ComponentFactory.Instance.creatComponentByStylename("pyramid.autoCountSelectFrame.Text");
               _text.text = LanguageMgr.GetTranslation("ddt.pyramid.autoOpenCount.text");
               _numberSelecter = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.NumberSelecter");
               _numberSelecter.addEventListener("change",__seleterChange);
               PositionUtils.setPos(_numberSelecter,"pyramid.view.autoCountPos");
               tipText = ComponentFactory.Instance.creatComponentByStylename("pyramid.TipTxt");
               tipText.text = LanguageMgr.GetTranslation("ddt.pyramid.tipText.content");
               _tipsframe.addToContent(_numberSelecter);
               _tipsframe.addToContent(_text);
               _tipsframe.addToContent(tipText);
               _numberSelecter.valueLimit = "1,50";
         }
         _tipsframe.addEventListener("response",__onResponse);
      }
      
      private function __seleterChange(event:Event) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __onResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(_tipsType) - -1)
         {
            case 0:
               break;
            default:
               break;
            case 2:
               if(evt.responseCode == 2 || evt.responseCode == 3)
               {
                  GameInSocketOut.sendPyramidRevive(true,false);
               }
               else
               {
                  GameInSocketOut.sendPyramidRevive(false,false);
               }
               break;
            case 3:
               GameInSocketOut.sendPyramidRevive(false,false);
               break;
            case 4:
               if(evt.responseCode == 2 || evt.responseCode == 3)
               {
                  GameInSocketOut.sendPyramidStartOrstop(false);
               }
               break;
            case 5:
               break;
            case 6:
               if(evt.responseCode == 2 || evt.responseCode == 3)
               {
                  GameInSocketOut.sendPyramidTurnCard(_tipsData[0],_tipsData[1],false);
               }
               _tipsData = null;
               break;
            case 7:
               break;
            case 8:
               GameInSocketOut.sendPyramidRevive(false,false);
               break;
            case 9:
               if(evt.responseCode == 2 || evt.responseCode == 3)
               {
                  isShowBuyFrameSelectedCheck = false;
                  isAutoOpenCard = true;
                  if(_numberSelecter)
                  {
                     autoCount = _numberSelecter.currentValue;
                  }
               }
         }
         tipsDispose();
      }
      
      private function __onselectedCheckButtoClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         isShowBuyFrameSelectedCheck = !_selectedCheckButton.selected;
      }
      
      private function tipsDispose() : void
      {
         if(_selectedCheckButton)
         {
            _selectedCheckButton.removeEventListener("click",__onselectedCheckButtoClick);
            ObjectUtils.disposeObject(_selectedCheckButton);
            _selectedCheckButton = null;
         }
         if(_tipsframe)
         {
            _tipsframe.removeEventListener("response",__onResponse);
            ObjectUtils.disposeAllChildren(_tipsframe);
            ObjectUtils.disposeObject(_tipsframe);
            _tipsframe = null;
         }
      }
      
      public function clearFrame() : void
      {
         if(_tipsframe)
         {
            _tipsframe.dispatchEvent(new FrameEvent(-1));
         }
      }
   }
}
