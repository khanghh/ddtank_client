package cardSystem.view.cardCollect
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   
   public class CardCollectView extends Frame implements Disposeable
   {
       
      
      private var _bigBG:ScaleBitmapImage;
      
      private var _BG:MutipleImage;
      
      private var _collectBag:CollectBagView;
      
      private var _preview:CollectPreview;
      
      private var _bg1:MutipleImage;
      
      public function CardCollectView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      protected function __selectedHandler(param1:Event) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
