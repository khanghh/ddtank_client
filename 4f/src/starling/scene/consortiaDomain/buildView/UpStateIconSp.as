package starling.scene.consortiaDomain.buildView
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieFastStarling;
   import starling.display.Sprite;
   
   public class UpStateIconSp extends Sprite
   {
       
      
      private var _state:int = -1;
      
      private var _upgradeAni:BoneMovieFastStarling;
      
      private var _fightAni:BoneMovieFastStarling;
      
      public function UpStateIconSp(){super();}
      
      public function set state(param1:int) : void{}
      
      private function clear() : void{}
      
      override public function dispose() : void{}
   }
}
