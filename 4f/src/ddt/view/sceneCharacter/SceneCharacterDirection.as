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
      
      public function SceneCharacterDirection(param1:String, param2:Boolean){super();}
      
      public static function getDirection(param1:Point, param2:Point) : SceneCharacterDirection{return null;}
      
      private static function getDegrees(param1:Point, param2:Point) : Number{return 0;}
      
      public function get isMirror() : Boolean{return false;}
      
      public function get type() : String{return null;}
   }
}
