package superWinner.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class SuperWinnerHelpFrame extends Frame
   {
       
      
      private var _view:Sprite;
      
      private var _submitButton:TextButton;
      
      public function SuperWinnerHelpFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _view = new Sprite();
         _submitButton = ComponentFactory.Instance.creat("roulette.helpFrameEnter");
         _submitButton.text = LanguageMgr.GetTranslation("ok");
         _view.addChild(_submitButton);
         addToContent(_view);
         escEnable = true;
         enterEnable = true;
      }
      
      public function set submitButtonPos(param1:String) : void
      {
         PositionUtils.setPos(_submitButton,param1);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_response);
         _submitButton.addEventListener("click",_submit);
      }
      
      public function setView(param1:DisplayObject) : void
      {
         _view.addChild(param1);
      }
      
      private function _submit(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function _response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 0 || param1.responseCode == 1 || param1.responseCode == 2)
         {
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEventListener("response",_response);
         if(_submitButton)
         {
            _submitButton.removeEventListener("click",_submit);
            ObjectUtils.disposeObject(_submitButton);
         }
         _submitButton = null;
         if(_view)
         {
            ObjectUtils.disposeAllChildren(_view);
         }
         _view = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
