package ddt.view.sceneCharacter
{
   import flash.geom.Point;
   
   public class SceneCharacterDirection
   {
      
      public static const RT:SceneCharacterDirection = new SceneCharacterDirection("RT",false);
      
      public static const LT:SceneCharacterDirection = new SceneCharacterDirection("LT",true);
      
      public static const RB:SceneCharacterDirection = new SceneCharacterDirection("RB",true);
      
      public static const LB:SceneCharacterDirection = new SceneCharacterDirection("LB",false);
       
      
      private var _isMirror:Boolean;
      
      private var _type:String;
      
      public function SceneCharacterDirection(type:String, isMirror:Boolean)
      {
         super();
         _type = type;
         this._isMirror = isMirror;
      }
      
      public static function getDirection(thisP:Point, nextP:Point) : SceneCharacterDirection
      {
         var degrees:Number = getDegrees(thisP,nextP);
         if(degrees >= 0 && degrees < 90)
         {
            return SceneCharacterDirection.RT;
         }
         if(degrees >= 90 && degrees < 180)
         {
            return SceneCharacterDirection.LT;
         }
         if(degrees >= 180 && degrees < 270)
         {
            return SceneCharacterDirection.LB;
         }
         if(degrees >= 270 && degrees < 360)
         {
            return SceneCharacterDirection.RB;
         }
         return SceneCharacterDirection.RB;
      }
      
      private static function getDegrees(thisP:Point, nextP:Point) : Number
      {
         var degrees:Number = Math.atan2(thisP.y - nextP.y,nextP.x - thisP.x) * 180 / 3.14159265358979;
         if(degrees < 0)
         {
            degrees = degrees + 360;
         }
         return degrees;
      }
      
      public function get isMirror() : Boolean
      {
         return _isMirror;
      }
      
      public function get type() : String
      {
         return _type;
      }
   }
}
