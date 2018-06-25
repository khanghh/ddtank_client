package horse{   import ddt.events.PkgEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.TimeManager;   import ddt.utils.AssetModuleLoader;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import horse.analyzer.HorsePicCherishAnalyzer;   import horse.analyzer.HorseSkillDataAnalyzer;   import horse.analyzer.HorseSkillElementDataAnalyzer;   import horse.analyzer.HorseSkillGetDataAnalyzer;   import horse.analyzer.HorseTemplateDataAnalyzer;   import horse.data.HorseEvent;   import horse.data.HorsePicCherishVo;   import horse.data.HorseSkillExpVo;   import horse.data.HorseSkillGetVo;   import horse.data.HorseSkillVo;   import horse.data.HorseTemplateVo;   import quest.TaskManager;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;      public class HorseManager extends EventDispatcher   {            public static const MountSitList:Array = [6,7,8,9,118,119,130,137,140];            public static const MountStandShakeList:Array = [4,5,6,7,8,9,103,137];            public static const MountSaddleShakeList:Array = [9,137];            public static const KeepMovingMountsArr:Array = [117];            public static const UP_HORSE_SKILL:String = "upHorseSkill";            public static const CHANGE_HORSE:String = "horseChangeHorse";            public static const CHANGE_HORSE_BYPICCHERISH:String = "changeHorseByPicCherish";            public static const UP_HORSE_STEP_1:String = "horseUpHorseStep1";            public static const UP_HORSE_STEP_2:String = "horseUpHorseStep2";            public static const CHANGE_SKILL:String = "changeSkill";            public static const UP_SKILL:String = "horseUpSkill";            public static const TAKE_UP_DOWN_SKILL:String = "horseTakeUpDownSkill";            public static const PRE_NEXT_EFFECT:String = "horsePreNextEffect";            public static const REFRESH_CUR_EFFECT:String = "horseRefreshCurEffect";            public static const GUIDE_6_TO_7:String = "horseGuide6To7";            public static const SHOWNEWSKILLVIEW:String = "showNewSkillView";            public static const HORSE_OPENVIEW:String = "horseOpenView";            public static const HORSE_HIDEVIEW:String = "horseHideView";            private static var _instance:HorseManager;                   public var isHasLevelUp:Boolean = false;            public var maxLevel:int = 89;            private var _curUseHorse:int = 0;            private var _curLevel:int = 0;            private var _curExp:int = 0;            private var _tempExp:int = 0;            private var _curHasSkillList:Vector.<HorseSkillExpVo>;            private var _curUseSkillList:DictionaryData;            private var _curHasBattleSkillList:Vector.<HorseSkillExpVo>;            private var _curUseBattleSkillList:DictionaryData;            private var _horseTemplateList:Vector.<HorseTemplateVo>;            private var _horseSkillGetList:DictionaryData;            private var _horseSkillGetIdList:DictionaryData;            private var _horseSkillGetSortArray:Array;            private var _horseSkillList:DictionaryData;            private var _horseSkillElementList:DictionaryData;            private var _horsePicCherishList:Vector.<HorsePicCherishVo>;            public var updateCherishPropertyFunc:Function;            public var isSkipFromBagView:Boolean;            public var skipHorsePicCherishId:int;            public var isNeedPlayGetNewSkillCartoon:Boolean;            public var isUpFloatCartoonComplete:Boolean;            public function HorseManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : HorseManager { return null; }
            public function isSkillHasEquip(skillId:int) : Boolean { return false; }
            public function isEqualSkillHasEquip(skillId:int) : Boolean { return false; }
            public function get curUseSkillList() : DictionaryData { return null; }
            public function get takeUpSkillPlace() : int { return 0; }
            public function get takeUpEqualSkillPlace() : int { return 0; }
            public function get horseSkillGetArray() : Array { return null; }
            public function get curHasSkillList() : Vector.<HorseSkillExpVo> { return null; }
            public function get curExp() : int { return 0; }
            public function get curHasBattleSkillList() : Vector.<HorseSkillExpVo> { return null; }
            public function get curUseBattleSkillList() : DictionaryData { return null; }
            public function get tempExp() : int { return 0; }
            public function get curLevel() : int { return 0; }
            public function get curUseHorse() : int { return 0; }
            public function get curHorseTemplateInfo() : HorseTemplateVo { return null; }
            public function get nextHorseTemplateInfo() : HorseTemplateVo { return null; }
            public function getHorseTemplateInfoByLevel(level:int) : HorseTemplateVo { return null; }
            public function getHorseSkillGetInfoById(skillId:int) : HorseSkillGetVo { return null; }
            public function getHorseSkillName(type:int, level:int) : String { return null; }
            public function getHorseSkillInfoById(skillId:int) : HorseSkillVo { return null; }
            public function getLevelBySkillId(skillId:int) : int { return 0; }
            public function horseTemplateDataSetup(data:HorseTemplateDataAnalyzer) : void { }
            public function horseSkillGetDataSetup(data:HorseSkillGetDataAnalyzer) : void { }
            public function horseSkillDataSetup(data:HorseSkillDataAnalyzer) : void { }
            public function horseSkillElementDataSetup(data:HorseSkillElementDataAnalyzer) : void { }
            public function setup() : void { }
            private function pkgHandler(event:PkgEvent) : void { }
            private function takeUpDownSkillHandler(pkg:PackageIn) : void { }
            private function upSkillHandler(pkg:PackageIn) : void { }
            private function getSkillHandler(pkg:PackageIn) : void { }
            private function upHorse(pkg:PackageIn) : void { }
            private function changeHorse(pkg:PackageIn) : void { }
            private function updateHorse() : void { }
            private function initAllData(pkg:PackageIn) : void { }
            public function getHorseLevelByExp(value:int) : int { return 0; }
            private function picCherishInfo(pkg:PackageIn) : void { }
            private function activeHandler(pkg:PackageIn) : void { }
            public function horsePicCherishDataSetup(data:HorsePicCherishAnalyzer) : void { }
            public function getHorsePicCherishData() : Vector.<HorsePicCherishVo> { return null; }
            public function show() : void { }
            private function dispatchShow() : void { }
            public function closeFrame() : void { }
            public function get horseSkillGetIdList() : DictionaryData { return null; }
            public function get horseTemplateList() : Vector.<HorseTemplateVo> { return null; }
            public function getIsSit(type:int) : Boolean { return false; }
            public function getIsShakeRide(type:int) : Boolean { return false; }
            public function getIsKeepMovingRide(type:int) : Boolean { return false; }
            public function getIsSaddleShake(type:int) : Boolean { return false; }
            private function initBattleHorseSkill(pkg:PackageIn) : void { }
            private function takeUpDownEqualSkill(pkg:PackageIn) : void { }
   }}