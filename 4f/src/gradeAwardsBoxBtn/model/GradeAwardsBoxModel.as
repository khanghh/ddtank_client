package gradeAwardsBoxBtn.model
{
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import road7th.data.DictionaryData;
   
   public class GradeAwardsBoxModel
   {
      
      private static var instance:GradeAwardsBoxModel;
       
      
      public function GradeAwardsBoxModel(param1:inner){super();}
      
      public static function getInstance() : GradeAwardsBoxModel{return null;}
      
      public function getGradeAwardsBoxInfo() : InventoryItemInfo{return null;}
      
      public function isTheLastBoxBtn(param1:InventoryItemInfo) : Boolean{return false;}
      
      public function canGainGradeAwardsOnButtonClicked(param1:InventoryItemInfo) : int{return 0;}
      
      public function canGain(param1:InventoryItemInfo) : Boolean{return false;}
      
      public function isShowGradeAwardsBtn(param1:InventoryItemInfo = null) : Boolean{return false;}
      
      public function getRemainTime(param1:InventoryItemInfo) : String{return null;}
   }
}

class inner
{
    
   
   function inner(){super();}
}
