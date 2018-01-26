package ddt.view.character
{
   import ddt.data.player.PlayerInfo;
   import ddt.view.characterStarling.GameCharacter3D;
   
   public class CharactoryFactory
   {
      
      public static const SHOW:String = "show";
      
      public static const SHOW3D:String = "show3d";
      
      public static const GAME:String = "game";
      
      public static const GAME3D:String = "game3d";
      
      public static const CONSORTIA:String = "consortia";
      
      public static const ROOM:String = "room";
      
      private static var _characterloaderfactory:ICharacterLoaderFactory = new CharacterLoaderFactory();
       
      
      public function CharactoryFactory(){super();}
      
      public static function createCharacter(param1:PlayerInfo, param2:String = "show", param3:Boolean = false, param4:Boolean = true) : ICharacter{return null;}
   }
}
