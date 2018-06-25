package hall.tasktrack
{
   import bagAndInfo.BagAndInfoManager;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestInfo;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import quest.TaskManager;
   import trainer.view.NewHandContainer;
   
   public class HallTaskGuideManager extends EventDispatcher
   {
      
      public static const GUIDE_TASK_1_FINISHED:String = "guide_task_1_finished";
      
      private static var _instance:HallTaskGuideManager;
       
      
      private var _guideTask1_mc:MovieClip;
      
      public function HallTaskGuideManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : HallTaskGuideManager
      {
         if(_instance == null)
         {
            _instance = new HallTaskGuideManager();
         }
         return _instance;
      }
      
      public function showTask1ClickBagArrow() : void
      {
         var tmpInfo:* = null;
         if(StateManager.currentStateType == "main" && PlayerManager.Instance.Self.Grade < 10)
         {
            tmpInfo = TaskManager.instance.getQuestByID(558);
            if(TaskManager.instance.isAvailableQuest(tmpInfo,true) && !tmpInfo.isCompleted)
            {
               NewHandContainer.Instance.showArrow(123,0,new Point(858,487),"","",LayerManager.Instance.getLayerByType(2));
               BagAndInfoManager.Instance.addEventListener("open",showTask2ClickEquipArrow);
               NoviceDataManager.instance.saveNoviceData(350,PathManager.userName(),PathManager.solveRequestPath());
            }
            TaskManager.instance.checkSendRequestAddQuestDic();
         }
      }
      
      private function showTask2ClickEquipArrow(event:Event) : void
      {
         var tmpInfo:* = null;
         BagAndInfoManager.Instance.removeEventListener("open",showTask2ClickEquipArrow);
         if(StateManager.currentStateType == "main" && PlayerManager.Instance.Self.Grade < 10)
         {
            tmpInfo = TaskManager.instance.getQuestByID(558);
            if(TaskManager.instance.isAvailableQuest(tmpInfo,true) && !tmpInfo.isCompleted)
            {
               NewHandContainer.Instance.clearArrowByID(123);
               if(_guideTask1_mc == null)
               {
                  _guideTask1_mc = ComponentFactory.Instance.creat("asset.trainer.dragWeapon");
                  _guideTask1_mc.x = 588;
                  _guideTask1_mc.y = 111;
                  LayerManager.Instance.addToLayer(_guideTask1_mc,2,false,0);
                  _guideTask1_mc.gotoAndPlay(1);
                  _guideTask1_mc.addEventListener("enterFrame",onGuideTask1MCEnterFrame);
               }
            }
            TaskManager.instance.checkSendRequestAddQuestDic();
         }
      }
      
      private function onGuideTask1MCEnterFrame(e:Event) : void
      {
         if(_guideTask1_mc.currentFrame == _guideTask1_mc.totalFrames)
         {
            _guideTask1_mc.stop();
            _guideTask1_mc.removeEventListener("enterFrame",onGuideTask1MCEnterFrame);
            ObjectUtils.disposeObject(_guideTask1_mc);
            SocketManager.Instance.out.sendMoveGoods(0,31,0,6,1);
         }
      }
      
      public function clearTask1Arrow() : void
      {
         if(_guideTask1_mc != null)
         {
            _guideTask1_mc.removeEventListener("enterFrame",onGuideTask1MCEnterFrame);
            _guideTask1_mc.stop();
            ObjectUtils.disposeObject(_guideTask1_mc);
            _guideTask1_mc = null;
         }
      }
      
      public function showTaskFightItemArrow() : void
      {
         NewHandContainer.Instance.showArrow(127,0,new Point(659,442),"","",LayerManager.Instance.getLayerByType(2));
      }
      
      public function clearTaskFightItemArrow() : void
      {
         NewHandContainer.Instance.clearArrowByID(127);
      }
   }
}
