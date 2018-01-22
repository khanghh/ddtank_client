package trainer.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   
   public class VaneTipView extends BaseAlerFrame
   {
       
      
      private var _vane:Bitmap;
      
      private var _conent:FilterFrameText;
      
      public function VaneTipView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         info = new AlertInfo(LanguageMgr.GetTranslation("AlertDialog.Info"));
         _info.moveEnable = false;
         _info.showCancel = false;
         _conent = ComponentFactory.Instance.creatComponentByStylename("trainer.vane.mainFrame.conentText");
         _conent.text = LanguageMgr.GetTranslation("trainer.vane.mainFrame.conentText.text");
         addToContent(_conent);
         _vane = ComponentFactory.Instance.creatBitmap("asset.trainer.vane");
         addToContent(_vane);
         addEventListener("response",__responseHandler);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.syncWeakStep(39);
         NoviceDataManager.instance.saveNoviceData(1000,PathManager.userName(),PathManager.solveRequestPath());
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2,true,2);
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",__responseHandler);
         ObjectUtils.disposeAllChildren(this);
         _vane = null;
         _conent = null;
         super.dispose();
      }
   }
}
