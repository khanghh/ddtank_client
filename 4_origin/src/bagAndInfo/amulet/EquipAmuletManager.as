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
      
      public function EquipAmuletManager()
      {
         super();
      }
      
      public static function get Instance() : EquipAmuletManager
      {
         if(_instance == null)
         {
            _instance = new EquipAmuletManager();
         }
         return _instance;
      }
      
      override protected function start() : void
      {
         if(_mainFrame == null)
         {
            _mainFrame = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.mainFrame");
            lockNum = 0;
            LayerManager.Instance.addToLayer(_mainFrame,3,true,1);
            BagAndInfoManager.Instance.hideBagAndInfo();
         }
      }
      
      public function closeFrame() : void
      {
         if(_mainFrame)
         {
            ObjectUtils.disposeObject(_mainFrame);
            _mainFrame = null;
            BagAndInfoManager.Instance.showBagAndInfo();
         }
      }
      
      public function analyzer(param1:EquipAmuletDataAnalyzer) : void
      {
         _infoData = param1.data;
      }
      
      public function analyzerActivateGrade(param1:EquipAmuletActivateGradeDataAnalyzer) : void
      {
         _activateGradeData = param1.data;
      }
      
      public function analyzerPhase(param1:EquipAmuletPhaseDataAnalyzer) : void
      {
         _phaseData = param1.data;
      }
      
      public function getAmuletVo(param1:int) : EquipAmuletVo
      {
         return _infoData[param1];
      }
      
      public function getAmuletPhaseVo(param1:int) : EquipAmuletPhaseVo
      {
         return _phaseData[param1];
      }
      
      public function getAmuletPhaseVoByGrade(param1:int) : EquipAmuletPhaseVo
      {
         return _phaseData[getAmuletPhaseByGrade(param1)];
      }
      
      public function getAmuletActivateGradeVo(param1:int) : EquipAmuletActivateGradeVo
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 1;
         while(_loc3_ <= 10)
         {
            _loc2_ = _activateGradeData[_loc3_] as EquipAmuletActivateGradeVo;
            if(param1 < _loc2_.WahsTimes)
            {
               return _activateGradeData[_loc3_ - 1];
            }
            _loc3_++;
         }
         return _activateGradeData[10];
      }
      
      public function getAmuletActivateNeedCount(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 1;
         while(_loc3_ <= 10)
         {
            _loc2_ = _activateGradeData[_loc3_] as EquipAmuletActivateGradeVo;
            if(param1 < _loc2_.WahsTimes)
            {
               return _activateGradeData[_loc3_].WahsTimes;
            }
            _loc3_++;
         }
         return _activateGradeData[10].WahsTimes;
      }
      
      public function getAmuletHpByGrade(param1:int) : int
      {
         param1 = param1 <= 0?1:param1;
         var _loc2_:EquipAmuletVo = _infoData[param1];
         return _loc2_.HP;
      }
      
      public function getAmuletPhaseByGrade(param1:int) : int
      {
         param1 = param1 <= 0?1:param1;
         var _loc2_:EquipAmuletVo = _infoData[param1];
         return _loc2_.phase;
      }
      
      public function getAmuletPhaseGradeByCount(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 1;
         while(_loc3_ <= 10)
         {
            _loc2_ = _activateGradeData[_loc3_] as EquipAmuletActivateGradeVo;
            if(param1 < _loc2_.WahsTimes)
            {
               return _loc3_ - 1;
            }
            _loc3_++;
         }
         return 10;
      }
   }
}
