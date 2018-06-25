package dreamlandChallenge.view.logicView
{
   import com.greensock.TweenLite;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.map.DungeonInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MapManager;
   import ddt.manager.PathManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import dreamlandChallenge.DreamlandChallengeControl;
   import dreamlandChallenge.view.mornui.DCDuplicateChooseItemUI;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import morn.core.components.Button;
   import morn.core.components.Component;
   import morn.core.handlers.Handler;
   
   public class DCDuplicateChooseItem extends DCDuplicateChooseItemUI
   {
      
      public static const PRE_PAGE:int = 0;
      
      public static const CUR_PAGE:int = 2;
      
      public static const NEXT_PAGE:int = 1;
      
      public static const EASY:int = 1;
      
      public static const GENERAL:int = 2;
      
      public static const DIFFICULTY:int = 3;
       
      
      private var _info:DungeonInfo;
      
      private var _loader:DisplayLoader;
      
      protected var _mapShowContainer:Sprite;
      
      private var _curType:int = -1;
      
      private var _curDifficulty:int = -1;
      
      private var _control:DreamlandChallengeControl;
      
      public function DCDuplicateChooseItem(type:int, ctrl:DreamlandChallengeControl)
      {
         _curType = type;
         _control = ctrl;
         super();
         addEvent();
         updateView();
         addDifficultyTips();
         initDefaultSelectedDiff();
      }
      
      private function addEvent() : void
      {
         addEventListener("mouseOver",__overHander);
         addEventListener("mouseOut",__outHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__overHander);
         removeEventListener("mouseOut",__outHandler);
      }
      
      private function __overHander(evt:MouseEvent) : void
      {
      }
      
      private function __outHandler(evt:MouseEvent) : void
      {
      }
      
      private function initDefaultSelectedDiff() : void
      {
         if(_curType != 2)
         {
            return;
         }
         var isShow:Boolean = false;
         var offX:int = btn_difficulty1.x - 7;
         var offY:int = btn_difficulty1.y - 6;
         if(_control.checkLevMeet(1))
         {
            isShow = true;
            offX = btn_difficulty1.x - 7;
            offY = btn_difficulty1.y - 6;
            curDifficulty = 1;
         }
         else if(_control.checkLevMeet(2))
         {
            isShow = true;
            offX = btn_difficulty2.x - 7;
            offY = btn_difficulty2.y - 6;
            curDifficulty = 2;
         }
         else if(_control.checkLevMeet(3))
         {
            isShow = true;
            offX = btn_difficulty3.x - 7;
            offY = btn_difficulty3.y - 6;
            curDifficulty = 3;
         }
         eff_selected.setPosition(offX,offY);
         eff_selected.visible = isShow;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         img_borderEff.visible = false;
         eff_selected.visible = false;
         btn_difficulty1.clickHandler = new Handler(__difficultySelectedHandler,[1]);
         btn_difficulty2.clickHandler = new Handler(__difficultySelectedHandler,[2]);
         btn_difficulty3.clickHandler = new Handler(__difficultySelectedHandler,[3]);
         dc_awardView.list_award.renderHandler = new Handler(__awarsListRender);
      }
      
      private function __difficultySelectedHandler(paras:int) : void
      {
         SoundManager.instance.playButtonSound();
         if(!eff_selected.visible)
         {
            eff_selected.visible = true;
         }
         var type:* = paras;
         var btn:Button = this["btn_difficulty" + type];
         curDifficulty = type;
         TweenLite.to(eff_selected,0.3,{
            "x":btn.x - 7,
            "y":btn.y - 6
         });
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         _mapShowContainer = ComponentFactory.Instance.creatCustomObject("asset.dreamLand.dup.IconContainer");
         addChild(_mapShowContainer);
         addChild(img_borderEff);
         addChild(box_award);
      }
      
      private function updateView() : void
      {
         clearMap();
         updateConten();
         updateMap();
         updateAwards();
      }
      
      private function clearMap() : void
      {
         ObjectUtils.disposeAllChildren(_mapShowContainer);
         _mapShowContainer.removeChildren();
      }
      
      private function updateConten() : void
      {
         img_borderEff.visible = false;
         box_award.visible = type == 2;
      }
      
      protected function updateMap() : void
      {
         _mapShowContainer.removeChildren();
         if(_curType == 2)
         {
            if(_loader)
            {
               _loader.removeEventListener("complete",__showMap);
            }
            _loader = LoadResourceManager.Instance.createLoader(solvePath(),0);
            _loader.addEventListener("complete",__showMap);
            LoadResourceManager.Instance.startLoad(_loader);
         }
      }
      
      private function __showMap(evt:LoaderEvent) : void
      {
         if(evt.loader.isSuccess)
         {
            ObjectUtils.disposeAllChildren(_mapShowContainer);
            evt.loader.removeEventListener("complete",__showMap);
            _mapShowContainer.addChild(evt.loader.content as Bitmap);
         }
      }
      
      private function __awarsListRender(item:Component, index:int) : void
      {
         var render:DCAwardCell = item as DCAwardCell;
         if(index < dc_awardView.list_award.length)
         {
            render.info = dc_awardView.list_award.array[index];
         }
         else
         {
            render.info = null;
         }
      }
      
      private function updateAwards() : void
      {
         if(_info == null || _curType != 2)
         {
            return;
         }
         var dunInfo:DungeonInfo = MapManager.getDungeonInfo(info.ID);
         if(dunInfo)
         {
            switch(int(curDifficulty) - 1)
            {
               case 0:
                  dc_awardView.list_award.array = dunInfo.NormalTemplateIds.split(",");
                  break;
               case 1:
                  dc_awardView.list_award.array = dunInfo.HardTemplateIds.split(",");
                  break;
               case 2:
                  dc_awardView.list_award.array = dunInfo.TerrorTemplateIds.split(",");
            }
         }
      }
      
      private function addDifficultyTips() : void
      {
         var dif0:Object = _control.getLevByDifficlty(1);
         btn_difficulty1.tipData = LanguageMgr.GetTranslation("ddt.dreamLand.difficultyBtnTips",dif0.minLev,dif0.maxLev);
         var dif1:Object = _control.getLevByDifficlty(2);
         btn_difficulty2.tipData = LanguageMgr.GetTranslation("ddt.dreamLand.difficultyBtnTips",dif1.minLev,dif1.maxLev);
         var dif2:Object = _control.getLevByDifficlty(3);
         btn_difficulty3.tipData = LanguageMgr.GetTranslation("ddt.dreamLand.difficultyBtnTips",dif2.minLev,dif2.maxLev);
      }
      
      private function solvePath() : String
      {
         var cur:int = ServerConfigManager.instance.DreamLandId;
         if(_curType != 2)
         {
            return "asset.dremlandChallenge.duplicate.none";
         }
         return PathManager.SITE_MAIN + "image/map/" + cur + "/show0.png";
      }
      
      public function get curDifficulty() : int
      {
         return _curDifficulty;
      }
      
      public function set curDifficulty(value:int) : void
      {
         _curDifficulty = value;
         updateAwards();
      }
      
      public function get info() : DungeonInfo
      {
         return _info;
      }
      
      public function set info(value:DungeonInfo) : void
      {
         _info = value;
         updateView();
      }
      
      public function set type(value:int) : void
      {
         _curType = value;
         updateView();
      }
      
      public function get type() : int
      {
         return _curType;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         ObjectUtils.disposeAllChildren(_mapShowContainer);
         if(_mapShowContainer.parent != null)
         {
            _mapShowContainer.parent.removeChild(_mapShowContainer);
         }
         _mapShowContainer = null;
      }
   }
}
