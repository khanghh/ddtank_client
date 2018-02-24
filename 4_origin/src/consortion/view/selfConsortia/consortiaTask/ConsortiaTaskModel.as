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
      
      public function ConsortiaTaskModel(param1:IEventDispatcher = null)
      {
         super(param1);
         initEvents();
      }
      
      private function initEvents() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(129,22),__releaseTaskCallBack);
      }
      
      private function __releaseTaskCallBack(param1:PkgEvent) : void
      {
         var _loc4_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc5_:int = 0;
         var _loc22_:int = 0;
         var _loc18_:int = 0;
         var _loc21_:int = 0;
         var _loc12_:int = 0;
         var _loc3_:int = 0;
         var _loc20_:* = null;
         var _loc19_:* = null;
         var _loc2_:int = 0;
         var _loc13_:int = 0;
         var _loc15_:int = 0;
         var _loc7_:int = 0;
         var _loc14_:* = null;
         var _loc10_:int = 0;
         var _loc17_:int = 0;
         var _loc16_:int = 0;
         var _loc8_:PackageIn = param1.pkg as PackageIn;
         var _loc11_:int = _loc8_.readByte();
         if(_loc11_ == 2)
         {
            _loc4_ = _loc8_.readBoolean();
            if(!_loc4_)
            {
               taskInfo = null;
            }
         }
         else if(_loc11_ == 5)
         {
            _loc9_ = _loc8_.readBoolean();
            taskInfo = null;
         }
         else if(_loc11_ == 4)
         {
            _loc5_ = _loc8_.readInt();
            _loc22_ = _loc8_.readInt();
            _loc18_ = _loc8_.readInt();
            if(taskInfo != null)
            {
               taskInfo.updateItemData(_loc5_,_loc22_,_loc18_);
            }
         }
         else if(_loc11_ == 0 || _loc11_ == 1)
         {
            _loc21_ = _loc8_.readInt();
            taskInfo = new ConsortiaTaskInfo();
            _loc12_ = 0;
            while(_loc12_ < _loc21_)
            {
               _loc3_ = _loc8_.readInt();
               _loc20_ = _loc8_.readUTF();
               taskInfo.addItemData(_loc3_,_loc20_);
               _loc12_++;
            }
         }
         else
         {
            if(_loc11_ == 6)
            {
               _loc19_ = new ConsortiaTaskEvent("Consortia_Delay_Task_Time");
               _loc19_.value = _loc8_.readInt();
               dispatchEvent(_loc19_);
               PlayerManager.Instance.Self.consortiaInfo.Riches = _loc8_.readInt();
               return;
            }
            _loc2_ = _loc8_.readInt();
            if(_loc2_ > 0)
            {
               taskInfo = new ConsortiaTaskInfo();
               _loc13_ = 0;
               while(_loc13_ < _loc2_)
               {
                  _loc15_ = _loc8_.readInt();
                  _loc7_ = _loc8_.readInt();
                  _loc14_ = _loc8_.readUTF();
                  _loc10_ = _loc8_.readInt();
                  _loc17_ = _loc8_.readInt();
                  _loc16_ = _loc8_.readInt();
                  taskInfo.addItemData(_loc15_,_loc14_,_loc7_,_loc10_,_loc17_,_loc16_);
                  _loc13_++;
               }
               taskInfo.sortItem();
               taskInfo.exp = _loc8_.readInt();
               taskInfo.offer = _loc8_.readInt();
               taskInfo.contribution = _loc8_.readInt();
               taskInfo.riches = _loc8_.readInt();
               taskInfo.buffID = _loc8_.readInt();
               taskInfo.beginTime = _loc8_.readDate();
               taskInfo.time = _loc8_.readInt();
               taskInfo.level = _loc8_.readInt();
            }
            else if(_loc2_ == -1)
            {
               taskInfo = null;
               isHaveTask_noRelease = true;
            }
            else
            {
               taskInfo = null;
            }
         }
         var _loc6_:ConsortiaTaskEvent = new ConsortiaTaskEvent("getConsortiaTaskInfo");
         _loc6_.value = _loc11_;
         dispatchEvent(_loc6_);
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
         var _loc1_:ConsortiaReleaseTaskFrame = ComponentFactory.Instance.creatComponentByStylename("ConsortiaReleaseTaskFrame");
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
      }
   }
}
