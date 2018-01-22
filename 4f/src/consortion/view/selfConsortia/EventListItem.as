package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ConsortiaEventInfo;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class EventListItem extends Sprite implements Disposeable
   {
       
      
      private var _backGroud:Bitmap;
      
      private var _eventType:ScaleFrameImage;
      
      private var _content:FilterFrameText;
      
      public function EventListItem(){super();}
      
      private function initView() : void{}
      
      public function set info(param1:ConsortiaEventInfo) : void{}
      
      override public function get height() : Number{return 0;}
      
      public function dispose() : void{}
   }
}
