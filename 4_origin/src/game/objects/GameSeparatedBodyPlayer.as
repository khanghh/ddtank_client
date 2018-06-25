package game.objects
{
   import ddt.view.character.GameCharacter;
   import ddt.view.character.ShowCharacter;
   import gameCommon.model.Player;
   
   public class GameSeparatedBodyPlayer extends GamePlayer
   {
       
      
      public function GameSeparatedBodyPlayer(player:Player, character:ShowCharacter, movie:GameCharacter = null, templeId:int = 0)
      {
         super(player,character,movie,templeId);
      }
   }
}
