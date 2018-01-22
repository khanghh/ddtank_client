package campbattle.view
{
   import campbattle.CampBattleControl;
   import campbattle.event.MapEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ClickDoor extends Sprite implements Disposeable
   {
       
      
      private var _mc:MovieClip;
      
      public function ClickDoor(){super();}
      
      private function initView() : void{}
      
      public function doorStatus() : void{}
      
      private function clickHander(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
