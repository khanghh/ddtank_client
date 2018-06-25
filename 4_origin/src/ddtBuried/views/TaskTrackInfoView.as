package ddtBuried.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.quest.QuestInfo;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TaskTrackInfoView extends Sprite
   {
       
      
      private var _treasure:ScaleFrameImage;
      
      private var _taskTitle:FilterFrameText;
      
      private var _taskInfo:FilterFrameText;
      
      private var _taskBtn:BaseButton;
      
      private var _func:Function;
      
      private var _info:QuestInfo;
      
      public function TaskTrackInfoView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         taskTitle = ComponentFactory.Instance.creatComponentByStylename("ddtburied.taskTitle");
         addChild(taskTitle);
         taskInfo = ComponentFactory.Instance.creatComponentByStylename("ddtburied.taskInfo");
         addChild(taskInfo);
         _taskBtn = ComponentFactory.Instance.creatComponentByStylename("ddtburied.taskInfoBtn");
         addChild(_taskBtn);
         _treasure = ComponentFactory.Instance.creatComponentByStylename("ddtburied.treasure");
         addChild(_treasure);
      }
      
      private function initEvent() : void
      {
         _taskBtn.addEventListener("click",__textClickHandle);
      }
      
      protected function __textClickHandle(event:MouseEvent) : void
      {
         if(func != null)
         {
            func.apply(null,[info]);
         }
      }
      
      private function removeEvent() : void
      {
         _taskBtn.removeEventListener("click",__textClickHandle);
      }
      
      public function taskBtnRect() : void
      {
         _taskBtn.width = taskInfo.width;
         _taskBtn.height = taskInfo.height;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(taskTitle)
         {
            taskTitle.dispose();
            taskTitle = null;
         }
         if(taskInfo)
         {
            taskInfo.dispose();
            taskInfo = null;
         }
         if(_taskBtn)
         {
            _taskBtn.dispose();
            _taskBtn = null;
         }
         if(_treasure)
         {
            _treasure.dispose();
            _treasure = null;
         }
         if(func != null)
         {
            func = null;
         }
      }
      
      public function get taskTitle() : FilterFrameText
      {
         return _taskTitle;
      }
      
      public function set taskTitle(value:FilterFrameText) : void
      {
         _taskTitle = value;
      }
      
      public function get taskInfo() : FilterFrameText
      {
         return _taskInfo;
      }
      
      public function set taskInfo(value:FilterFrameText) : void
      {
         _taskInfo = value;
      }
      
      public function set info(value:QuestInfo) : void
      {
         _info = value;
      }
      
      public function get info() : QuestInfo
      {
         return _info;
      }
      
      public function get func() : Function
      {
         return _func;
      }
      
      public function set func(value:Function) : void
      {
         _func = value;
      }
   }
}
