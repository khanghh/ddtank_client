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
   
   public class CampStatueBtn extends Sprite implements Disposeable
   {
       
      
      private var _mc:MovieClip;
      
      public var _arrowMc:MovieClip;
      
      public function CampStatueBtn(){super();}
      
      private function initView() : void{}
      
      private function mouseOutHander(param1:MouseEvent) : void{}
      
      private function mouseOverHander(param1:MouseEvent) : void{}
      
      private function clickHander(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
