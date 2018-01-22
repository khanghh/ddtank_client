package auctionHouse.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class AuctionDescriptionFrame extends Frame
   {
       
      
      private var _view:Sprite;
      
      private var _submitButton:TextButton;
      
      public function AuctionDescriptionFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _view = new Sprite();
         titleText = LanguageMgr.GetTranslation("ddt.auctionHouse.notesTitle");
         var _loc2_:Scale9CornerImage = ComponentFactory.Instance.creatComponentByStylename("ddtauction.HelpFrame.FrameBg");
         _view.addChild(_loc2_);
         var _loc1_:MovieImage = ComponentFactory.Instance.creatComponentByStylename("asset.ddtauctionHouse.NotesContent");
         _view.addChild(_loc1_);
         _submitButton = ComponentFactory.Instance.creat("auctionHouse.NotesFrameEnter");
         _submitButton.text = LanguageMgr.GetTranslation("ok");
         _view.addChild(_submitButton);
         addToContent(_view);
         enterEnable = true;
         escEnable = true;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_response);
         _submitButton.addEventListener("click",_submit);
      }
      
      private function _submit(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         close();
      }
      
      private function _response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 0 || param1.responseCode == 1 || param1.responseCode == 2)
         {
            close();
         }
      }
      
      private function close() : void
      {
         removeEventListener("response",_response);
         _submitButton.removeEventListener("click",_submit);
         ObjectUtils.disposeObject(_view);
         ObjectUtils.disposeObject(this);
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
            ObjectUtils.disposeObject(_view);
         }
         _view = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
