package room.view.smallMapInfoPanel
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MapManager;
   
   public class MissionRoomSmallMapInfoPanel extends BaseSmallMapInfoPanel
   {
       
      
      protected var _modeTitle:FilterFrameText;
      
      protected var _mode:FilterFrameText;
      
      protected var _diffTitle:FilterFrameText;
      
      protected var _diff:FilterFrameText;
      
      protected var _levelRangeTitle:FilterFrameText;
      
      protected var _levelRange:FilterFrameText;
      
      protected var _titleLoader:DisplayLoader;
      
      public function MissionRoomSmallMapInfoPanel()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _diffTitle = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.smallMap.diffTitle");
         addChild(_diffTitle);
         _modeTitle = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.smallMap.modeTitle");
         addChild(_modeTitle);
         _levelRangeTitle = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.smallMap.levelRangeTitle");
         addChild(_levelRangeTitle);
         _mode = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.smallMap.mode");
         addChild(_mode);
         _diff = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.smallMap.diff");
         addChild(_diff);
         _levelRange = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.smallMap.levelRange");
         addChild(_levelRange);
         _diffTitle.text = LanguageMgr.GetTranslation("ddt.dungeonRoom.diffTitle");
         _modeTitle.text = LanguageMgr.GetTranslation("ddt.dungeonRoom.mode");
         _levelRangeTitle.text = LanguageMgr.GetTranslation("ddt.dungeonRoom.levelRange");
         _mode.text = LanguageMgr.GetTranslation("tank.view.effort.EffortCategoryTitleItem.DUNGEON");
      }
      
      override protected function updateView() : void
      {
         super.updateView();
         var _loc1_:* = _info && _info.mapId != 0 && _info.mapId != 10000;
         _diff.visible = _loc1_;
         _loc1_ = _loc1_;
         _mode.visible = _loc1_;
         _loc1_ = _loc1_;
         _levelRange.visible = _loc1_;
         _loc1_ = _loc1_;
         _diffTitle.visible = _loc1_;
         _loc1_ = _loc1_;
         _modeTitle.visible = _loc1_;
         _levelRangeTitle.visible = _loc1_;
         solveLeveRange();
         _diff.text = LanguageMgr.GetTranslation("ddt.dungeonRoom.level" + _info.hardLevel);
      }
      
      private function solveLeveRange() : void
      {
         var array:* = null;
         if(_info == null || _info.mapId == 0 || _info.mapId == 10000)
         {
            return;
         }
         var str:String = MapManager.getDungeonInfo(_info.mapId).AdviceTips;
         if(str)
         {
            array = str.split("|");
            _levelRange.text = "";
            if(_info.hardLevel >= array.length)
            {
               return;
            }
            _levelRange.text = array[_info.hardLevel] + LanguageMgr.GetTranslation("grade");
         }
      }
      
      override public function dispose() : void
      {
         removeChild(_modeTitle);
         if(_mode)
         {
            ObjectUtils.disposeObject(_modeTitle);
            _modeTitle = null;
         }
         if(_mode)
         {
            ObjectUtils.disposeObject(_mode);
            _mode = null;
         }
         if(_diffTitle)
         {
            ObjectUtils.disposeObject(_diffTitle);
            _diffTitle = null;
         }
         if(_diff)
         {
            ObjectUtils.disposeObject(_diff);
            _diff = null;
         }
         if(_levelRangeTitle)
         {
            ObjectUtils.disposeObject(_levelRangeTitle);
            _levelRangeTitle = null;
         }
         if(_levelRange)
         {
            ObjectUtils.disposeObject(_levelRange);
            _levelRange = null;
         }
         super.dispose();
      }
   }
}
