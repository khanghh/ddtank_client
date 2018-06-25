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
      
      private function __onUpdateRecord(e:TeamEvent) : void
      {
         list_tab.array = TeamManager.instance.model.selfTeamRecordList;
         page_select.maxPage = list_tab.totalPage;
         page_select.currentPage = 1;
         updateBgView();
      }
      
      private function updateBgView() : void
      {
         var list:Array = TeamManager.instance.model.selfTeamRecordList;
         if(list && list.length == 0)
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
      
      private function __onRenderFailList(item:Box, index:int) : void
      {
         var info:* = null;
         var lv:LevelIconEx = item.getChildByName("lv") as LevelIconEx;
         var name:Label = item.getChildByName("name") as Label;
         var score:Label = item.getChildByName("score") as Label;
         if(index < list_fail.array.length)
         {
            info = String(list_fail.array[index]).split(",");
            lv.level = int(info[1]);
            name.text = info[2];
            if(info[0] < 0)
            {
               score.text = info[0];
            }
            else
            {
               score.text = "+" + info[0];
            }
            lv.visible = true;
         }
         else
         {
            name.text = "";
            score.text = "";
            lv.visible = false;
         }
      }
      
      private function __onRenderWinList(item:Box, index:int) : void
      {
         var info:* = null;
         var lv:LevelIconEx = item.getChildByName("lv") as LevelIconEx;
         var name:Label = item.getChildByName("name") as Label;
         var score:Label = item.getChildByName("score") as Label;
         if(index < list_win.array.length)
         {
            info = String(list_win.array[index]).split(",");
            lv.level = int(info[1]);
            name.text = info[2];
            if(info[0] < 0)
            {
               score.text = info[0];
            }
            else
            {
               score.text = "+" + info[0];
            }
            lv.visible = true;
         }
         else
         {
            name.text = "";
            score.text = "";
            lv.visible = false;
         }
      }
      
      private function __onRenderTabList(item:Box, index:int) : void
      {
         var view:TeamRecordItem = item as TeamRecordItem;
         if(index < list_tab.array.length)
         {
            view.info = list_tab.array[index] as TeamRecordInfo;
         }
         else
         {
            view.info = null;
         }
      }
      
      private function __onSelectTabList(index:int) : void
      {
         SoundManager.instance.playButtonSound();
         if(list_tab.array && list_tab.array.length > index)
         {
            updateGameInfo(list_tab.array[index]);
         }
         else
         {
            updateGameInfo(null);
         }
      }
      
      private function __onPageSelect(index:int) : void
      {
         SoundManager.instance.playButtonSound();
         list_tab.page = index - 1;
         list_tab.selectedIndex = list_tab.page * list_tab.repeatY;
      }
      
      public function updateGameInfo(value:TeamRecordInfo) : void
      {
         var info:* = value;
         if(info)
         {
            label_winName.text = info.getName(info.isWin);
            label_winZone.text = info.getZone(info.isWin);
            label_winKill.text = info.getKill(info.isWin).toString();
            label_winSurvival.text = info.getSurvival(info.isWin).toString();
            list_win.array = info.getMemberInfo(info.isWin);
            label_failName.text = info.getName(!info.isWin);
            label_failZone.text = info.getZone(!info.isWin);
            label_failKill.text = info.getKill(!info.isWin).toString();
            label_failSurvival.text = info.getSurvival(!info.isWin).toString();
            list_fail.array = info.getMemberInfo(!info.isWin);
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
