package gradeAwardsBoxBtn.model{   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import road7th.data.DictionaryData;      public class GradeAwardsBoxModel   {            private static var instance:GradeAwardsBoxModel;                   public function GradeAwardsBoxModel(single:inner) { super(); }
            public static function getInstance() : GradeAwardsBoxModel { return null; }
            public function getGradeAwardsBoxInfo() : InventoryItemInfo { return null; }
            public function isTheLastBoxBtn(itemInfo:InventoryItemInfo) : Boolean { return false; }
            public function canGainGradeAwardsOnButtonClicked(itemInfo:InventoryItemInfo) : int { return 0; }
            public function canGain(info:InventoryItemInfo) : Boolean { return false; }
            public function isShowGradeAwardsBtn(info:InventoryItemInfo = null) : Boolean { return false; }
            public function getRemainTime(_info:InventoryItemInfo) : String { return null; }
   }}class inner{          function inner() { super(); }
}