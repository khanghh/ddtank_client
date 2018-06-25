package ringStation.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class HelpView extends Frame
   {
       
      
      private var _view:Sprite;
      
      private var _bg:Scale9CornerImage;
      
      private var _submitButton:TextButton;
      
      private var _helpInfo:FilterFrameText;
      
      public function HelpView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _view = new Sprite();
         titleText = LanguageMgr.GetTranslation("ddt.ringstation.helpTitle");
         _bg = ComponentFactory.Instance.creatComponentByStylename("ringStation.helpView.frameBg");
         _view.addChild(_bg);
         _helpInfo = ComponentFactory.Instance.creatComponentByStylename("ringStation.helpView.infoText");
         _helpInfo.text = LanguageMgr.GetTranslation("ddt.ringstation.helpInfo");
         _view.addChild(_helpInfo);
         _submitButton = ComponentFactory.Instance.creat("ringStation.helpView.sumitBtn");
         _submitButton.text = LanguageMgr.GetTranslation("ok");
         _view.addChild(_submitButton);
         addToContent(_view);
         enterEnable = true;
         escEnable = true;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_response);
         _submitButton.addEventListener("click",__submit);
      }
      
      private function __submit(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         close();
      }
      
      private function _response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(e.responseCode == 0 || e.responseCode == 1 || e.responseCode == 2)
         {
            close();
         }
      }
      
      private function close() : void
      {
         removeEventListener("response",_response);
         _submitButton.removeEventListener("click",__submit);
         ObjectUtils.disposeObject(_view);
         ObjectUtils.disposeObject(this);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEventListener("response",_response);
         if(_submitButton)
         {
            _submitButton.removeEventListener("click",__submit);
            ObjectUtils.disposeObject(_submitButton);
         }
         _submitButton = null;
         if(_bg)
         {
            _bg.dispose();
            _bg = null;
         }
         if(_view)
         {
            ObjectUtils.disposeObject(_view);
            _view = null;
         }
         if(_helpInfo)
         {
            ObjectUtils.disposeObject(_helpInfo);
            _helpInfo = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
