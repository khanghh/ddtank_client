package mysteriousRoullete.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mysteriousRoullete.MysteriousControl;
   import mysteriousRoullete.MysteriousManager;
   import mysteriousRoullete.event.MysteriousEvent;
   import wonderfulActivity.views.IRightView;
   
   public class MysteriousActivityView extends Sprite implements IRightView
   {
       
      
      private var _content:Sprite;
      
      private var _bg:Bitmap;
      
      private var _view:Sprite;
      
      public var type:int = 0;
      
      public function MysteriousActivityView(){super();}
      
      public function init() : void{}
      
      public function init2() : void{}
      
      private function changeViewHandler(param1:MysteriousEvent) : void{}
      
      protected function __onSetTime(param1:MysteriousEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
      
      public function content() : Sprite{return null;}
      
      public function setState(param1:int, param2:int) : void{}
      
      public function get view() : Sprite{return null;}
   }
}
