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
      
      public function MissionRoomSmallMapInfoPanel(){super();}
      
      override protected function initView() : void{}
      
      override protected function updateView() : void{}
      
      private function solveLeveRange() : void{}
      
      override public function dispose() : void{}
   }
}
