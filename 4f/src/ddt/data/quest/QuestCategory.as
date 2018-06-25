package ddt.data.quest{   import quest.TaskManager;      public class QuestCategory   {                   private var _completedQuestArray:Array;            private var _newQuestArray:Array;            private var _questArray:Array;            public function QuestCategory() { super(); }
            public function addNew(questInfo:QuestInfo) : void { }
            public function addCompleted(questInfo:QuestInfo) : void { }
            public function addQuest(questInfo:QuestInfo) : void { }
            public function get list() : Array { return null; }
            public function get haveNew() : Boolean { return false; }
            public function get haveRecommend() : Boolean { return false; }
            public function get haveClickedNew() : Boolean { return false; }
            public function get haveCompleted() : Boolean { return false; }
            public function get completedQuestArray() : Array { return null; }
            public function get unCompleteQuestArray() : Array { return null; }
   }}