package petsBag.petsAdvanced{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.utils.PositionUtils;   import flash.events.Event;   import petsBag.data.PetFightPropertyData;   import petsBag.petsAdvanced.event.PetsAdvancedEvent;   import road7th.comm.PackageIn;      public class PetsEvolutionView extends PetsAdvancedView   {                   private var _attackTxt:FilterFrameText;            private var _attackAddedTxt:FilterFrameText;            private var _defenceTxt:FilterFrameText;            private var _defenceAddedTxt:FilterFrameText;            private var _agilityTxt:FilterFrameText;            private var _agilityAddedTxt:FilterFrameText;            private var _luckTxt:FilterFrameText;            private var _luckAddedTxt:FilterFrameText;            private var _hpTxt:FilterFrameText;            private var _hpAddedTxt:FilterFrameText;            private var _txt:FilterFrameText;            private var _evolutionGradeTxt:FilterFrameText;            private var _currentGradeInfo:PetFightPropertyData;            private var _nextGradeInfo:PetFightPropertyData;            public function PetsEvolutionView() { super(null); }
            override protected function initView() : void { }
            override protected function initData() : void { }
            private function updateData() : void { }
            private function setAddedTxt() : void { }
            override protected function __enterFrame(event:Event) : void { }
            override protected function addEvent() : void { }
            protected function __evolutionHandler(event:PkgEvent) : void { }
            override protected function removeEvent() : void { }
            override public function dispose() : void { }
   }}