package bones.game
{
   import com.pickgliss.utils.StarlingObjectUtils;
   import road7th.utils.BoneMovieWrapper;
   import starling.display.Sprite;
   
   public class ActionMovieBone extends Sprite
   {
       
      
      private var _movie:BoneMovieWrapper;
      
      public function ActionMovieBone(styleName:String)
      {
         super();
         touchable = false;
         _movie = new BoneMovieWrapper(styleName);
         addChild(_movie.asDisplay);
      }
      
      public function doAction(type:String, callBack:Function = null, args:Array = null) : void
      {
         _movie.playAction(type,callBack,args);
      }
      
      public function get boneMovie() : BoneMovieWrapper
      {
         return _movie;
      }
      
      public function get currentAction() : String
      {
         return _movie.movie.currentLabel;
      }
      
      public function setActionMapping(source:String, target:String) : void
      {
         _movie.setActionMapping(source,target);
      }
      
      override public function dispose() : void
      {
         StarlingObjectUtils.disposeObject(_movie);
         _movie = null;
         super.dispose();
      }
   }
}
