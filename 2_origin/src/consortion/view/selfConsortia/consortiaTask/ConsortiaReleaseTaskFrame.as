package consortion.view.selfConsortia.consortiaTask
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   
   public class ConsortiaReleaseTaskFrame extends BaseAlerFrame
   {
       
      
      private var _arr:Array;
      
      private var _releaseContentTextScale9BG:Scale9CornerImage;
      
      private var _content:MovieImage;
      
      private var _levelView:ConsortiaTaskLevelView;
      
      private var _selectedLevelRecord:int;
      
      public function ConsortiaReleaseTaskFrame()
      {
         _arr = [3,3,5,5,8,8,10,10,12,12];
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         var alerInfo:AlertInfo = new AlertInfo();
         alerInfo.submitLabel = LanguageMgr.GetTranslation("consortia.task.releaseTable");
         alerInfo.title = LanguageMgr.GetTranslation("consortia.task.releaseTable.title");
         alerInfo.showCancel = false;
         info = alerInfo;
         _releaseContentTextScale9BG = ComponentFactory.Instance.creatComponentByStylename("consortion.releaseContentTextScale9BG");
         _content = ComponentFactory.Instance.creatComponentByStylename("conortion.releaseContentText");
         addToContent(_releaseContentTextScale9BG);
         addToContent(_content);
         _levelView = new ConsortiaTaskLevelView();
         PositionUtils.setPos(_levelView,"consortiaTask.levelViewPos");
         addToContent(_levelView);
      }
      
      private function initEvents() : void
      {
         addEventListener("response",__response);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__response);
      }
      
      private function __response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            if(ConsortionModelManager.Instance.TaskModel.isHaveTask_noRelease)
            {
               ConsortionModelManager.Instance.TaskModel.isHaveTask_noRelease = false;
               ObjectUtils.disposeObject(this);
            }
            else
            {
               __okClick();
               ObjectUtils.disposeObject(this);
            }
         }
         else
         {
            ObjectUtils.disposeObject(this);
         }
      }
      
      private function __okClick() : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _selectedLevelRecord = _levelView.selectedLevel;
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("consortia.task.okTable"),LanguageMgr.GetTranslation("consortia.task.OKContent",ServerConfigManager.instance.MissionRiches[_selectedLevelRecord * 2 - 1]),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
         alert.moveEnable = false;
         alert.addEventListener("response",_responseII);
      }
      
      private function _responseII(e:FrameEvent) : void
      {
         (e.currentTarget as BaseAlerFrame).removeEventListener("response",_responseII);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            if(PlayerManager.Instance.Self.consortiaInfo.Riches < ServerConfigManager.instance.MissionRiches[_selectedLevelRecord * 2 - 1])
            {
               __openRichesTip();
            }
            else
            {
               SocketManager.Instance.out.sendReleaseConsortiaTask(0,true,_selectedLevelRecord * 2 - 1);
               SocketManager.Instance.out.sendReleaseConsortiaTask(2);
               ObjectUtils.disposeObject(this);
            }
         }
         ObjectUtils.disposeObject(e.currentTarget as BaseAlerFrame);
      }
      
      private function __openRichesTip() : void
      {
         var enoughFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.consortion.skillItem.click.enough1"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
         enoughFrame.addEventListener("response",__noEnoughHandler);
      }
      
      private function __noEnoughHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               ConsortionModelManager.Instance.alertTaxFrame();
         }
         var frame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__noEnoughHandler);
         frame.dispose();
         frame = null;
      }
      
      override public function dispose() : void
      {
         removeEvents();
         _releaseContentTextScale9BG = null;
         _content = null;
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         _levelView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
