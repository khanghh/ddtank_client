package trainer.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class GhostTipFrame extends Frame
   {
       
      
      private var content:Bitmap;
      
      private var _titleStr:String;
      
      private var _okStr:String;
      
      private var _okBtn:TextButton;
      
      public function GhostTipFrame()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         content = ComponentFactory.Instance.creat("asset.trainer.ghostTip");
         _titleStr = LanguageMgr.GetTranslation("tank.view.common.DeadTipDialog.title");
         titleText = _titleStr;
         _okStr = LanguageMgr.GetTranslation("tank.view.common.DeadTipDialog.btn");
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("core.simplebt");
         _okBtn.text = _okStr;
         _okBtn.x = content.width / 2 - _okBtn.width / 2;
         _okBtn.y = 185 - _okBtn.height;
         _okBtn.addEventListener("click",__onClickOK);
         addToContent(content);
         addToContent(_okBtn);
         addEventListener("response",_frameEventHandler);
      }
      
      private function __onClickOK(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",_frameEventHandler);
         _okBtn.removeEventListener("click",__onClickOK);
         _okBtn.dispose();
         super.dispose();
      }
      
      private function _frameEventHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               dispose();
         }
      }
   }
}
