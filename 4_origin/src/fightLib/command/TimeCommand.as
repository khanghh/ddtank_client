package fightLib.command
{
   import flash.utils.setTimeout;
   
   public class TimeCommand extends BaseFightLibCommand
   {
       
      
      private var _delay:int;
      
      public function TimeCommand(param1:int)
      {
         _delay = param1;
         super();
      }
      
      override public function excute() : void
      {
         super.excute();
      }
   }
}
