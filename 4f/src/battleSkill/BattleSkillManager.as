package battleSkill{   import battleSkill.analyzer.BattleSKillUpdateTemplateAnalyzer;   import battleSkill.analyzer.BattleSkillSkillTemplateAnalyzer;   import battleSkill.event.BattleSkillEvent;   import battleSkill.info.BattleSkillSkillInfo;   import battleSkill.info.BattleSkillUpdateInfo;   import ddt.CoreManager;   import ddt.events.PkgEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.GameInSocketOut;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.utils.HelperDataModuleLoad;   import ddt.utils.HelperUIModuleLoad;   import flash.events.IEventDispatcher;   import flash.utils.Dictionary;   import horse.HorseManager;   import horse.data.HorseSkillVo;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;      public class BattleSkillManager extends CoreManager   {            private static var _manager:BattleSkillManager;                   private var _skillTemplateList:Vector.<BattleSkillSkillInfo>;            private var _skillUpdateTempList:Vector.<BattleSkillUpdateInfo>;            private var _initiativeSkillList:Array = null;            private var _passiveSkillList:Array = null;            private var _activatedSkillList:Array;            private var _bringSkillList:Dictionary;            public var curUpSkillId:int;            public function BattleSkillManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : BattleSkillManager { return null; }
            override protected function start() : void { }
            private function loadresource() : void { }
            public function setup() : void { }
            public function loadTempleResource(callBack:Function) : void { }
            private function initEvent() : void { }
            private function battleSkillInfo_Handler(evt:PkgEvent) : void { }
            private function updateBattleSkill_Handler(evt:PkgEvent) : void { }
            private function bringBattleSkill_Handler(evt:PkgEvent) : void { }
            public function isEquipFull(skillId:int) : int { return 0; }
            public function isSkillHasEquip(skillId:int) : Boolean { return false; }
            public function getBringSkillList() : Dictionary { return null; }
            public function get curUseSkillList() : DictionaryData { return null; }
            public function getActivatedSkillArr() : Array { return null; }
            public function getBattleSKillInfoBySkillID(skillId:int) : BattleSkillSkillInfo { return null; }
            public function isActivateBySkillID(skillId:int) : Boolean { return false; }
            public function getActivateSkillInfoByType(type:int) : BattleSkillSkillInfo { return null; }
            public function getInitiativeSkillList() : Array { return null; }
            public function getPassiveSkillList() : Array { return null; }
            public function loadSkillTemplateList(anlyzer:BattleSkillSkillTemplateAnalyzer) : void { }
            public function loadSkillUpdateTemplateList(anlyzer:BattleSKillUpdateTemplateAnalyzer) : void { }
            public function getUpMaterialArr(skillId:int) : BattleSkillUpdateInfo { return null; }
            public function getNextlevelSkillInfo(skillId:int) : BattleSkillSkillInfo { return null; }
            private function skillSort() : void { }
            private function clearSkillCacheData() : void { }
            private function isInitiaveSkill(skillId:int) : Boolean { return false; }
            private function isPassivitySkill(skillId:int) : Boolean { return false; }
            public function sendUpSkill(skillId:int) : void { }
   }}