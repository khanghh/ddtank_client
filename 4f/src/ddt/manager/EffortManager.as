package ddt.manager{   import bagAndInfo.BagAndInfoManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import ddt.data.effort.EffortCompleteStateInfo;   import ddt.data.effort.EffortInfo;   import ddt.data.effort.EffortProgressInfo;   import ddt.data.effort.EffortQualificationInfo;   import ddt.data.effort.EffortRewardInfo;   import ddt.events.EffortEvent;   import ddt.events.PkgEvent;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import flash.events.EventDispatcher;   import newTitle.NewTitleManager;   import newTitle.model.NewTitleModel;   import road7th.data.DictionaryData;   import road7th.utils.DateUtils;      public class EffortManager extends EventDispatcher   {            private static var _instance:EffortManager;                   private var allEfforts:DictionaryData;            private var integrationEfforts:Array;            private var roleEfforts:Array;            private var taskEfforts:Array;            private var duplicateEfforts:Array;            private var combatEfforts:Array;            private var currentEfforts:Array;            private var newlyCompleteEffort:Array;            private var preEfforts:DictionaryData;            private var preTopEfforts:DictionaryData;            private var nextEfforts:DictionaryData;            private var completeEfforts:DictionaryData;            private var completeTopEfforts:DictionaryData;            private var inCompleteEfforts:DictionaryData;            private var progressEfforts:DictionaryData;            private var honorEfforts:Array;            private var completeHonorEfforts:Array;            private var inCompleteHonorEfforts:Array;            private var honorArray:Array;            private var tempPreEfforts:DictionaryData;            private var tempCompleteEfforts:DictionaryData;            private var tempInCompleteEfforts:DictionaryData;            private var tempInCompleteTopEfforts:DictionaryData;            private var tempIntegrationEfforts:Array;            private var tempRoleEfforts:Array;            private var tempTaskEfforts:Array;            private var tempDuplicateEfforts:Array;            private var tempCombatEfforts:Array;            private var tempNewlyCompleteEffort:Array;            private var tempCompleteID:Array;            private var tempAchievementPoint:int;            private var tempPreTopEfforts:DictionaryData;            private var tempCompleteNextEfforts:DictionaryData;            private var tempHonorEfforts:Array;            private var tempCompleteHonorEfforts:Array;            private var tempInCompleteHonorEfforts:Array;            private var _isSelf:Boolean = true;            private var currentType:int;            private var count:int;            public function EffortManager() { super(); }
            public static function get Instance() : EffortManager { return null; }
            public function setup() : void { }
            private function initDictionaryData() : void { }
            public function getProgressEfforts() : DictionaryData { return null; }
            public function getEffortByID(id:int) : EffortInfo { return null; }
            public function getIntegrationEffort() : Array { return null; }
            public function getRoleEffort() : Array { return null; }
            public function getTaskEffort() : Array { return null; }
            public function getDuplicateEffort() : Array { return null; }
            public function getCombatEffort() : Array { return null; }
            public function getNewlyCompleteEffort() : Array { return null; }
            public function getHonorArray() : Array { return null; }
            private function splitHonorEffort() : void { }
            public function getHonorEfforts() : Array { return null; }
            public function getCompleteHonorEfforts() : Array { return null; }
            public function getInCompleteHonorEfforts() : Array { return null; }
            public function get completeList() : DictionaryData { return null; }
            public function get fullList() : DictionaryData { return null; }
            public function get currentEffortList() : Array { return null; }
            public function set currentEffortList(currentList:Array) : void { }
            public function setEffortType(type:int) : void { }
            private function splitEffort(dic:DictionaryData) : void { }
            private function __updateAchievement(evt:PkgEvent) : void { }
            private function __initializeAchievement(evt:PkgEvent) : void { }
            private function __initializeAchievementData(evt:PkgEvent) : void { }
            private function __userRank(event:PkgEvent) : void { }
            private function splitPreEffort() : void { }
            private function inCompletedToPreTopEfforts() : void { }
            private function estimateEffortState(info:EffortInfo) : Boolean { return false; }
            public function getTopEffort1(info:EffortInfo) : int { return 0; }
            public function getTopEffort(info:EffortInfo) : int { return 0; }
            private function getLastID(info:EffortInfo) : int { return 0; }
            public function getCompleteNextEffort1(id:int) : Array { return null; }
            public function getCompleteNextEffort(id:int) : Array { return null; }
            public function getFellNextEffort(id:int) : Array { return null; }
            private function splitCompleteEffort() : void { }
            private function __AchievementFinish(evt:PkgEvent) : void { }
            private function updateWholeProgress() : void { }
            private function updateProgress(info:EffortProgressInfo) : void { }
            private function testEffortIsComplete(info:EffortInfo) : Boolean { return false; }
            public function splitTitle(str:String) : String { return null; }
            public function testFunction(id:int) : void { }
            private function completeToInComplete(id:int) : void { }
            private function isTopEffort(info:EffortInfo) : Boolean { return false; }
            private function nextToPre() : void { }
            private function nexToPreTop(info:EffortInfo) : void { }
            public function lookUpEffort(id:int) : void { }
            private function __lookUpEffort(evt:PkgEvent) : void { }
            private function estimateTempEffortState(info:EffortInfo) : Boolean { return false; }
            public function setTempEffortType(type:int) : void { }
            private function splitTempEffort(dic:DictionaryData) : void { }
            public function getTempTopEffort(info:EffortInfo) : int { return 0; }
            public function getTempCompleteNextEffort(id:int) : Array { return null; }
            private function splitTempHonorEffort() : void { }
            public function getTempHonorEfforts() : Array { return null; }
            public function getTempCompleteHonorEfforts() : Array { return null; }
            public function getTempInCompleteHonorEfforts() : Array { return null; }
            public function tempEffortIsComplete(id:int) : Boolean { return false; }
            public function getTempIntegrationEffort() : Array { return null; }
            public function getTempRoleEffort() : Array { return null; }
            public function getTempTaskEffort() : Array { return null; }
            public function getTempDuplicateEffort() : Array { return null; }
            public function getTempCombatEffort() : Array { return null; }
            public function getTempNewlyCompleteEffort() : Array { return null; }
            public function set isSelf(value:Boolean) : void { }
            public function get isSelf() : Boolean { return false; }
            public function getTempAchievementPoint() : int { return 0; }
            public function getMainFrameVisible() : Boolean { return false; }
            public function switchVisible() : void { }
            private function __onClose(event:Event) : void { }
            private function __onProgress(event:UIModuleEvent) : void { }
            private function __onUIModuleComplete(event:UIModuleEvent) : void { }
            private function show() : void { }
            private function __frameEvent(event:FrameEvent) : void { }
   }}