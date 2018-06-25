package fightLib.script.TwentyDegree
{
   import ddt.manager.LanguageMgr;
   import fightLib.command.BaseFightLibCommand;
   import fightLib.command.CreateMonsterCommand;
   import fightLib.command.ImmediateCommand;
   import fightLib.command.PopupFrameCommand;
   import fightLib.command.WaittingCommand;
   import fightLib.script.BaseScript;
   
   public class EasyTwentyDegree extends BaseScript
   {
       
      
      private var _arr:Array;
      
      public function EasyTwentyDegree(fightView:Object)
      {
         _arr = new Array(7013,7008,7012,7010,7006,7011);
         super(fightView);
      }
      
      override protected function initializeScript() : void
      {
         var command1:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.EasyTwentyDegree.command1"),"",null,"",null,true,false,_arr);
         var command2:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.EasyTwentyDegree.command2"));
         var command4:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.EasyTwentyDegree.command4"));
         command4.excuteFunArr.push(_host.showPowerTable1 as Function);
         command4.undoFunArr.push(_host.hidePowerTable as Function);
         var command5:PopupFrameCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.EasyTwentyDegree.command6"),null);
         var command6:ImmediateCommand = new ImmediateCommand();
         command6.excuteFunArr.push(_host.splitSmallMapDrager as Function);
         command6.completeFunArr.push(_host.openShowTurn as Function);
         command6.completeFunArr.push(_host.skip as Function);
         var command7:CreateMonsterCommand = new CreateMonsterCommand();
         command7.excuteFunArr.push(_host.waitAttack as Function);
         var command8:WaittingCommand = new WaittingCommand(null);
         var command9:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.EasyTwentyDegree.command7"),LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.startTrain"),startTrain,LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.watchAgain"),restart,true,true);
         command9.excuteFunArr.push(_host.closeShowTurn as Function);
         command9.undoFunArr.push(_host.hideSmallMapSplit as Function);
         _commonds.push(command1);
         _commonds.push(command2);
         _commonds.push(command4);
         _commonds.push(command5);
         _commonds.push(command6);
         _commonds.push(command7);
         _commonds.push(command8);
         _commonds.push(command9);
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
      
      override public function next() : void
      {
         var commond:* = null;
         if(_index < _commonds.length)
         {
            _index = Number(_index) + 1;
            commond = _commonds[Number(_index)];
            commond.excute();
         }
         else
         {
            finish();
         }
      }
   }
}
