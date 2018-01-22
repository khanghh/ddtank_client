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
         var _loc1_:AlertInfo = new AlertInfo();
         _loc1_.submitLabel = LanguageMgr.GetTranslation("consortia.task.releaseTable");
         _loc1_.title = LanguageMgr.GetTranslation("consortia.task.releasetitle");
         _loc1_.showCancel = false;
         _loc1_.showSubmit = false;
         _loc1_.enterEnable = false;
         _loc1_.escEnable = false;
         info = _loc1_;
         var _loc2_:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("consortion.submitTaskBG");
         _myResetBtn = ComponentFactory.Instance.creatComponentByStylename("consortion.submitTask.reset");
         _myOkBtn = ComponentFactory.Instance.creatComponentByStylename("consortion.submitTask.ok");
         _myResetBtn.text = LanguageMgr.GetTranslation("consortia.task.resetTable");
         _myOkBtn.text = LanguageMgr.GetTranslation("consortia.task.okTable");
         _itemTxtI = ComponentFactory.Instance.creatComponentByStylename("consortion.submitTask.itemTxtI");
         _itemTxtII = ComponentFactory.Instance.creatComponentByStylename("consortion.submitTask.itemTxtII");
         _itemTxtIII = ComponentFactory.Instance.creatComponentByStylename("consortion.submitTask.itemTxtIII");
         addToContent(_loc2_);
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
      
      private function __response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            ObjectUtils.disposeObject(this);
         }
      }
      
      private function __resetClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("consortia.task.resetTable"),LanguageMgr.GetTranslation("consortia.task.resetContent"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
         _loc2_.moveEnable = false;
         _loc2_.addEventListener("response",_responseI);
      }
      
      private function __okClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendReleaseConsortiaTask(2);
      }
      
      private function _responseI(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            if(PlayerManager.Instance.Self.Money < RESET_MONEY)
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.consortia.consortiashop.ConsortiaShopItem.Money"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
               _loc2_.addEventListener("response",__onNoMoneyResponse);
            }
            else
            {
               SocketManager.Instance.out.sendReleaseConsortiaTask(1);
            }
         }
         ObjectUtils.disposeObject(param1.currentTarget as BaseAlerFrame);
      }
      
      private function __onNoMoneyResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onNoMoneyResponse);
         _loc2_.disposeChildren = true;
         _loc2_.dispose();
         _loc2_ = null;
         if(param1.responseCode == 3)
         {
            LeavePageManager.leaveToFillPath();
         }
      }
      
      private function __getTaskInfo(param1:ConsortiaTaskEvent) : void
      {
         if(param1.value == 1)
         {
            taskInfo = ConsortionModelManager.Instance.TaskModel.taskInfo;
         }
         else if(param1.value == 2)
         {
            ObjectUtils.disposeObject(this);
         }
      }
      
      public function set taskInfo(param1:ConsortiaTaskInfo) : void
      {
         _itemTxtI.text = "1 .  " + param1.itemList[0]["content"];
         _itemTxtII.text = "2 .  " + param1.itemList[1]["content"];
         _itemTxtIII.text = "3 .  " + param1.itemList[2]["content"];
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
