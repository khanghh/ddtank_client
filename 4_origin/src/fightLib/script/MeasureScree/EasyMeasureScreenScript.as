package fightLib.script.MeasureScree
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.LanguageMgr;
   import fightLib.command.BaseFightLibCommand;
   import fightLib.command.CreateMonsterCommand;
   import fightLib.command.ImmediateCommand;
   import fightLib.command.PopUpFrameWaitCommand;
   import fightLib.command.PopupFrameCommand;
   import fightLib.command.TimeCommand;
   import fightLib.script.BaseScript;
   import flash.display.MovieClip;
   
   public class EasyMeasureScreenScript extends BaseScript
   {
       
      
      private var _arrow:MovieClip;
      
      public function EasyMeasureScreenScript(fightView:Object)
      {
         super(fightView);
      }
      
      override protected function initializeScript() : void
      {
         var command2:BaseFightLibCommand = new PopUpFrameWaitCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.EasyMeasureScreenScript.command2"),clearMaskAndArrow,null,null,null,null,false,false);
         command2.excuteFunArr.push(drawMaskAndWait);
         var command3:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.EasyMeasureScreenScript.command2"));
         var command4:BaseFightLibCommand = new ImmediateCommand();
         command4.excuteFunArr.push(_host.splitSmallMapDrager as Function);
         var command5:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.EasyMeasureScreenScript.command5"));
         var command1:BaseFightLibCommand = new TimeCommand(11000);
         command1.excuteFunArr.push(_host.shineText as Function);
         var command6:CreateMonsterCommand = new CreateMonsterCommand();
         command6.excuteFunArr.push(_host.blockSmallMap as Function);
         var command7:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.EasyMeasureScreenScript.command7"));
         var command8:BaseFightLibCommand = new TimeCommand(7500);
         command8.excuteFunArr.push(_host.shineText2 as Function);
         var command9:BaseFightLibCommand = new PopupFrameCommand(LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.EasyMeasureScreenScript.command9"),LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.understood"),null,LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.watchAgain"),restart,true,true);
         command9.completeFunArr.push(_host.activeSmallMap as Function);
         command9.undoFunArr.push(_host.restoreText as Function);
         command9.undoFunArr.push(_host.hideSmallMapSplit as Function);
         command9.undoFunArr.push(_host.activeSmallMap as Function);
         _commonds.push(command2);
         _commonds.push(command3);
         _commonds.push(command4);
         _commonds.push(command6);
         _commonds.push(command5);
         _commonds.push(command1);
         _commonds.push(command7);
         _commonds.push(command8);
         _commonds.push(command9);
         super.initializeScript();
      }
      
      override public function start() : void
      {
         _host.sendClientScriptStart();
         super.start();
      }
      
      public function drawMaskAndWait() : void
      {
         _host.drawMasks();
         _arrow = ComponentFactory.Instance.creatCustomObject("fightLib.GreenArrow");
         _host.screanAddEvent();
         LayerManager.Instance.addToLayer(_arrow,1);
      }
      
      public function clearMaskAndArrow() : void
      {
         _host.clearMask();
         _arrow.stop();
         if(_arrow.parent)
         {
            _arrow.parent.removeChild(_arrow);
         }
      }
      
      public function splitSmallMapDrager() : void
      {
         _host.splitSmallMapDrager();
      }
      
      override public function finish() : void
      {
         super.finish();
         _host.sendClientScriptEnd();
         _host.enableExist();
      }
   }
}
