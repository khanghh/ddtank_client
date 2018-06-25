package campbattle.view.rank
{
   import campbattle.CampBattleControl;
   import campbattle.event.MapEvent;
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ScoreRankView extends Sprite implements Disposeable
   {
       
      
      private var _backBtn:MovieClip;
      
      private var _rankSprite:Sprite;
      
      private var _rankListBg:MovieClip;
      
      private var _rankBtn:SimpleBitmapButton;
      
      private var _itemList:Vector.<CampRankItem>;
      
      private var _isOut:Boolean;
      
      private var _capList:Array;
      
      public function ScoreRankView()
      {
         _capList = [LanguageMgr.GetTranslation("ddt.campBattle.qinglong"),LanguageMgr.GetTranslation("ddt.campBattle.baihu"),LanguageMgr.GetTranslation("ddt.campBattle.zhuque"),LanguageMgr.GetTranslation("ddt.campBattle.xuanwu")];
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _backBtn = ComponentFactory.Instance.creat("asset.map.outIn");
         _backBtn.buttonMode = true;
         _backBtn.gotoAndStop(2);
         addChild(_backBtn);
         _rankSprite = new Sprite();
         addChild(_rankSprite);
         _rankListBg = ComponentFactory.Instance.creat("camp.battle.rankList");
         _rankSprite.addChild(_rankListBg);
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.rankBtn");
         _rankSprite.addChild(_rankBtn);
         addRankItem();
         upDateRankList(CampBattleControl.instance.model.scoreList);
      }
      
      private function addRankItem() : void
      {
         var i:int = 0;
         var item:* = null;
         _itemList = new Vector.<CampRankItem>();
         for(i = 0; i < 4; )
         {
            item = new CampRankItem();
            item.tipData = _capList[i];
            item.y = 32 * i - 32;
            item.x = 109;
            addChild(item);
            _itemList.push(item);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         _backBtn.addEventListener("click",__onClickHander);
         _rankBtn.addEventListener("click",__onRankBtnClick);
         CampBattleControl.instance.addEventListener("camp_score_rank",__onUpdateScore);
      }
      
      private function __onUpdateScore(event:MapEvent) : void
      {
         upDateRankList(CampBattleControl.instance.model.scoreList);
      }
      
      private function upDateRankList(arr:Array) : void
      {
         var len:int = 0;
         var i:int = 0;
         if(arr)
         {
            len = Math.min(arr.length,_itemList.length);
            for(i = 0; i < len; )
            {
               _itemList[i].setItemTxt(arr[i]);
               i++;
            }
         }
      }
      
      private function __onRankBtnClick(event:MouseEvent) : void
      {
         event.stopImmediatePropagation();
         SoundManager.instance.playButtonSound();
         SocketManager.Instance.out.requestPRankList();
      }
      
      private function __onClickHander(e:MouseEvent) : void
      {
         e.stopImmediatePropagation();
         SoundManager.instance.playButtonSound();
         if(_isOut)
         {
            TweenLite.to(this,1,{"x":x - _rankSprite.width});
            _backBtn.gotoAndStop(2);
         }
         else
         {
            TweenLite.to(this,1,{"x":x + _rankSprite.width});
            _backBtn.gotoAndStop(1);
         }
         _isOut = !_isOut;
         SocketManager.Instance.out.requestCRankList();
      }
      
      private function removeEvent() : void
      {
         _backBtn.removeEventListener("click",__onClickHander);
         _rankBtn.removeEventListener("click",__onRankBtnClick);
         CampBattleControl.instance.removeEventListener("camp_score_rank",__onUpdateScore);
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEvent();
         if(_backBtn)
         {
            ObjectUtils.disposeObject(_backBtn);
         }
         _backBtn = null;
         if(_rankListBg)
         {
            ObjectUtils.disposeObject(_rankListBg);
         }
         _rankListBg = null;
         if(_rankBtn)
         {
            ObjectUtils.disposeObject(_rankBtn);
         }
         _rankBtn = null;
         if(_itemList)
         {
            for(i = 0; i < _itemList.length; )
            {
               if(_itemList[i])
               {
                  ObjectUtils.disposeObject(_itemList[i]);
               }
               _itemList[i] = null;
               i++;
            }
            _itemList.length = 0;
            _itemList = null;
         }
      }
   }
}
