package LanternFestival2015.view{   import LanternFestival2015.LanternFestivalManager;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import flash.events.MouseEvent;   import hall.HallStateView;      public class LanternFestivalInHallButton extends SimpleBitmapButton   {                   private var _hall:HallStateView;            public function LanternFestivalInHallButton() { super(); }
            override public function dispose() : void { }
            public function show($hall:HallStateView) : void { }
            protected function onClick(e:MouseEvent) : void { }
   }}