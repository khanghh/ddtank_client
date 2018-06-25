package consortion.view.selfConsortia.consortiaTask
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ConsortiaTaskView extends Sprite implements Disposeable
   {
      
      public static var RESET_MONEY:int = 500;
      
      public static var SUBMIT_RICHES:int = 5000;
       
      
      private var _myView:ConsortiaMyTaskView;
      
      private var _timeBG:Bitmap;
      
      private var _panel:ScrollPanel;
      
      private var _lastTimeTxt:FilterFrameText;
      
      private var _noTask:FilterFrameText;
      
      private var _timer:TimerJuggler;
      
      private var diff:Number;
      
      public function ConsortiaTaskView()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _timeBG = ComponentFactory.Instance.creatBitmap("asset.conortionTask.timeBG");
         _myView = ComponentFactory.Instance.creatCustomObject("ConsortiaMyTaskView");
         _panel = ComponentFactory.Instance.creatComponentByStylename("consortion.task.scrollpanel");
         _lastTimeTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.task.lastTimeTxt");
         _noTask = ComponentFactory.Instance.creatComponentByStylename("conortionTask.notaskTxt");
         _noTask.text = LanguageMgr.GetTranslation("conortionTask.notaskText");
         addChild(_timeBG);
         addChild(_panel);
         addChild(_lastTimeTxt);
         addChild(_noTask);
         _panel.setView(_myView);
         _panel.invalidateViewport();
         _noTask.visible = false;
         _timeBG.visible = false;
         _panel.visible = false;
         _lastTimeTxt.visible = false;
         SocketManager.Instance.out.sendReleaseConsortiaTask(3);
      }
      
      private function initEvents() : void
      {
         ConsortionModelManager.Instance.TaskModel.addEventListener("getConsortiaTaskInfo",__getTaskInfo);
         ConsortionModelManager.Instance.TaskModel.addEventListener("Consortia_Delay_Task_Time",__updateEndTimeInfo);
      }
      
      private function __resetClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(ConsortionModelManager.Instance.TaskModel.taskInfo == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("consortia.task.stopTable"));
         }
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("consortia.task.resetTable"),LanguageMgr.GetTranslation("consortia.task.resetContent"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
         alert.moveEnable = false;
         alert.addEventListener("response",_responseI);
      }
      
      private function _responseI(event:FrameEvent) : void
      {
         var alert:* = null;
         (event.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(event.responseCode == 2 || event.responseCode == 3)
         {
            if(ConsortionModelManager.Instance.TaskModel.taskInfo == null)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("consortia.task.stopTable"));
               ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("consortia.task.stopTable"));
            }
            else if(PlayerManager.Instance.Self.Money < RESET_MONEY)
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.consortia.consortiashop.ConsortiaShopItem.Money"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
               alert.addEventListener("response",__onNoMoneyResponse);
            }
            else
            {
               SocketManager.Instance.out.sendReleaseConsortiaTask(1);
               SocketManager.Instance.out.sendReleaseConsortiaTask(2);
            }
         }
         ObjectUtils.disposeObject(event.currentTarget as BaseAlerFrame);
      }
      
      private function __onNoMoneyResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__onNoMoneyResponse);
         alert.disposeChildren = true;
         alert.dispose();
         alert = null;
         if(event.responseCode == 3)
         {
            LeavePageManager.leaveToFillPath();
         }
      }
      
      private function removeEvents() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerOne);
         }
         ConsortionModelManager.Instance.TaskModel.removeEventListener("getConsortiaTaskInfo",__getTaskInfo);
         ConsortionModelManager.Instance.TaskModel.removeEventListener("Consortia_Delay_Task_Time",__updateEndTimeInfo);
      }
      
      private function __updateEndTimeInfo(e:ConsortiaTaskEvent) : void
      {
         diff = diff + e.value * 60;
      }
      
      private function __getTaskInfo(e:ConsortiaTaskEvent) : void
      {
         if(e.value == 3 || e.value == 2 || e.value == 4 || e.value == 5)
         {
            if(ConsortionModelManager.Instance.TaskModel.taskInfo == null)
            {
               __noTask();
            }
            else
            {
               __showTask();
            }
         }
      }
      
      private function __showTask() : void
      {
         var right:int = PlayerManager.Instance.Self.Right;
         _noTask.visible = false;
         _timeBG.visible = true;
         _panel.visible = true;
         _lastTimeTxt.visible = true;
         _myView.taskInfo = ConsortionModelManager.Instance.TaskModel.taskInfo;
         __startTimer();
      }
      
      private function __noTask() : void
      {
         _noTask.visible = true;
         _timeBG.visible = false;
         _panel.visible = false;
         _lastTimeTxt.visible = false;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerOne);
            TimerManager.getInstance().removeJugglerByTimer(_timer);
            _timer = null;
         }
      }
      
      private function __startTimer() : void
      {
         var bg:Date = ConsortionModelManager.Instance.TaskModel.taskInfo.beginTime;
         if(!bg)
         {
            return;
         }
         diff = ConsortionModelManager.Instance.TaskModel.taskInfo.time * 60 - int(TimeManager.Instance.TotalSecondToNow(bg)) + 60;
         if(_timer)
         {
            return;
         }
         _timer = TimerManager.getInstance().addTimerJuggler(1000);
         _timer.addEventListener("timer",__timerOne);
         _timer.start();
      }
      
      private function __timerOne(e:Event) : void
      {
         diff = Number(diff) - 1;
         if(diff <= 0)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerOne);
            TimerManager.getInstance().removeJugglerByTimer(_timer);
            _lastTimeTxt.text = "";
            return;
         }
         _lastTimeTxt.text = LanguageMgr.GetTranslation("consortia.task.lasttime",int(diff / 60),int(diff % 60));
      }
      
      public function dispose() : void
      {
         removeEvents();
         if(_myView)
         {
            ObjectUtils.disposeObject(_myView);
         }
         _myView = null;
         if(_timeBG)
         {
            ObjectUtils.disposeObject(_timeBG);
         }
         _timeBG = null;
         if(_panel)
         {
            ObjectUtils.disposeObject(_panel);
         }
         _panel = null;
         if(_lastTimeTxt)
         {
            ObjectUtils.disposeObject(_lastTimeTxt);
         }
         _lastTimeTxt = null;
         if(_noTask)
         {
            ObjectUtils.disposeObject(_noTask);
         }
         _noTask = null;
         if(_timer)
         {
            _timer.stop();
            TimerManager.getInstance().removeJugglerByTimer(_timer);
            _timer = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
