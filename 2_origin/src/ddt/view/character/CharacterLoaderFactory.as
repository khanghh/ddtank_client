package ddt.view.character
{
   import ddt.data.player.PlayerInfo;
   
   public class CharacterLoaderFactory implements ICharacterLoaderFactory
   {
      
      public static const SHOW:String = "show";
      
      public static const GAME:String = "game";
      
      public static const ROOM:String = "room";
      
      public static const CONSORTIA:String = "consortia";
       
      
      public function CharacterLoaderFactory()
      {
         super();
      }
      
      public function createLoader(info:PlayerInfo, type:String = "show") : ICharacterLoader
      {
         var _loader:* = null;
         var _loc4_:* = type;
         if("show" !== _loc4_)
         {
            if("game" !== _loc4_)
            {
               if("room" === _loc4_)
               {
                  _loader = new RoomCharaterLoader(info);
               }
            }
            else
            {
               _loader = new GameCharacterLoader(info);
            }
         }
         else
         {
            _loader = new ShowCharacterLoader(info);
         }
         if(_loader != null)
         {
            _loader.setFactory(LayerFactory.instance);
         }
         return _loader;
      }
   }
}
