package game.gametrainer.objects{   import com.pickgliss.ui.ComponentFactory;   import flash.display.MovieClip;   import phy.object.PhysicalObj;      public class TrainerArrowTip extends PhysicalObj   {                   private var _bannerAsset:MovieClip;            public function TrainerArrowTip(id:int, layerType:int = 1, mass:Number = 1, gravityFactor:Number = 1, windFactor:Number = 1, airResitFactor:Number = 1) { super(null,null,null,null,null,null); }
            private function init() : void { }
            public function gotoAndStopII(I:int) : void { }
            override public function dispose() : void { }
   }}