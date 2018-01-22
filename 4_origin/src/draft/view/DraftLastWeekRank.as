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
         var _loc2_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc2_["page"] = 1;
         _loc2_["size"] = 5;
         _loc2_["isOrder"] = false;
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("GetBeautyVoteList.ashx"),7,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("tank.draft.loadDraftInfoError");
         _loc1_.analyzer = new DraftListAnalyzer(getDraftPlayerInfo);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      private function getDraftPlayerInfo(param1:DraftListAnalyzer) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = _playerVec.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new DraftPlayer();
            PositionUtils.setPos(_loc2_,"lastRankView.player.Pos" + _loc4_);
            if(_loc4_ < param1.draftInfoVec.length)
            {
               param1.draftInfoVec[_loc4_].rank = _loc4_ + 1;
               _loc2_.drafInfo = param1.draftInfoVec[_loc4_];
            }
            else
            {
               _loc2_.drafInfo = null;
            }
            _loc2_.hideNotNeed(false);
            _playerVec[_loc4_] = _loc2_;
            addChild(_playerVec[_loc4_]);
            _loc4_++;
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
      
      protected function __onResponse(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 27)
         {
            __onCloseClick(null);
         }
      }
      
      protected function __onCloseClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      private function deletePlayer() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = _playerVec.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            ObjectUtils.disposeObject(_playerVec[_loc2_]);
            _playerVec[_loc2_] = null;
            _loc2_++;
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
