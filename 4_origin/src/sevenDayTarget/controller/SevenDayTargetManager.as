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
      
      private function _dataReciver(e:Event) : void
      {
         var xml:XML = GodsRoadsManager.instance.XMLData;
         var analyzer:SevenDayTargetDataAnalyzer = new SevenDayTargetDataAnalyzer(SevenDayTargetManager.Instance.templateDataSetup);
         analyzer.analyze(xml);
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
         var timer:* = null;
         SoundManager.instance.play("008");
         if(questionTemple)
         {
            SocketManager.Instance.out.sevenDayTarget_enter(isHallAct);
         }
         else
         {
            timer = new Timer(1000);
            timer.addEventListener("timer",__delayLoading);
            timer.start();
         }
      }
      
      private function __delayLoading(e:TimerEvent) : void
      {
         var timer:Timer = e.currentTarget as Timer;
         if(questionTemple)
         {
            SocketManager.Instance.out.sevenDayTarget_enter(isHallAct);
            timer.stop();
            timer.removeEventListener("timerComplete",__delayLoading);
            timer = null;
         }
      }
      
      protected function __onClose(event:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__completeShow);
      }
      
      private function __progressShow(event:UIModuleEvent) : void
      {
         if(event.module == "sevenDayTarget")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      private function __completeShow(event:UIModuleEvent) : void
      {
         if(event.module == "sevenDayTarget")
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
      
      public function templateDataSetup(analyzer:DataAnalyzer) : void
      {
         if(analyzer is SevenDayTargetDataAnalyzer)
         {
            questionTemple = SevenDayTargetDataAnalyzer(analyzer).dataList;
         }
      }
      
      public function getQuestionInfoFromTemple(questionInfo:NewTargetQuestionInfo) : NewTargetQuestionInfo
      {
         var i:int = 0;
         var templeInfo:* = null;
         for(i = 0; i < questionTemple.length; )
         {
            templeInfo = questionTemple[i];
            if(templeInfo.questId == questionInfo.questId)
            {
               questionInfo.condition1Title = templeInfo.condition1Title;
               questionInfo.condition2Title = templeInfo.condition2Title;
               questionInfo.condition3Title = templeInfo.condition3Title;
               questionInfo.linkId = templeInfo.linkId;
               questionInfo.condition1Para = templeInfo.condition1Para;
               questionInfo.condition2Para = templeInfo.condition2Para;
               questionInfo.condition3Para = templeInfo.condition3Para;
               questionInfo.Period = templeInfo.Period;
            }
            i++;
         }
         return questionInfo;
      }
      
      private function openOrclose(pkg:PackageIn) : void
      {
         _isShowIcon = pkg.readBoolean();
         NewSevenDayAndNewPlayerManager.Instance.sevenDayOpen = _isShowIcon;
         NewSevenDayAndNewPlayerManager.Instance.dispatchEvent(new Event("openUpdate"));
      }
      
      private function enterView(pkg:PackageIn) : void
      {
         var i:int = 0;
         var rewardsGeted:Boolean = false;
         var targetQuestNum:int = 0;
         var j:int = 0;
         var questionInfo:* = null;
         var condition1:int = 0;
         var condition2:int = 0;
         var condition3:int = 0;
         var rewardNum:int = 0;
         var rewardArr:* = null;
         var k:int = 0;
         var itemTempId:int = 0;
         var info:* = null;
         var totolDays:int = pkg.readInt();
         today = pkg.readInt();
         var questioninfoArr:Array = [];
         for(i = 0; i < totolDays; )
         {
            rewardsGeted = pkg.readBoolean();
            targetQuestNum = pkg.readInt();
            for(j = 0; j < targetQuestNum; )
            {
               questionInfo = new NewTargetQuestionInfo();
               questionInfo.questId = pkg.readInt();
               questionInfo = getQuestionInfoFromTemple(questionInfo);
               questionInfo.iscomplete = pkg.readBoolean();
               condition1 = pkg.readInt();
               if(condition1 >= questionInfo.condition1Para)
               {
                  questionInfo.condition1Complete = true;
               }
               condition2 = pkg.readInt();
               if(condition2 >= questionInfo.condition2Para)
               {
                  questionInfo.condition2Complete = true;
               }
               condition3 = pkg.readInt();
               if(condition3 >= questionInfo.condition3Para)
               {
                  questionInfo.condition3Complete = true;
               }
               questionInfo.condition4 = pkg.readInt();
               questionInfo.getedReward = pkg.readBoolean();
               rewardNum = pkg.readInt();
               rewardArr = [];
               for(k = 0; k < rewardNum; )
               {
                  itemTempId = pkg.readInt();
                  info = new InventoryItemInfo();
                  info.ItemID = itemTempId;
                  pkg.readInt();
                  info.Count = pkg.readInt();
                  rewardArr.push(info);
                  pkg.readInt();
                  pkg.readInt();
                  pkg.readInt();
                  pkg.readInt();
                  pkg.readInt();
                  pkg.readBoolean();
                  k++;
               }
               questionInfo.rewardList = rewardArr;
               questioninfoArr.push(questionInfo);
               j++;
            }
            pkg.readInt();
            _model.sevenDayQuestionInfoArr = questioninfoArr;
            i++;
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
      
      private function pkgHandler(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var cmd:int = event._cmd;
         switch(int(cmd) - 80)
         {
            case 0:
               openOrclose(pkg);
               break;
            case 1:
               enterView(pkg);
               break;
            case 2:
               updateView(pkg);
         }
      }
      
      private function updateView(pkg:PackageIn) : void
      {
         var questionID:int = 0;
         var day:int = 0;
         var isComplete:Boolean = false;
         var success:Boolean = pkg.readBoolean();
         if(success)
         {
            questionID = pkg.readInt();
            day = pkg.readInt();
            isComplete = pkg.readBoolean();
            updateQuestionInfoArr(questionID,success,isComplete);
         }
      }
      
      private function updateQuestionInfoArr(questionID:int, success:Boolean, isComplete:Boolean) : void
      {
         var questionInfo:* = null;
         var i:int = 0;
         for(i = 0; i < _model.sevenDayQuestionInfoArr.length; )
         {
            questionInfo = _model.sevenDayQuestionInfoArr[i];
            if(questionInfo.questId == questionID)
            {
               questionInfo.getedReward = success;
               questionInfo.iscomplete = isComplete;
            }
            i++;
         }
      }
      
      public function get model() : SevenDayTargetModel
      {
         return this._model;
      }
   }
}
