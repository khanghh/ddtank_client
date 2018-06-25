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
      
      public var lockNum:int = 0;
      
      public function ConsortiaTaskModel(target:IEventDispatcher = null)
      {
         super(target);
         initEvents();
      }
      
      private function initEvents() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(129,22),__releaseTaskCallBack);
      }
      
      private function __releaseTaskCallBack(e:PkgEvent) : void
      {
         var status:Boolean = false;
         var sf:Boolean = false;
         var id1:int = 0;
         var currentValue1:int = 0;
         var finishValue1:int = 0;
         var count1:int = 0;
         var j:int = 0;
         var id2:int = 0;
         var content1:* = null;
         var events2:* = null;
         var count:int = 0;
         var i:int = 0;
         var id:int = 0;
         var taskType:int = 0;
         var content:* = null;
         var currentValue:int = 0;
         var targetValue:int = 0;
         var finishValue:int = 0;
         var pkg:PackageIn = e.pkg as PackageIn;
         var type:int = pkg.readByte();
         if(type == 2)
         {
            status = pkg.readBoolean();
            if(!status)
            {
               taskInfo = null;
            }
         }
         else if(type == 5)
         {
            sf = pkg.readBoolean();
            taskInfo = null;
         }
         else if(type == 4)
         {
            id1 = pkg.readInt();
            currentValue1 = pkg.readInt();
            finishValue1 = pkg.readInt();
            if(taskInfo != null)
            {
               taskInfo.updateItemData(id1,currentValue1,finishValue1);
            }
         }
         else if(type == 0 || type == 1)
         {
            count1 = pkg.readInt();
            taskInfo = new ConsortiaTaskInfo();
            for(j = 0; j < count1; )
            {
               id2 = pkg.readInt();
               content1 = pkg.readUTF();
               taskInfo.addItemData(id2,content1);
               j++;
            }
         }
         else
         {
            if(type == 6)
            {
               events2 = new ConsortiaTaskEvent("Consortia_Delay_Task_Time");
               events2.value = pkg.readInt();
               dispatchEvent(events2);
               PlayerManager.Instance.Self.consortiaInfo.Riches = pkg.readInt();
               return;
            }
            count = pkg.readInt();
            if(count > 0)
            {
               taskInfo = new ConsortiaTaskInfo();
               for(i = 0; i < count; )
               {
                  id = pkg.readInt();
                  taskType = pkg.readInt();
                  content = pkg.readUTF();
                  currentValue = pkg.readInt();
                  targetValue = pkg.readInt();
                  finishValue = pkg.readInt();
                  taskInfo.addItemData(id,content,taskType,currentValue,targetValue,finishValue);
                  i++;
               }
               taskInfo.sortItem();
               taskInfo.exp = pkg.readInt();
               taskInfo.offer = pkg.readInt();
               taskInfo.contribution = pkg.readInt();
               taskInfo.riches = pkg.readInt();
               taskInfo.buffID = pkg.readInt();
               taskInfo.beginTime = pkg.readDate();
               taskInfo.time = pkg.readInt();
               taskInfo.level = pkg.readInt();
            }
            else if(count == -1)
            {
               taskInfo = null;
               isHaveTask_noRelease = true;
            }
            else
            {
               taskInfo = null;
            }
         }
         var events:ConsortiaTaskEvent = new ConsortiaTaskEvent("getConsortiaTaskInfo");
         events.value = type;
         dispatchEvent(events);
      }
      
      public function showReleaseFrame() : void
      {
         if(taskInfo != null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("consortia.task.released"));
            return;
         }
         if(isHaveTask_noRelease)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("consortia.task.havetaskNoRelease"));
         }
         var taskFrame:ConsortiaReleaseTaskFrame = ComponentFactory.Instance.creatComponentByStylename("ConsortiaReleaseTaskFrame");
         LayerManager.Instance.addToLayer(taskFrame,3,true,1);
      }
   }
}
