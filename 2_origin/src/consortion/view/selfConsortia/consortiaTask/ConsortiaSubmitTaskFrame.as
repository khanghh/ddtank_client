package consortion.view.selfConsortia.consortiaTask
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class ConsortiaSubmitTaskFrame extends BaseAlerFrame
   {
      
      private static var RESET_MONEY:int = 500;
      
      private static var SUBMIT_RICHES:int = 5000;
       
      
      private var _myResetBtn:TextButton;
      
      private var _myOkBtn:TextButton;
      
      private var _itemTxtI:FilterFrameText;
      
      private var _itemTxtII:FilterFrameText;
      
      private var _itemTxtIII:FilterFrameText;
      
      public function ConsortiaSubmitTaskFrame()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         var alerInfo:AlertInfo = new AlertInfo();
         alerInfo.submitLabel = LanguageMgr.GetTranslation("consortia.task.releaseTable");
         alerInfo.title = LanguageMgr.GetTranslation("consortia.task.releasetitle");
         alerInfo.showCancel = false;
         alerInfo.showSubmit = false;
         alerInfo.enterEnable = false;
         alerInfo.escEnable = false;
         info = alerInfo;
         var bg:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("consortion.submitTaskBG");
         _myResetBtn = ComponentFactory.Instance.creatComponentByStylename("consortion.submitTask.reset");
         _myOkBtn = ComponentFactory.Instance.creatComponentByStylename("consortion.submitTask.ok");
         _myResetBtn.text = LanguageMgr.GetTranslation("consortia.task.resetTable");
         _myOkBtn.text = LanguageMgr.GetTranslation("consortia.task.okTable");
         _itemTxtI = ComponentFactory.Instance.creatComponentByStylename("consortion.submitTask.itemTxtI");
         _itemTxtII = ComponentFactory.Instance.creatComponentByStylename("consortion.submitTask.itemTxtII");
         _itemTxtIII = ComponentFactory.Instance.creatComponentByStylename("consortion.submitTask.itemTxtIII");
         addToContent(bg);
         addToContent(_myResetBtn);
         addToContent(_myOkBtn);
         addToContent(_itemTxtI);
         addToContent(_itemTxtII);
         addToContent(_itemTxtIII);
      }
      
      private function initEvents() : void
      {
         addEventListener("response",__response);
         ConsortionModelManager.Instance.TaskModel.addEventListener("getConsortiaTaskInfo",__getTaskInfo);
         _myResetBtn.addEventListener("click",__resetClick);
         _myOkBtn.addEventListener("click",__okClick);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__response);
         ConsortionModelManager.Instance.TaskModel.removeEventListener("getConsortiaTaskInfo",__getTaskInfo);
         _myResetBtn.removeEventListener("click",__resetClick);
         _myOkBtn.removeEventListener("click",__okClick);
      }
      
      private function __response(e:FrameEvent) : void
      {
         if(e.responseCode == 0 || e.responseCode == 1)
         {
            SoundManager.instance.play("008");
            ObjectUtils.disposeObject(this);
         }
      }
      
      private function __resetClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("consortia.task.resetTable"),LanguageMgr.GetTranslation("consortia.task.resetContent"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
         alert.moveEnable = false;
         alert.addEventListener("response",_responseI);
      }
      
      private function __okClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendReleaseConsortiaTask(2);
      }
      
      private function _responseI(e:FrameEvent) : void
      {
         var alert:* = null;
         (e.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            if(PlayerManager.Instance.Self.Money < RESET_MONEY)
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.consortia.consortiashop.ConsortiaShopItem.Money"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
               alert.addEventListener("response",__onNoMoneyResponse);
            }
            else
            {
               SocketManager.Instance.out.sendReleaseConsortiaTask(1);
            }
         }
         ObjectUtils.disposeObject(e.currentTarget as BaseAlerFrame);
      }
      
      private function __onNoMoneyResponse(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__onNoMoneyResponse);
         alert.disposeChildren = true;
         alert.dispose();
         alert = null;
         if(e.responseCode == 3)
         {
            LeavePageManager.leaveToFillPath();
         }
      }
      
      private function __getTaskInfo(e:ConsortiaTaskEvent) : void
      {
         if(e.value == 1)
         {
            taskInfo = ConsortionModelManager.Instance.TaskModel.taskInfo;
         }
         else if(e.value == 2)
         {
            ObjectUtils.disposeObject(this);
         }
      }
      
      public function set taskInfo(value:ConsortiaTaskInfo) : void
      {
         _itemTxtI.text = "1 .  " + value.itemList[0]["content"];
         _itemTxtII.text = "2 .  " + value.itemList[1]["content"];
         _itemTxtIII.text = "3 .  " + value.itemList[2]["content"];
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         if(_myResetBtn)
         {
            ObjectUtils.disposeObject(_myResetBtn);
         }
         _myResetBtn = null;
         if(_myOkBtn)
         {
            ObjectUtils.disposeObject(_myOkBtn);
         }
         _myOkBtn = null;
         if(_itemTxtI)
         {
            ObjectUtils.disposeObject(_itemTxtI);
         }
         _itemTxtI = null;
         if(_itemTxtII)
         {
            ObjectUtils.disposeObject(_itemTxtII);
         }
         _itemTxtII = null;
         if(_itemTxtIII)
         {
            ObjectUtils.disposeObject(_itemTxtIII);
         }
         _itemTxtIII = null;
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
