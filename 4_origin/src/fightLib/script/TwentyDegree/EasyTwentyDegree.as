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
      
      public function EasyTwentyDegree(param1:Object)
      {
         _arr = new Array(7013,7008,7012,7010,7006,7011);
         super(param1);
      }
      
      override protected function initializeScript() : void
      {
         var _loc1_:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.EasyTwentyDegree.command1"),"",null,"",null,true,false,_arr);
         var _loc2_:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.EasyTwentyDegree.command2"));
         var _loc5_:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.EasyTwentyDegree.command4"));
         _loc5_.excuteFunArr.push(_host.showPowerTable1 as Function);
         _loc5_.undoFunArr.push(_host.hidePowerTable as Function);
         var _loc3_:PopupFrameCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.EasyTwentyDegree.command6"),null);
         var _loc4_:ImmediateCommand = new ImmediateCommand();
         _loc4_.excuteFunArr.push(_host.splitSmallMapDrager as Function);
         _loc4_.completeFunArr.push(_host.openShowTurn as Function);
         _loc4_.completeFunArr.push(_host.skip as Function);
         var _loc7_:CreateMonsterCommand = new CreateMonsterCommand();
         _loc7_.excuteFunArr.push(_host.waitAttack as Function);
         var _loc8_:WaittingCommand = new WaittingCommand(null);
         var _loc6_:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.EasyTwentyDegree.command7"),LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.startTrain"),startTrain,LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.watchAgain"),restart,true,true);
         _loc6_.excuteFunArr.push(_host.closeShowTurn as Function);
         _loc6_.undoFunArr.push(_host.hideSmallMapSplit as Function);
         _commonds.push(_loc1_);
         _commonds.push(_loc2_);
         _commonds.push(_loc5_);
         _commonds.push(_loc3_);
         _commonds.push(_loc4_);
         _commonds.push(_loc7_);
         _commonds.push(_loc8_);
         _commonds.push(_loc6_);
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
         var _loc1_:* = null;
         if(_index < _commonds.length)
         {
            _index = Number(_index) + 1;
            _loc1_ = _commonds[Number(_index)];
            _loc1_.excute();
         }
         else
         {
            finish();
         }
      }
   }
}
