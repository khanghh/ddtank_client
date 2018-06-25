package fightLib.script.MeasureScree
{
   import ddt.manager.LanguageMgr;
   import fightLib.command.BaseFightLibCommand;
   import fightLib.command.CreateMonsterCommand;
   import fightLib.command.PopupFrameCommand;
   import fightLib.command.TimeCommand;
   import fightLib.script.BaseScript;
   
   public class NomalMeasureScreenScript extends BaseScript
   {
       
      
      public function NomalMeasureScreenScript(fightView:Object)
      {
         super(fightView);
      }
      
      override protected function initializeScript() : void
      {
         var command2:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.NomalMeasureScreenScript.command2"));
         command2.excuteFunArr.push(_host.blockSmallMap as Function);
         var command3:CreateMonsterCommand = new CreateMonsterCommand();
         var command4:TimeCommand = new TimeCommand(2000);
         command4.completeFunArr.push(_host.leftJustifyWithPlayer);
         command4.completeFunArr.push(_host.addRedPointInSmallMap as Function);
         command4.undoFunArr.push(_host.removeRedPointInSmallMap as Function);
         var command5:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.NomalMeasureScreenScript.command4"));
         var command6:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.NomalMeasureScreenScript.command5"),LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.understood"),null,LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.watchAgain"),restart,true,true);
         command6.excuteFunArr.push(_host.leftJustifyWithRedPoint as Function);
         command6.completeFunArr.push(_host.removeRedPointInSmallMap as Function);
         command6.completeFunArr.push(_host.activeSmallMap as Function);
         _commonds.push(command2);
         _commonds.push(command3);
         _commonds.push(command4);
         _commonds.push(command5);
         _commonds.push(command6);
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
