package bones.game
{
   import com.pickgliss.utils.StarlingObjectUtils;
   import road7th.utils.BoneMovieWrapper;
   import starling.display.Sprite;
   
   public class ActionMovieBone extends Sprite
   {
       
      
      private var _movie:BoneMovieWrapper;
      
      public function ActionMovieBone(param1:String)
      {
         super();
         touchable = false;
         _movie = new BoneMovieWrapper(param1);
         addChild(_movie.asDisplay);
      }
      
      public function doAction(param1:String, param2:Function = null, param3:Array = null) : void
      {
         _movie.playAction(param1,param2,param3);
      }
      
      public function get boneMovie() : BoneMovieWrapper
      {
         return _movie;
      }
      
      public function get currentAction() : String
      {
         return _movie.movie.currentLabel;
      }
      
      public function setActionMapping(param1:String, param2:String) : void
      {
         _movie.setActionMapping(param1,param2);
      }
      
      override public function dispose() : void
      {
         StarlingObjectUtils.disposeObject(_movie);
         _movie = null;
         super.dispose();
      }
   }
}
