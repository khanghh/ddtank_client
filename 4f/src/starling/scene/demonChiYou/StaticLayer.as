package starling.scene.demonChiYou
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieFastStarling;
   import bones.display.BoneMovieStarling;
   import demonChiYou.DemonChiYouManager;
   import starling.display.Sprite;
   
   public class StaticLayer extends Sprite
   {
       
      
      private var _bgLayer:BgLayer;
      
      private var _promptMovie:BoneMovieStarling;
      
      public function StaticLayer(){super();}
      
      override public function dispose() : void{}
   }
}
