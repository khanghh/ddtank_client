package fightLib.script.SixtyDegree
{
   import ddt.manager.LanguageMgr;
   import fightLib.command.BaseFightLibCommand;
   import fightLib.command.CreateMonsterCommand;
   import fightLib.command.ImmediateCommand;
   import fightLib.command.PopupFrameCommand;
   import fightLib.command.WaittingCommand;
   import fightLib.script.BaseScript;
   
   public class EasySixtyDegreeScript extends BaseScript
   {
       
      
      private var _arr:Array;
      
      public function EasySixtyDegreeScript(fightView:Object)
      {
         _arr = new Array(7014,7007,7010,7009);
         super(fightView);
      }
      
      override protected function initializeScript() : void
      {
         var command1:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.SixtyDegree.EasySixtyDegreeScript.command1"),"",null,"",null,true,false,_arr);
         var command2:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.SixtyDegree.EasySixtyDegreeScript.command2"),null,_host.showPowerTable3);
         command2.undoFunArr.push(_host.hidePowerTable as Function);
         var command4:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.SixtyDegree.EasySixtyDegreeScript.command4"));
         var command5:PopupFrameCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.SixtyDegree.EasySixtyDegreeScript.command6"));
         var commmand6:ImmediateCommand = new ImmediateCommand();
         command5.completeFunArr.push(_host.openShowTurn as Function);
         command5.completeFunArr.push(_host.skip as Function);
         var command6:CreateMonsterCommand = new CreateMonsterCommand();
         command6.excuteFunArr.push(_host.waitAttack as Function);
         var command7:WaittingCommand = new WaittingCommand(null);
         var command8:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.SixtyDegree.EasySixtyDegreeScript.command7"),LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.startTrain"),startTrain,LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.watchAgain"),restart,true,true);
         command8.excuteFunArr.push(_host.closeShowTurn as Function);
         _commonds.push(command1);
         _commonds.push(command2);
         _commonds.push(command4);
         _commonds.push(command5);
         _commonds.push(command6);
         _commonds.push(command7);
         _commonds.push(command8);
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
