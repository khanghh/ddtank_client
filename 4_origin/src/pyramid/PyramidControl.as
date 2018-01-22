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
      
      public function PyramidControl(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : PyramidControl
      {
         if(_instance == null)
         {
            _instance = new PyramidControl();
         }
         return _instance;
      }
      
      public function set movieLock(param1:Boolean) : void
      {
         this._movieLock = param1;
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
      
      public function set isAutoOpenCard(param1:Boolean) : void
      {
         if(_isAutoOpenCard != param1)
         {
            _isAutoOpenCard = param1;
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
         var _loc1_:Number = new Date().time;
         if(_loc1_ - _clickRate > 500)
         {
            _clickRate = _loc1_;
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
      
      private function __onStartOrStop(param1:PyramidEvent) : void
      {
         var _loc3_:PackageIn = param1.Pkg;
         var _loc2_:PyramidModel = PyramidManager.instance.model;
         _loc2_.isPyramidStart = _loc3_.readBoolean();
         if(!_loc2_.isPyramidStart)
         {
            _loc2_.totalPoint = _loc3_.readInt();
            _loc2_.turnPoint = _loc3_.readInt();
            _loc2_.pointRatio = _loc3_.readInt();
            _loc2_.currentLayer = _loc3_.readInt();
            _loc2_.currentReviveCount = 0;
         }
         _loc2_.selectLayerItems = new Dictionary();
         _loc2_.dataChange("start_or_stop");
         clearFrame();
         if(autoCount > 0 && _loc2_.isPyramidStart == false && isAutoOpenCard)
         {
            GameInSocketOut.sendPyramidStartOrstop(true);
            return;
         }
         if(!_loc2_.isPyramidStart)
         {
            isAutoOpenCard = false;
         }
      }
      
      private function __onCardResult(param1:PyramidEvent) : void
      {
         var _loc4_:PackageIn = param1.Pkg;
         var _loc2_:PyramidModel = PyramidManager.instance.model;
         _loc2_.templateID = _loc4_.readInt();
         _loc2_.position = _loc4_.readInt();
         _loc2_.isPyramidDie = _loc4_.readBoolean();
         _loc2_.isUp = _loc4_.readBoolean();
         _loc2_.currentLayer = _loc4_.readInt();
         _loc2_.maxLayer = _loc4_.readInt();
         _loc2_.totalPoint = _loc4_.readInt();
         _loc2_.turnPoint = _loc4_.readInt();
         _loc2_.pointRatio = _loc4_.readInt();
         _loc2_.currentFreeCount = _loc4_.readInt();
         var _loc5_:int = _loc2_.currentLayer;
         if(_loc2_.isUp)
         {
            _loc5_--;
         }
         var _loc3_:Dictionary = _loc2_.selectLayerItems[_loc5_];
         if(!_loc3_)
         {
            _loc3_ = new Dictionary();
         }
         _loc3_[_loc2_.position] = _loc2_.templateID;
         _loc2_.selectLayerItems[_loc5_] = _loc3_;
         _loc2_.dataChange("card_result");
      }
      
      private function __onDieEvent(param1:PyramidEvent) : void
      {
         var _loc3_:PackageIn = param1.Pkg;
         var _loc2_:PyramidModel = PyramidManager.instance.model;
         _loc2_.isPyramidStart = _loc3_.readBoolean();
         _loc2_.currentLayer = _loc3_.readInt();
         _loc2_.totalPoint = _loc3_.readInt();
         _loc2_.turnPoint = _loc3_.readInt();
         _loc2_.pointRatio = _loc3_.readInt();
         _loc2_.currentReviveCount = _loc3_.readInt();
         _loc2_.dataChange("die_event");
         clearFrame();
      }
      
      private function __onScoreConvert(param1:PyramidEvent) : void
      {
         var _loc3_:PackageIn = param1.Pkg;
         var _loc2_:PyramidModel = PyramidManager.instance.model;
         _loc2_.totalPoint = _loc3_.readInt();
         _loc2_.dataChange("score_convert");
      }
      
      public function onClickPyramidIcon(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         GameInSocketOut.sendRequestEnterPyramidSystem();
         if(StateManager.currentStateType != "pyramid")
         {
            StateManager.setState("pyramid");
         }
      }
      
      public function showFrame(param1:int, param2:Object = null) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc4_:PyramidModel = PyramidManager.instance.model;
         _tipsType = param1;
         switch(int(_tipsType) - 1)
         {
            case 0:
               _loc5_ = _loc4_.revivePrice[_loc4_.currentReviveCount];
               _tipsframe = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("ddt.pyramid.cardFrameReviveTitle"),LanguageMgr.GetTranslation("ddt.pyramid.cardFrameReviveContent",_loc5_),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2);
               _loc3_ = ComponentFactory.Instance.creatComponentByStylename("pyramid.view.cardFrameReviveCount");
               _loc3_.text = LanguageMgr.GetTranslation("ddt.pyramid.cardFrameReviveCount",_loc4_.revivePrice.length - _loc4_.currentReviveCount,_loc4_.revivePrice.length);
               _tipsframe.addToContent(_loc3_);
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
               _tipsData = param2;
               _tipsframe = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.pyramid.turnCardMoneyMsg",_loc4_.turnCardPrice),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2,null,"pyramid.SimpleAlert1");
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
               _loc6_ = ComponentFactory.Instance.creatComponentByStylename("pyramid.TipTxt");
               _loc6_.text = LanguageMgr.GetTranslation("ddt.pyramid.tipText.content");
               _tipsframe.addToContent(_numberSelecter);
               _tipsframe.addToContent(_text);
               _tipsframe.addToContent(_loc6_);
               _numberSelecter.valueLimit = "1,50";
         }
         _tipsframe.addEventListener("response",__onResponse);
      }
      
      private function __seleterChange(param1:Event) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(_tipsType) - -1)
         {
            case 0:
               break;
            default:
               break;
            case 2:
               if(param1.responseCode == 2 || param1.responseCode == 3)
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
               if(param1.responseCode == 2 || param1.responseCode == 3)
               {
                  GameInSocketOut.sendPyramidStartOrstop(false);
               }
               break;
            case 5:
               break;
            case 6:
               if(param1.responseCode == 2 || param1.responseCode == 3)
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
               if(param1.responseCode == 2 || param1.responseCode == 3)
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
      
      private function __onselectedCheckButtoClick(param1:MouseEvent) : void
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
