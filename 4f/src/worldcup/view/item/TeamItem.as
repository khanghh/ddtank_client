package worldcup.view.item{   import ddt.manager.LanguageMgr;   import morn.core.components.CheckBox;   import morn.core.components.Image;   import morn.core.events.UIEvent;   import worldcup.WorldcupControl;   import worldcup.WorldcupManager;   import worldcup.view.mornui.item.TeamItemUI;      public class TeamItem extends TeamItemUI   {                   private var teamNameList:Array;            private var _team:int;            public function TeamItem() { super(); }
            public function get team() : int { return 0; }
            public function set team(value:int) : void { }
            public function updateView() : void { }
            private function selectHandler(e:UIEvent) : void { }
            override public function dispose() : void { }
   }}