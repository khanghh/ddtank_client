package trainer.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.geom.Point;
   import trainer.controller.NewHandGuideManager;
   
   public class WelcomeView extends BaseAlerFrame
   {
       
      
      private var _bmpTxt:FilterFrameText;
      
      private var _bmpTxt1:FilterFrameText;
      
      private var _bmpNpc:Bitmap;
      
      private var _txtName:FilterFrameText;
      
      public function WelcomeView()
      {
         super();
         initView();
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bmpTxt = null;
         _bmpTxt1 = null;
         _bmpNpc = null;
         _txtName = null;
         super.dispose();
      }
      
      private function initView() : void
      {
         info = new AlertInfo();
         _info.showCancel = false;
         _info.moveEnable = false;
         _info.autoButtonGape = false;
         _info.submitLabel = LanguageMgr.GetTranslation("ok");
         _info.customPos = ComponentFactory.Instance.creatCustomObject("trainer.welcome.mainFrame.okBtn.pos");
         _bmpNpc = ComponentFactory.Instance.creat("asset.trainer.welcome.girl2");
         addToContent(_bmpNpc);
         _bmpTxt = ComponentFactory.Instance.creatComponentByStylename("trainer.welcome.conentText");
         _bmpTxt.text = LanguageMgr.GetTranslation("trainer.welcome.conentText.text");
         addToContent(_bmpTxt);
         _bmpTxt1 = ComponentFactory.Instance.creatComponentByStylename("trainer.welcome.conentText1");
         _bmpTxt1.text = LanguageMgr.GetTranslation("trainer.welcome.conentText.text1");
         addToContent(_bmpTxt1);
         _txtName = ComponentFactory.Instance.creat("trainer.welcome.name");
         _txtName.text = PlayerManager.Instance.Self.NickName;
         addToContent(_txtName);
         ChatManager.Instance.releaseFocus();
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            SoundManager.instance.play("008");
            NewHandGuideManager.Instance.mapID = 111;
            SocketManager.Instance.out.createUserGuide();
         }
      }
      
      public function show() : void
      {
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("trainer.posWelcome");
         x = _loc1_.x;
         y = _loc1_.y;
         LayerManager.Instance.addToLayer(this,2,false,1);
      }
   }
}
