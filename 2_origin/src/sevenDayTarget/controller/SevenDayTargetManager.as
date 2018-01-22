package sevenDayTarget.controller
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.loader.UIModuleLoader;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import godsRoads.manager.GodsRoadsManager;
   import road7th.comm.PackageIn;
   import sevenDayTarget.dataAnalyzer.SevenDayTargetDataAnalyzer;
   import sevenDayTarget.model.NewTargetQuestionInfo;
   import sevenDayTarget.model.SevenDayTargetModel;
   import sevenDayTarget.view.SevenDayTargetMainView;
   
   public class SevenDayTargetManager extends EventDispatcher
   {
      
      private static var _instance:SevenDayTargetManager;
      
      public static var loadComplete:Boolean = false;
       
      
      private var _model:SevenDayTargetModel;
      
      private var _isShowIcon:Boolean;
      
      private var _sevenDayTargetView:SevenDayTargetMainView;
      
      public var today:int = 1;
      
      public var questionTemple:Array;
      
      public var isHallAct:Boolean = false;
      
      public function SevenDayTargetManager()
      {
         super();
      }
      
      public static function get Instance() : SevenDayTargetManager
      {
         if(_instance == null)
         {
            _instance = new SevenDayTargetManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _model = new SevenDayTargetModel();
         SocketManager.Instance.addEventListener("sevenDayTarget_godsroads",pkgHandler);
         GodsRoadsManager.instance.addEventListener("XMLdata_Complete",_dataReciver);
      }
      
      private function _dataReciver(param1:Event) : void
      {
         var _loc3_:XML = GodsRoadsManager.instance.XMLData;
         var _loc2_:SevenDayTargetDataAnalyzer = new SevenDayTargetDataAnalyzer(SevenDayTargetManager.Instance.templateDataSetup);
         _loc2_.analyze(_loc3_);
      }
      
      public function get isShowIcon() : Boolean
      {
         return _isShowIcon;
      }
      
      public function hide() : void
      {
         if(_sevenDayTargetView != null)
         {
            _sevenDayTargetView.dispose();
         }
         _sevenDayTargetView = null;
      }
      
      public function onClickSevenDayTargetIcon() : void
      {
         var _loc1_:* = null;
         SoundManager.instance.play("008");
         if(questionTemple)
         {
            SocketManager.Instance.out.sevenDayTarget_enter(isHallAct);
         }
         else
         {
            _loc1_ = new Timer(1000);
            _loc1_.addEventListener("timer",__delayLoading);
            _loc1_.start();
         }
      }
      
      private function __delayLoading(param1:TimerEvent) : void
      {
         var _loc2_:Timer = param1.currentTarget as Timer;
         if(questionTemple)
         {
            SocketManager.Instance.out.sevenDayTarget_enter(isHallAct);
            _loc2_.stop();
            _loc2_.removeEventListener("timerComplete",__delayLoading);
            _loc2_ = null;
         }
      }
      
      protected function __onClose(param1:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__completeShow);
      }
      
      private function __progressShow(param1:UIModuleEvent) : void
      {
         if(param1.module == "sevenDayTarget")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function __completeShow(param1:UIModuleEvent) : void
      {
         if(param1.module == "sevenDayTarget")
         {
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__completeShow);
            UIModuleSmallLoading.Instance.hide();
            loadComplete = true;
            showSevenDayTargetMainView();
         }
      }
      
      private function showSevenDayTargetMainView() : void
      {
         NewSevenDayAndNewPlayerManager.Instance.sevenDayMainViewPreOk = true;
         NewSevenDayAndNewPlayerManager.Instance.dispatchEvent(new Event("openSevenDayMainView"));
      }
      
      public function templateDataSetup(param1:DataAnalyzer) : void
      {
         if(param1 is SevenDayTargetDataAnalyzer)
         {
            questionTemple = SevenDayTargetDataAnalyzer(param1).dataList;
         }
      }
      
      public function getQuestionInfoFromTemple(param1:NewTargetQuestionInfo) : NewTargetQuestionInfo
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < questionTemple.length)
         {
            _loc2_ = questionTemple[_loc3_];
            if(_loc2_.questId == param1.questId)
            {
               param1.condition1Title = _loc2_.condition1Title;
               param1.condition2Title = _loc2_.condition2Title;
               param1.condition3Title = _loc2_.condition3Title;
               param1.linkId = _loc2_.linkId;
               param1.condition1Para = _loc2_.condition1Para;
               param1.condition2Para = _loc2_.condition2Para;
               param1.condition3Para = _loc2_.condition3Para;
               param1.Period = _loc2_.Period;
            }
            _loc3_++;
         }
         return param1;
      }
      
      private function openOrclose(param1:PackageIn) : void
      {
         _isShowIcon = param1.readBoolean();
         NewSevenDayAndNewPlayerManager.Instance.sevenDayOpen = _isShowIcon;
         NewSevenDayAndNewPlayerManager.Instance.dispatchEvent(new Event("openUpdate"));
      }
      
      private function enterView(param1:PackageIn) : void
      {
         var _loc8_:int = 0;
         var _loc4_:Boolean = false;
         var _loc11_:int = 0;
         var _loc5_:int = 0;
         var _loc13_:* = null;
         var _loc12_:int = 0;
         var _loc10_:int = 0;
         var _loc16_:int = 0;
         var _loc2_:int = 0;
         var _loc9_:* = null;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:* = null;
         var _loc15_:int = param1.readInt();
         today = param1.readInt();
         var _loc14_:Array = [];
         _loc8_ = 0;
         while(_loc8_ < _loc15_)
         {
            _loc4_ = param1.readBoolean();
            _loc11_ = param1.readInt();
            _loc5_ = 0;
            while(_loc5_ < _loc11_)
            {
               _loc13_ = new NewTargetQuestionInfo();
               _loc13_.questId = param1.readInt();
               _loc13_ = getQuestionInfoFromTemple(_loc13_);
               _loc13_.iscomplete = param1.readBoolean();
               _loc12_ = param1.readInt();
               if(_loc12_ >= _loc13_.condition1Para)
               {
                  _loc13_.condition1Complete = true;
               }
               _loc10_ = param1.readInt();
               if(_loc10_ >= _loc13_.condition2Para)
               {
                  _loc13_.condition2Complete = true;
               }
               _loc16_ = param1.readInt();
               if(_loc16_ >= _loc13_.condition3Para)
               {
                  _loc13_.condition3Complete = true;
               }
               _loc13_.condition4 = param1.readInt();
               _loc13_.getedReward = param1.readBoolean();
               _loc2_ = param1.readInt();
               _loc9_ = [];
               _loc6_ = 0;
               while(_loc6_ < _loc2_)
               {
                  _loc3_ = param1.readInt();
                  _loc7_ = new InventoryItemInfo();
                  _loc7_.ItemID = _loc3_;
                  param1.readInt();
                  _loc7_.Count = param1.readInt();
                  _loc9_.push(_loc7_);
                  param1.readInt();
                  param1.readInt();
                  param1.readInt();
                  param1.readInt();
                  param1.readInt();
                  param1.readBoolean();
                  _loc6_++;
               }
               _loc13_.rewardList = _loc9_;
               _loc14_.push(_loc13_);
               _loc5_++;
            }
            param1.readInt();
            _model.sevenDayQuestionInfoArr = _loc14_;
            _loc8_++;
         }
         if(loadComplete)
         {
            showSevenDayTargetMainView();
         }
         else
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__completeShow);
            UIModuleLoader.Instance.addUIModuleImp("sevenDayTarget");
         }
      }
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = param1._cmd;
         switch(int(_loc2_) - 80)
         {
            case 0:
               openOrclose(_loc3_);
               break;
            case 1:
               enterView(_loc3_);
               break;
            case 2:
               updateView(_loc3_);
         }
      }
      
      private function updateView(param1:PackageIn) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Boolean = false;
         var _loc5_:Boolean = param1.readBoolean();
         if(_loc5_)
         {
            _loc3_ = param1.readInt();
            _loc4_ = param1.readInt();
            _loc2_ = param1.readBoolean();
            updateQuestionInfoArr(_loc3_,_loc5_,_loc2_);
         }
      }
      
      private function updateQuestionInfoArr(param1:int, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _model.sevenDayQuestionInfoArr.length)
         {
            _loc4_ = _model.sevenDayQuestionInfoArr[_loc5_];
            if(_loc4_.questId == param1)
            {
               _loc4_.getedReward = param2;
               _loc4_.iscomplete = param3;
            }
            _loc5_++;
         }
      }
      
      public function get model() : SevenDayTargetModel
      {
         return this._model;
      }
   }
}
