package LanternFestival2015.view
{
   import LanternFestival2015.LanternFestivalManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import flash.events.MouseEvent;
   import hall.HallStateView;
   
   public class LanternFestivalInHallButton extends SimpleBitmapButton
   {
       
      
      private var _hall:HallStateView;
      
      public function LanternFestivalInHallButton(){super();}
      
      override public function dispose() : void{}
      
      public function show(param1:HallStateView) : void{}
      
      protected function onClick(param1:MouseEvent) : void{}
   }
}
