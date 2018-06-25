package game.gametrainer.objects{   import com.pickgliss.ui.ComponentFactory;   import flash.display.MovieClip;   import phy.object.PhysicalObj;      public class TrainerWeapon extends PhysicalObj   {                   private var _weaponAsset:MovieClip;            public function TrainerWeapon(id:int, layerType:int = 1, mass:Number = 1, gravityFactor:Number = 1, windFactor:Number = 1, airResitFactor:Number = 1) { super(null,null,null,null,null,null); }
            private function init() : void { }
            override public function dispose() : void { }
   }}