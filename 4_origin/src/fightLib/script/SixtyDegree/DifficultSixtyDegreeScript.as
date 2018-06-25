package fightLib.script.SixtyDegree
{
   import ddt.manager.LanguageMgr;
   import fightLib.command.BaseFightLibCommand;
   import fightLib.command.PopupFrameCommand;
   import fightLib.script.BaseScript;
   
   public class DifficultSixtyDegreeScript extends BaseScript
   {
       
      
      public function DifficultSixtyDegreeScript(fightView:Object)
      {
         super(fightView);
      }
      
      override protected function initializeScript() : void
      {
         var command2:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.SixtyDegree.DifficultSixtyDegreeScript.command2"),LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.startTrain"));
         command2.completeFunArr.push(startTrain);
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
