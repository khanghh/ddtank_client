package bagAndInfo.amulet
{
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.amulet.vo.EquipAmuletActivateGradeVo;
   import bagAndInfo.amulet.vo.EquipAmuletPhaseVo;
   import bagAndInfo.amulet.vo.EquipAmuletVo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreManager;
   import road7th.data.DictionaryData;
   
   public class EquipAmuletManager extends CoreManager
   {
      
      private static var _instance:EquipAmuletManager;
       
      
      private var _infoData:DictionaryData;
      
      private var _activateGradeData:DictionaryData;
      
      private var _phaseData:DictionaryData;
      
      public var buyStiveNum:int;
      
      public var lockNum:int;
      
      private var _mainFrame:Frame;
      
      public function EquipAmuletManager(){super();}
      
      public static function get Instance() : EquipAmuletManager{return null;}
      
      override protected function start() : void{}
      
      public function closeFrame() : void{}
      
      public function analyzer(param1:EquipAmuletDataAnalyzer) : void{}
      
      public function analyzerActivateGrade(param1:EquipAmuletActivateGradeDataAnalyzer) : void{}
      
      public function analyzerPhase(param1:EquipAmuletPhaseDataAnalyzer) : void{}
      
      public function getAmuletVo(param1:int) : EquipAmuletVo{return null;}
      
      public function getAmuletPhaseVo(param1:int) : EquipAmuletPhaseVo{return null;}
      
      public function getAmuletPhaseVoByGrade(param1:int) : EquipAmuletPhaseVo{return null;}
      
      public function getAmuletActivateGradeVo(param1:int) : EquipAmuletActivateGradeVo{return null;}
      
      public function getAmuletActivateNeedCount(param1:int) : int{return 0;}
      
      public function getAmuletHpByGrade(param1:int) : int{return 0;}
      
      public function getAmuletPhaseByGrade(param1:int) : int{return 0;}
      
      public function getAmuletPhaseGradeByCount(param1:int) : int{return 0;}
   }
}
