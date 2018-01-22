package ddtBuried.views
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import ddt.bagStore.BagStore;
   import ddt.data.quest.QuestCategory;
   import ddt.data.quest.QuestInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddtBuried.BuriedControl;
   import ddtBuried.BuriedManager;
   import farm.FarmModelController;
   import flash.events.MouseEvent;
   import quest.TaskManager;
   import trainer.controller.WeakGuildManager;
   
   public class TaskTrackView extends Frame
   {
       
      
      private const LIST_SPACE:int = 5;
      
      private const DAY_TASK_TYPE:int = 5;
      
      private var _taskBg:ScaleFrameImage;
      
      private var _taskBackBtn:SimpleBitmapButton;
      
      private var _taskBackPopBtn:SimpleBitmapButton;
      
      private var _buriedFlag:Boolean = true;
      
      private var _listView:ScrollPanel;
      
      private var _itemList:VBox;
      
      private var _idArray:Array;
      
      private var _funcArray:Array;
      
      private var _data:QuestCategory;
      
      private var _gotoNewTaskIdArr:Array;
      
      public function TaskTrackView()
      {
         _gotoNewTaskIdArr = [3054,3055,3056];
         super();
         _init();
      }
      
      private function _init() : void
      {
         initData();
         initView();
         initEvent();
      }
      
      private function initData() : void
      {
         _data = TaskManager.instance.getAvailableQuests(5);
         _funcArray = new Array(gotoMainView,gotoShop,gotoHall,gotoDungeon,gotoStore,gotoFarm);
         _idArray = new Array([30],[10,54],[22,23,24,26,28,34,36,37],[1,2,3,7,8,13,14,15,21,41],[9,11,19],[51]);
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _taskBg = ComponentFactory.Instance.creatComponentByStylename("ddtburied.taskTrackbg");
         addChild(_taskBg);
         _taskBackBtn = ComponentFactory.Instance.creatComponentByStylename("ddtburied.taskBuried");
         addChild(_taskBackBtn);
         _taskBackPopBtn = ComponentFactory.Instance.creatComponentByStylename("ddtburied.taskBuriedPopBtn");
         addChild(_taskBackPopBtn);
         _itemList = new VBox();
         _itemList.spacing = 5;
         _listView = ComponentFactory.Instance.creat("ddtburied.TaskItemList");
         _listView.setView(_itemList);
         _listView.vScrollProxy = 1;
         _listView.hScrollProxy = 2;
         PositionUtils.setPos(_listView,"ddtburied.taskInfo.pos");
         addChild(_listView);
         if(_data.list.length > 0)
         {
            _taskBackPopBtn.visible = false;
            _loc3_ = 0;
            while(_loc3_ < _data.list.length)
            {
               _loc2_ = new TaskTrackInfoView();
               _loc1_ = _data.list[_loc3_] as QuestInfo;
               _loc2_.info = _loc1_;
               _loc2_.taskTitle.text = ">>" + _loc1_.Title;
               _loc2_.taskInfo.htmlText = "<u>" + _loc1_.conditionDescription[0] + "</u>";
               if(_gotoNewTaskIdArr.indexOf(_loc1_.QuestID) == -1)
               {
                  _loc2_.func = _funcArray[getFuncID(_loc1_.Condition)];
               }
               else
               {
                  _loc2_.func = gotoTask;
               }
               _loc2_.taskBtnRect();
               _itemList.addChild(_loc2_);
               _loc3_++;
            }
         }
         else
         {
            _taskBackBtn.visible = false;
            __onBackClick(null);
         }
         _listView.invalidateViewport();
      }
      
      private function initEvent() : void
      {
         _taskBackBtn.addEventListener("click",__onBackClick);
         _taskBackPopBtn.addEventListener("click",__onBackClick);
      }
      
      public function refreshTask() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _data = TaskManager.instance.getAvailableQuests(5);
         _loc3_ = 0;
         while(_loc3_ < _data.list.length)
         {
            _loc2_ = new TaskTrackInfoView();
            _loc1_ = _data.list[_loc3_] as QuestInfo;
            _loc2_.info = _loc1_;
            _loc2_.taskTitle.text = ">>" + _loc1_.Title;
            _loc2_.taskInfo.htmlText = "<u>" + _loc1_.conditionDescription[0] + "</u>";
            if(_gotoNewTaskIdArr.indexOf(_loc1_.QuestID) == -1)
            {
               _loc2_.func = _funcArray[getFuncID(_loc1_.Condition)];
            }
            else
            {
               _loc2_.func = gotoTask;
            }
            _loc2_.taskBtnRect();
            _itemList.addChild(_loc2_);
            _loc3_++;
         }
      }
      
      protected function __onBackClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_buriedFlag)
         {
            TweenLite.to(this,0.5,{"x":1000});
         }
         else
         {
            TweenLite.to(this,0.5,{"x":803});
         }
         _taskBackPopBtn.visible = _buriedFlag;
         _taskBackBtn.visible = !_buriedFlag;
         _buriedFlag = !_buriedFlag;
      }
      
      public function __onBackRollout(param1:MouseEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function getFuncID(param1:int) : int
      {
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _idArray.length)
         {
            if(_idArray[_loc3_].indexOf(param1) != -1)
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function gotoShop(param1:QuestInfo) : void
      {
         if(!WeakGuildManager.Instance.checkOpen(18,3))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",3));
            return;
         }
         StateManager.setState("shop");
         ComponentSetting.SEND_USELOG_ID(1);
      }
      
      private function gotoHall(param1:QuestInfo) : void
      {
         if(!WeakGuildManager.Instance.checkOpen(1,2))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",2));
            return;
         }
         StateManager.setState("roomlist");
         ComponentSetting.SEND_USELOG_ID(3);
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(1) && !PlayerManager.Instance.Self.IsWeakGuildFinish(4))
         {
            SocketManager.Instance.out.syncWeakStep(4);
         }
      }
      
      private function gotoDungeon(param1:QuestInfo) : void
      {
         if(!WeakGuildManager.Instance.checkOpen(16,8))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",8));
            return;
         }
         if(!PlayerManager.Instance.checkEnterDungeon)
         {
            return;
         }
         StateManager.setState("dungeon");
         ComponentSetting.SEND_USELOG_ID(4);
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(16) && !PlayerManager.Instance.Self.IsWeakGuildFinish(67))
         {
            SocketManager.Instance.out.syncWeakStep(67);
         }
      }
      
      private function gotoStore(param1:QuestInfo) : void
      {
         if(WeakGuildManager.Instance.switchUserGuide && !PlayerManager.Instance.Self.IsWeakGuildFinish(950))
         {
            if(PlayerManager.Instance.Self.Grade < 5)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",5));
               return;
            }
         }
         BagStore.instance.openStore("bag_store");
         ComponentSetting.SEND_USELOG_ID(2);
      }
      
      private function gotoFarm(param1:QuestInfo) : void
      {
         FarmModelController.instance.goFarm(PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.NickName);
      }
      
      private function gotoMainView(param1:QuestInfo) : void
      {
         BuriedManager.Instance.dispose();
         BuriedControl.Instance.dispose();
         SocketManager.Instance.out.outCard();
      }
      
      private function gotoTask(param1:QuestInfo) : void
      {
         StateManager.setState("main");
         TaskManager.instance.jumpToQuestByID(param1.QuestID);
      }
      
      private function removeEvent() : void
      {
         _taskBackBtn.removeEventListener("click",__onBackClick);
         _taskBackPopBtn.removeEventListener("click",__onBackClick);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_taskBg)
         {
            _taskBg.dispose();
            _taskBg = null;
         }
         if(_taskBackBtn)
         {
            _taskBackBtn.dispose();
            _taskBackBtn = null;
         }
      }
   }
}
