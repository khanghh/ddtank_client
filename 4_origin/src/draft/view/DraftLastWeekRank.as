package draft.view
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.utils.RequestVairableCreater;
   import draft.data.DraftListAnalyzer;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   
   public class DraftLastWeekRank extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _closeBtn:BaseButton;
      
      private var _playerVec:Vector.<DraftPlayer>;
      
      public function DraftLastWeekRank()
      {
         super();
         _playerVec = new Vector.<DraftPlayer>(3);
         initData();
         initView();
         initEvent();
      }
      
      private function initData() : void
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["page"] = 1;
         args["size"] = 5;
         args["isOrder"] = false;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("GetBeautyVoteList.ashx"),7,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("tank.draft.loadDraftInfoError");
         loader.analyzer = new DraftListAnalyzer(getDraftPlayerInfo);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      private function getDraftPlayerInfo(analyzer:DraftListAnalyzer) : void
      {
         var i:int = 0;
         var player:* = null;
         var count:int = _playerVec.length;
         for(i = 0; i < count; )
         {
            player = new DraftPlayer();
            PositionUtils.setPos(player,"lastRankView.player.Pos" + i);
            if(i < analyzer.draftInfoVec.length)
            {
               analyzer.draftInfoVec[i].rank = i + 1;
               player.drafInfo = analyzer.draftInfoVec[i];
            }
            else
            {
               player.drafInfo = null;
            }
            player.hideNotNeed(false);
            _playerVec[i] = player;
            addChild(_playerVec[i]);
            i++;
         }
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.draftView.lastRecordBg");
         addChild(_bg);
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("core.roundClosebt");
         PositionUtils.setPos(_closeBtn,"lastRankView.closeBtn.Pos");
         addChild(_closeBtn);
      }
      
      private function initEvent() : void
      {
         addEventListener("keyDown",__onResponse);
         _closeBtn.addEventListener("click",__onCloseClick);
      }
      
      protected function __onResponse(event:KeyboardEvent) : void
      {
         if(event.keyCode == 27)
         {
            __onCloseClick(null);
         }
      }
      
      protected function __onCloseClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      private function deletePlayer() : void
      {
         var i:int = 0;
         var count:int = _playerVec.length;
         for(i = 0; i < count; )
         {
            ObjectUtils.disposeObject(_playerVec[i]);
            _playerVec[i] = null;
            i++;
         }
         _playerVec.length = 0;
         _playerVec = null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         deletePlayer();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("keyDown",__onResponse);
         _closeBtn.removeEventListener("click",__onCloseClick);
      }
   }
}
