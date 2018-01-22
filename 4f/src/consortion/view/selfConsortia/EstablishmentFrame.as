package consortion.view.selfConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelController;
   import consortion.ConsortionModelManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import trainer.view.NewHandContainer;
   
   public class EstablishmentFrame extends Frame
   {
       
      
      private var _shop:BaseButton;
      
      private var _bank:BaseButton;
      
      private var _skill:BaseButton;
      
      private var _bg:Bitmap;
      
      public function EstablishmentFrame(){super();}
      
      override protected function init() : void{}
      
      private function addEvents() : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function close() : void{}
      
      private function __onClickHandler(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function set backgound(param1:DisplayObject) : void{}
      
      override public function dispose() : void{}
   }
}
