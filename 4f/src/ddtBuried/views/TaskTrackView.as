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
      
      public function TaskTrackView(){super();}
      
      private function _init() : void{}
      
      private function initData() : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      public function refreshTask() : void{}
      
      protected function __onBackClick(param1:MouseEvent) : void{}
      
      public function __onBackRollout(param1:MouseEvent) : void{}
      
      private function getFuncID(param1:int) : int{return 0;}
      
      private function gotoShop(param1:QuestInfo) : void{}
      
      private function gotoHall(param1:QuestInfo) : void{}
      
      private function gotoDungeon(param1:QuestInfo) : void{}
      
      private function gotoStore(param1:QuestInfo) : void{}
      
      private function gotoFarm(param1:QuestInfo) : void{}
      
      private function gotoMainView(param1:QuestInfo) : void{}
      
      private function gotoTask(param1:QuestInfo) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
