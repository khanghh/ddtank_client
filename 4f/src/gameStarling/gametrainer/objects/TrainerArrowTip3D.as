package gameStarling.gametrainer.objects{   import bones.BoneMovieFactory;   import bones.display.BoneMovieStarling;   import com.pickgliss.utils.StarlingObjectUtils;   import starlingPhy.object.PhysicalObj3D;      public class TrainerArrowTip3D extends PhysicalObj3D   {                   private var _bannerAsset:BoneMovieStarling;            public function TrainerArrowTip3D(id:int, layerType:int = 1, mass:Number = 1, gravityFactor:Number = 1, windFactor:Number = 1, airResitFactor:Number = 1) { super(null,null,null,null,null,null); }
            private function init() : void { }
            public function play(action:String) : void { }
            override public function dispose() : void { }
   }}