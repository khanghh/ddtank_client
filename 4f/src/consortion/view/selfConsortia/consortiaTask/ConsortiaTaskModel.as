package consortion.view.selfConsortia.consortiaTask
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import road7th.comm.PackageIn;
   
   public class ConsortiaTaskModel extends EventDispatcher
   {
      
      public static const RELEASE_TASK:int = 0;
      
      public static const RESET_TASK:int = 1;
      
      public static const SUMBIT_TASK:int = 2;
      
      public static const GET_TASKINFO:int = 3;
      
      public static const UPDATE_TASKINFO:int = 4;
      
      public static const SUCCESS_FAIL:int = 5;
      
      public static const DELAY_TIME:int = 6;
       
      
      public var taskInfo:ConsortiaTaskInfo;
      
      public var isHaveTask_noRelease:Boolean = false;
      
      public function ConsortiaTaskModel(param1:IEventDispatcher = null){super(null);}
      
      private function initEvents() : void{}
      
      private function __releaseTaskCallBack(param1:PkgEvent) : void{}
      
      public function showReleaseFrame() : void{}
   }
}
