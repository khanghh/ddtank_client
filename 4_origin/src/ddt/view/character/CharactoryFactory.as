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
       
      
      public function CharactoryFactory()
      {
         super();
      }
      
      public static function createCharacter(info:PlayerInfo, type:String = "show", multiFrame:Boolean = false, showLightn:Boolean = true) : ICharacter
      {
         var _character:* = null;
         var _loc6_:* = type;
         if("show" !== _loc6_)
         {
            if("game" !== _loc6_)
            {
               if("game3d" !== _loc6_)
               {
                  if("room" === _loc6_)
                  {
                     _character = new RoomCharacter(info);
                  }
               }
               else
               {
                  _character = new GameCharacter3D(info);
               }
            }
            else
            {
               _character = new GameCharacter(info);
            }
         }
         else
         {
            _character = new ShowCharacter(info,true,showLightn,multiFrame);
         }
         if(_character != null)
         {
            _character.setFactory(_characterloaderfactory);
         }
         return _character;
      }
   }
}
