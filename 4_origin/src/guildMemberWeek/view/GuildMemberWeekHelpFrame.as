package guildMemberWeek.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class GuildMemberWeekHelpFrame extends Frame
   {
       
      
      private var _view:Sprite;
      
      private var _submitButton:TextButton;
      
      public function GuildMemberWeekHelpFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _view = new Sprite();
         _submitButton = ComponentFactory.Instance.creat("ddtstore.HelpFrame.EnterBtn");
         _submitButton.text = LanguageMgr.GetTranslation("ok");
         _submitButton.y = 400;
         _view.addChild(_submitButton);
         addToContent(_view);
         escEnable = true;
         enterEnable = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_response);
         _submitButton.addEventListener("click",_submit);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_response);
         _submitButton.removeEventListener("click",_submit);
      }
      
      public function setView(view:DisplayObject) : void
      {
         _view.addChild(view);
      }
      
      private function _submit(e:MouseEvent) : void
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
         ObjectUtils.disposeObject(_view);
         ObjectUtils.disposeObject(this);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_submitButton)
         {
            ObjectUtils.disposeObject(_submitButton);
            _submitButton = null;
         }
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
