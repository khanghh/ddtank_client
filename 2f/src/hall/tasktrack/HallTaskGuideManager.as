package hall.tasktrack{   import bagAndInfo.BagAndInfoManager;   import com.pickgliss.manager.NoviceDataManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.quest.QuestInfo;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.StateManager;   import flash.display.MovieClip;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.geom.Point;   import quest.TaskManager;   import trainer.view.NewHandContainer;      public class HallTaskGuideManager extends EventDispatcher   {            public static const GUIDE_TASK_1_FINISHED:String = "guide_task_1_finished";            private static var _instance:HallTaskGuideManager;                   private var _guideTask1_mc:MovieClip;            public function HallTaskGuideManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : HallTaskGuideManager { return null; }
            public function showTask1ClickBagArrow() : void { }
            private function showTask2ClickEquipArrow(event:Event) : void { }
            private function onGuideTask1MCEnterFrame(e:Event) : void { }
            public function clearTask1Arrow() : void { }
            public function showTaskFightItemArrow() : void { }
            public function clearTaskFightItemArrow() : void { }
   }}