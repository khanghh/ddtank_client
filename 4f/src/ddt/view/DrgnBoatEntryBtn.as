package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import drgnBoat.DrgnBoatManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class DrgnBoatEntryBtn extends Sprite implements Disposeable
   {
       
      
      private var _btn:MovieClip;
      
      public function DrgnBoatEntryBtn(){super();}
      
      private function clickHandler(param1:MouseEvent) : void{}
      
      private function canEnterHandler(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}
