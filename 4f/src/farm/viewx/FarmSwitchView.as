package farm.viewx{   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ChatManager;   import ddt.states.BaseStateView;   import ddt.view.MainToolBar;   import farm.FarmModelController;   import petsBag.PetsBagManager;   import petsBag.event.UpdatePetFarmGuildeEvent;      public class FarmSwitchView extends BaseStateView   {                   private var _farmMainView:FarmMainView;            public function FarmSwitchView() { super(); }
            override public function enter(prev:BaseStateView, playerId:Object = null) : void { }
            private function __updatePetFarmGuilde(e:UpdatePetFarmGuildeEvent) : void { }
            private function petFarmGuilde() : void { }
            override public function leaving(next:BaseStateView) : void { }
            override public function getBackType() : String { return null; }
            override public function getType() : String { return null; }
            override public function refresh() : void { }
            override public function dispose() : void { }
   }}