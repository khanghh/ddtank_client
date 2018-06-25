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
      
      public function analyzer(analyzer:EquipAmuletDataAnalyzer) : void
      {
         _infoData = analyzer.data;
      }
      
      public function analyzerActivateGrade(analyzer:EquipAmuletActivateGradeDataAnalyzer) : void
      {
         _activateGradeData = analyzer.data;
      }
      
      public function analyzerPhase(analyzer:EquipAmuletPhaseDataAnalyzer) : void
      {
         _phaseData = analyzer.data;
      }
      
      public function getAmuletVo(grade:int) : EquipAmuletVo
      {
         return _infoData[grade];
      }
      
      public function getAmuletPhaseVo(phase:int) : EquipAmuletPhaseVo
      {
         return _phaseData[phase];
      }
      
      public function getAmuletPhaseVoByGrade(grade:int) : EquipAmuletPhaseVo
      {
         return _phaseData[getAmuletPhaseByGrade(grade)];
      }
      
      public function getAmuletActivateGradeVo(count:int) : EquipAmuletActivateGradeVo
      {
         var i:int = 0;
         var vo:* = null;
         for(i = 1; i <= 10; )
         {
            vo = _activateGradeData[i] as EquipAmuletActivateGradeVo;
            if(count < vo.WahsTimes)
            {
               return _activateGradeData[i - 1];
            }
            i++;
         }
         return _activateGradeData[10];
      }
      
      public function getAmuletActivateNeedCount(count:int) : int
      {
         var i:int = 0;
         var vo:* = null;
         for(i = 1; i <= 10; )
         {
            vo = _activateGradeData[i] as EquipAmuletActivateGradeVo;
            if(count < vo.WahsTimes)
            {
               return _activateGradeData[i].WahsTimes;
            }
            i++;
         }
         return _activateGradeData[10].WahsTimes;
      }
      
      public function getAmuletHpByGrade(grade:int) : int
      {
         grade = grade <= 0?1:grade;
         var vo:EquipAmuletVo = _infoData[grade];
         return vo.HP;
      }
      
      public function getAmuletPhaseByGrade(grade:int) : int
      {
         grade = grade <= 0?1:grade;
         var vo:EquipAmuletVo = _infoData[grade];
         return vo.phase;
      }
      
      public function getAmuletPhaseGradeByCount(count:int) : int
      {
         var i:int = 0;
         var vo:* = null;
         for(i = 1; i <= 10; )
         {
            vo = _activateGradeData[i] as EquipAmuletActivateGradeVo;
            if(count < vo.WahsTimes)
            {
               return i - 1;
            }
            i++;
         }
         return 10;
      }
   }
}
