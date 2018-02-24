package ddt.view.character
{
   import ddt.data.player.PlayerInfo;
   
   public class CharacterLoaderFactory implements ICharacterLoaderFactory
   {
      
      public static const SHOW:String = "show";
      
      public static const GAME:String = "game";
      
      public static const ROOM:String = "room";
      
      public static const CONSORTIA:String = "consortia";
       
      
      public function CharacterLoaderFactory(){super();}
      
      public function createLoader(param1:PlayerInfo, param2:String = "show") : ICharacterLoader{return null;}
   }
}
