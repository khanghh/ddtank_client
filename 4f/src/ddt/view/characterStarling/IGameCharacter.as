package ddt.view.characterStarling
{
   import ddt.command.PlayerAction;
   import ddt.view.character.ICharacter;
   
   public interface IGameCharacter extends ICharacter
   {
       
      
      function set State(param1:int) : void;
      
      function get State() : int;
      
      function set isLackHp(param1:Boolean) : void;
      
      function get standAction() : PlayerAction;
   }
}
