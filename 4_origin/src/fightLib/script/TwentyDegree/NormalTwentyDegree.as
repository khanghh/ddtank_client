package fightLib.script.TwentyDegree
{
   import ddt.manager.LanguageMgr;
   import fightLib.command.BaseFightLibCommand;
   import fightLib.command.PopupFrameCommand;
   import fightLib.script.BaseScript;
   
   public class NormalTwentyDegree extends BaseScript
   {
       
      
      public function NormalTwentyDegree(fightView:Object)
      {
         super(fightView);
      }
      
      override protected function initializeScript() : void
      {
         var command2:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.NormalTwentyDegree.command2"),LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.startTrain"),startTrain);
         command2.excuteFunArr.push(_host.showPowerTable2 as Function);
         command2.undoFunArr.push(_host.hidePowerTable as Function);
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
