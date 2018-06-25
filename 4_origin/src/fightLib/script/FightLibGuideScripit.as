package fightLib.script
{
   import ddt.manager.LanguageMgr;
   import fightLib.FightLibControl;
   import fightLib.command.ImmediateCommand;
   import fightLib.command.PopupHFrameCommand;
   import fightLib.command.WaittingCommand;
   
   public class FightLibGuideScripit extends BaseScript
   {
       
      
      public function FightLibGuideScripit(host:Object)
      {
         super(host);
      }
      
      private function firstEnterFrameClose() : void
      {
         if(FightLibControl.Instance.script && FightLibControl.Instance.script is FightLibGuideScripit)
         {
            FightLibControl.Instance.script.next();
         }
      }
      
      override protected function initializeScript() : void
      {
         var command1:PopupHFrameCommand = new PopupHFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.FightLibGuideScripit.welcome"),LanguageMgr.GetTranslation("ok"),firstEnterFrameClose);
         _commonds.push(command1);
         var command2:WaittingCommand = new WaittingCommand(null);
         command2.excuteFunArr.push(_host.showGuide1 as Function);
         var command3:WaittingCommand = new WaittingCommand(null);
         command3.excuteFunArr.push(_host.showGuide2 as Function);
         var command4:ImmediateCommand = new ImmediateCommand();
         command4.excuteFunArr.push(_host.hideGuide as Function);
         _commonds.push(command2);
         _commonds.push(command3);
         _commonds.push(command4);
         super.initializeScript();
      }
   }
}
