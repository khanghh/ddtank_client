package fightLib.script.MeasureScree
{
   import ddt.manager.LanguageMgr;
   import fightLib.command.BaseFightLibCommand;
   import fightLib.command.CreateMonsterCommand;
   import fightLib.command.PopupFrameCommand;
   import fightLib.command.TimeCommand;
   import fightLib.script.BaseScript;
   
   public class DifficultMeasureScreenScript extends BaseScript
   {
       
      
      public function DifficultMeasureScreenScript(fightView:Object)
      {
         super(fightView);
      }
      
      override protected function initializeScript() : void
      {
         var command2:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.DifficultMeasureScreenScript.command2"));
         var command3:CreateMonsterCommand = new CreateMonsterCommand();
         var command4:TimeCommand = new TimeCommand(2000);
         command4.completeFunArr.push(_host.leftJustifyWithPlayer);
         var command5:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.DifficultMeasureScreenScript.command4"),LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.understood"),null,LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.watchAgain"),restart,true,true);
         command5.excuteFunArr.push(_host.leftJustifyWithPlayer as Function);
         _commonds.push(command2);
         _commonds.push(command3);
         _commonds.push(command4);
         _commonds.push(command5);
         super.initializeScript();
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
