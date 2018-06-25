package fightLib.script.MeasureScree{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import ddt.manager.LanguageMgr;   import fightLib.command.BaseFightLibCommand;   import fightLib.command.CreateMonsterCommand;   import fightLib.command.ImmediateCommand;   import fightLib.command.PopUpFrameWaitCommand;   import fightLib.command.PopupFrameCommand;   import fightLib.command.TimeCommand;   import fightLib.script.BaseScript;   import flash.display.MovieClip;      public class EasyMeasureScreenScript extends BaseScript   {                   private var _arrow:MovieClip;            public function EasyMeasureScreenScript(fightView:Object) { super(null); }
            override protected function initializeScript() : void { }
            override public function start() : void { }
            public function drawMaskAndWait() : void { }
            public function clearMaskAndArrow() : void { }
            public function splitSmallMapDrager() : void { }
            override public function finish() : void { }
   }}