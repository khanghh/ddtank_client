package fightLib.script.HighThrow
{
   import ddt.manager.LanguageMgr;
   import fightLib.command.BaseFightLibCommand;
   import fightLib.command.PopupFrameCommand;
   import fightLib.script.BaseScript;
   
   public class DifficultHighThrow extends BaseScript
   {
       
      
      public function DifficultHighThrow(fightView:Object)
      {
         super(fightView);
      }
      
      override protected function initializeScript() : void
      {
         var command1:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.HighThrow.DifficultHighThrow.command1"));
         var command2:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.HighThrow.DifficultHighThrow.command2"),LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.startTrain"),startTrain);
         _commonds.push(command1);
         _commonds.push(command2);
         super.initializeScript();
      }
      
      private function startTrain() : void
      {
         _host.continueGame();
      }
      
      override public function start() : void
      {
         _host.sendClientScriptStart();
         super.start();
      }
      
      override public function finish() : void
      {
         super.finish();
         _host.sendClientScriptEnd();
         _host.enableExist();
      }
   }
}
