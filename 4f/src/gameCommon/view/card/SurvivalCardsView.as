package gameCommon.view.card{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CrazyTankSocketEvent;   import ddt.utils.PositionUtils;   import flash.events.Event;   import gameCommon.GameControl;   import gameCommon.model.Player;   import road7th.comm.PackageIn;      public class SurvivalCardsView extends LargeCardsView   {                   private var _flopIcon:Image;            private var _flopBg:Image;            private var _flopCount:FilterFrameText;            public function SurvivalCardsView() { super(); }
            override protected function init() : void { }
            override protected function __takeOut(e:CrazyTankSocketEvent) : void { }
            override protected function __countDownComplete(event:Event) : void { }
            override public function dispose() : void { }
   }}