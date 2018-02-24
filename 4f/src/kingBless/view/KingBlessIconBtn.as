package kingBless.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import kingBless.KingBlessManager;
   
   public class KingBlessIconBtn extends Component
   {
       
      
      private var _btn:MovieClip;
      
      public function KingBlessIconBtn(){super();}
      
      private function refreshCartoonState(param1:Event) : void{}
      
      private function openKingBlessFrame(param1:MouseEvent) : void{}
      
      override public function get tipData() : Object{return null;}
      
      override public function get height() : Number{return 0;}
      
      override public function dispose() : void{}
   }
}
