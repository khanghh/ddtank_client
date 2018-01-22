package bones.game
{
   import com.pickgliss.utils.StarlingObjectUtils;
   import road7th.utils.BoneMovieWrapper;
   import starling.display.Sprite;
   
   public class ActionMovieBone extends Sprite
   {
       
      
      private var _movie:BoneMovieWrapper;
      
      public function ActionMovieBone(param1:String){super();}
      
      public function doAction(param1:String, param2:Function = null, param3:Array = null) : void{}
      
      public function get boneMovie() : BoneMovieWrapper{return null;}
      
      public function get currentAction() : String{return null;}
      
      public function setActionMapping(param1:String, param2:String) : void{}
      
      override public function dispose() : void{}
   }
}
