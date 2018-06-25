package fightLib.script.HighThrow
{
   import ddt.manager.LanguageMgr;
   import fightLib.command.BaseFightLibCommand;
   import fightLib.command.CreateMonsterCommand;
   import fightLib.command.PopupFrameCommand;
   import fightLib.command.TimeCommand;
   import fightLib.command.WaittingCommand;
   import fightLib.script.BaseScript;
   
   public class EasyHighThrow extends BaseScript
   {
       
      
      private var _arr:Array;
      
      public function EasyHighThrow(fightView:Object)
      {
         _arr = new Array(7010,7014,7009);
         super(fightView);
      }
      
      override protected function initializeScript() : void
      {
         var command1:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.HighThrow.EasyHighThrow.command1"),"",null,"",null,true,false,_arr);
         var command2:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.HighThrow.EasyHighThrow.command2"));
         var command3:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.HighThrow.EasyHighThrow.command3"),null);
         var command4:CreateMonsterCommand = new CreateMonsterCommand();
         command4.excuteFunArr.push(_host.waitAttack as Function);
         var command5:TimeCommand = new TimeCommand(2000);
         var command6:PopupFrameCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.HighThrow.EasyHighThrow.command5"),null);
         command6.completeFunArr.push(_host.openShowTurn as Function);
         command6.completeFunArr.push(_host.skip as Function);
         var command7:WaittingCommand = new WaittingCommand(null);
         var command8:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.HighThrow.EasyHighThrow.command6"),LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.startTrain"),startTrain,LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.watchAgain"),restart,true,true);
         command8.excuteFunArr.push(_host.closeShowTurn as Function);
         _commonds.push(command1);
         _commonds.push(command2);
         _commonds.push(command3);
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
