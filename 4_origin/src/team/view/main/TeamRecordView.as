package team.view.main
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import morn.core.components.Box;
   import morn.core.components.Label;
   import morn.core.ex.LevelIconEx;
   import morn.core.handlers.Handler;
   import team.TeamManager;
   import team.event.TeamEvent;
   import team.model.TeamRecordInfo;
   import team.view.mornui.TeamRecordViewUI;
   
   public class TeamRecordView extends TeamRecordViewUI
   {
       
      
      private var _bg:Bitmap;
      
      public function TeamRecordView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         list_win.renderHandler = new Handler(__onRenderWinList);
         list_fail.renderHandler = new Handler(__onRenderFailList);
         list_tab.renderHandler = new Handler(__onRenderTabList);
         list_tab.selectHandler = new Handler(__onSelectTabList);
         page_select.selectHandler = new Handler(__onPageSelect);
         TeamManager.instance.addEventListener("updatercordlist",__onUpdateRecord);
         var _loc1_:* = LanguageMgr.GetTranslation("ddt.team.allView.text47");
         teamText4.text = _loc1_;
         teamText1.text = _loc1_;
         _loc1_ = LanguageMgr.GetTranslation("ddt.team.allView.text49");
         teamText5.text = _loc1_;
         teamText2.text = _loc1_;
         _loc1_ = LanguageMgr.GetTranslation("ddt.team.allView.text48");
         teamText6.text = _loc1_;
         teamText3.text = _loc1_;
      }
      
      public function update() : void
      {
         updateBgView();
         SocketManager.Instance.out.sendTeamGetRecord(PlayerManager.Instance.Self.teamID);
      }
      
      private function __onUpdateRecord(param1:TeamEvent) : void
      {
         list_tab.array = TeamManager.instance.model.selfTeamRecordList;
         page_select.maxPage = list_tab.totalPage;
         page_select.currentPage = 1;
         updateBgView();
      }
      
      private function updateBgView() : void
      {
         var _loc1_:Array = TeamManager.instance.model.selfTeamRecordList;
         if(_loc1_ && _loc1_.length == 0)
         {
            if(_bg == null)
            {
               _bg = ComponentFactory.Instance.creatBitmap("asset.team.record.hideBg");
            }
            PositionUtils.setPos(_bg,"team.record.hideBg");
            addChild(_bg);
            _bg.visible = true;
         }
         else if(_bg)
         {
            _bg.visible = false;
         }
      }
      
      private function __onRenderFailList(param1:Box, param2:int) : void
      {
         var _loc6_:* = null;
         var _loc5_:LevelIconEx = param1.getChildByName("lv") as LevelIconEx;
         var _loc3_:Label = param1.getChildByName("name") as Label;
         var _loc4_:Label = param1.getChildByName("score") as Label;
         if(param2 < list_fail.array.length)
         {
            _loc6_ = String(list_fail.array[param2]).split(",");
            _loc5_.level = int(_loc6_[1]);
            _loc3_.text = _loc6_[2];
            if(_loc6_[0] < 0)
            {
               _loc4_.text = _loc6_[0];
            }
            else
            {
               _loc4_.text = "+" + _loc6_[0];
            }
            _loc5_.visible = true;
         }
         else
         {
            _loc3_.text = "";
            _loc4_.text = "";
            _loc5_.visible = false;
         }
      }
      
      private function __onRenderWinList(param1:Box, param2:int) : void
      {
         var _loc6_:* = null;
         var _loc5_:LevelIconEx = param1.getChildByName("lv") as LevelIconEx;
         var _loc3_:Label = param1.getChildByName("name") as Label;
         var _loc4_:Label = param1.getChildByName("score") as Label;
         if(param2 < list_win.array.length)
         {
            _loc6_ = String(list_win.array[param2]).split(",");
            _loc5_.level = int(_loc6_[1]);
            _loc3_.text = _loc6_[2];
            if(_loc6_[0] < 0)
            {
               _loc4_.text = _loc6_[0];
            }
            else
            {
               _loc4_.text = "+" + _loc6_[0];
            }
            _loc5_.visible = true;
         }
         else
         {
            _loc3_.text = "";
            _loc4_.text = "";
            _loc5_.visible = false;
         }
      }
      
      private function __onRenderTabList(param1:Box, param2:int) : void
      {
         var _loc3_:TeamRecordItem = param1 as TeamRecordItem;
         if(param2 < list_tab.array.length)
         {
            _loc3_.info = list_tab.array[param2] as TeamRecordInfo;
         }
         else
         {
            _loc3_.info = null;
         }
      }
      
      private function __onSelectTabList(param1:int) : void
      {
         SoundManager.instance.playButtonSound();
         if(list_tab.array && list_tab.array.length > param1)
         {
            updateGameInfo(list_tab.array[param1]);
         }
         else
         {
            updateGameInfo(null);
         }
      }
      
      private function __onPageSelect(param1:int) : void
      {
         SoundManager.instance.playButtonSound();
         list_tab.page = param1 - 1;
         list_tab.selectedIndex = list_tab.page * list_tab.repeatY;
      }
      
      public function updateGameInfo(param1:TeamRecordInfo) : void
      {
         var _loc2_:* = param1;
         if(_loc2_)
         {
            label_winName.text = _loc2_.getName(_loc2_.isWin);
            label_winZone.text = _loc2_.getZone(_loc2_.isWin);
            label_winKill.text = _loc2_.getKill(_loc2_.isWin).toString();
            label_winSurvival.text = _loc2_.getSurvival(_loc2_.isWin).toString();
            list_win.array = _loc2_.getMemberInfo(_loc2_.isWin);
            label_failName.text = _loc2_.getName(!_loc2_.isWin);
            label_failZone.text = _loc2_.getZone(!_loc2_.isWin);
            label_failKill.text = _loc2_.getKill(!_loc2_.isWin).toString();
            label_failSurvival.text = _loc2_.getSurvival(!_loc2_.isWin).toString();
            list_fail.array = _loc2_.getMemberInfo(!_loc2_.isWin);
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         TeamManager.instance.removeEventListener("updatercordlist",__onUpdateRecord);
         super.dispose();
      }
   }
}
