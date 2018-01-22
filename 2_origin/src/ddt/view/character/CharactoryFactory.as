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
      
      public static function createCharacter(param1:PlayerInfo, param2:String = "show", param3:Boolean = false, param4:Boolean = true) : ICharacter
      {
         var _loc5_:* = null;
         var _loc6_:* = param2;
         if("show" !== _loc6_)
         {
            if("game" !== _loc6_)
            {
               if("game3d" !== _loc6_)
               {
                  if("room" === _loc6_)
                  {
                     _loc5_ = new RoomCharacter(param1);
                  }
               }
               else
               {
                  _loc5_ = new GameCharacter3D(param1);
               }
            }
            else
            {
               _loc5_ = new GameCharacter(param1);
            }
         }
         else
         {
            _loc5_ = new ShowCharacter(param1,true,param4,param3);
         }
         if(_loc5_ != null)
         {
            _loc5_.setFactory(_characterloaderfactory);
         }
         return _loc5_;
      }
   }
}
