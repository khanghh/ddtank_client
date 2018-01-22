package LanternFestival2015.view
{
   import LanternFestival2015.LanternFestivalManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import flash.events.MouseEvent;
   import hall.HallStateView;
   
   public class LanternFestivalInHallButton extends SimpleBitmapButton
   {
       
      
      private var _hall:HallStateView;
      
      public function LanternFestivalInHallButton()
      {
         super();
         buttonMode = true;
         useHandCursor = true;
      }
      
      override public function dispose() : void
      {
         this.parent && this.parent.removeChild(this);
         super.dispose();
         this.removeEventListener("click",onClick);
      }
      
      public function show(param1:HallStateView) : void
      {
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         LanternFestivalManager.getInstance().onBtnInHallClicked();
      }
   }
}
