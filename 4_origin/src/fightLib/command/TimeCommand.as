package fightLib.command
{
   import flash.utils.setTimeout;
   
   public class TimeCommand extends BaseFightLibCommand
   {
       
      
      private var _delay:int;
      
      public function TimeCommand(delay:int)
      {
         _delay = delay;
         super();
      }
      
      override public function excute() : void
      {
         super.excute();
      }
   }
}
