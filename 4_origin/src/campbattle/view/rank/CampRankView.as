package campbattle.view.rank
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.rank.RankData;
   import consortion.rank.RankFrame;
   import consortion.rank.RankItem;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   
   public class CampRankView extends RankFrame
   {
       
      
      private var _bg:Bitmap;
      
      public function CampRankView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         _type = 10;
         _bg = ComponentFactory.Instance.creat("asset.campbattle.rank.groud");
         addToContent(_bg);
         super.initView();
         titleText = LanguageMgr.GetTranslation("ddt.campBattle.rankTitle");
         ObjectUtils.disposeObject(_back);
         ObjectUtils.disposeObject(_prankBit);
         ObjectUtils.disposeObject(_crankBit);
         ObjectUtils.disposeObject(_cRank);
         ObjectUtils.disposeObject(_pRank);
         ObjectUtils.disposeObject(_helpBtn);
         PositionUtils.setPos(_leftBtn,"ddtCampBattle.rankView.leftBtnPos");
         PositionUtils.setPos(_rightBtn,"ddtCampBattle.rankView.rightBtnPos");
         PositionUtils.setPos(_pageBack,"ddtCampBattle.rankView.pageBackPos");
         PositionUtils.setPos(_pageNum,"ddtCampBattle.rankView.pageNumPos");
         PositionUtils.setPos(_totalRank,"ddtCampBattle.rankView.totalRankPos");
         PositionUtils.setPos(_totalScroeTxt,"ddtCampBattle.rankView.totalScroeTxtPos");
      }
      
      public function setList(param1:Array) : void
      {
         _rankList = param1;
         setPageTxt(_rankList);
         setPageArr();
         setMyrank();
      }
      
      private function setMyrank() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         if(!_rankList)
         {
            return;
         }
         var _loc2_:int = _rankList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _rankList[_loc3_] as RankData;
            if(_loc1_.ZoneID == PlayerManager.Instance.Self.ZoneID && _loc1_.UserID == PlayerManager.Instance.Self.ID)
            {
               _totalRank.text = _loc1_.Rank.toString();
               _totalScroeTxt.text = _loc1_.Score.toString();
               break;
            }
            _loc3_++;
         }
      }
      
      override protected function initItemList(param1:Array) : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         clearItemList();
         _itemContent.x = 34;
         _itemContent.y = 95;
         var _loc5_:int = param1.length;
         var _loc2_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = param1[_loc6_] as RankData;
            setRankTxt(_loc4_);
            if(_loc4_.Rank != -1)
            {
               _loc3_ = new RankItem(_loc4_);
               _loc3_.setView(_loc6_);
               _loc3_.setCampBattleStlye(false);
               _loc3_.y = (_loc3_.height + 4) * _loc2_;
               _itemContent.addChild(_loc3_);
               _loc2_++;
            }
            _loc6_++;
         }
      }
      
      override public function dispose() : void
      {
         if(_bg)
         {
            _bg.bitmapData.dispose();
            _bg = null;
         }
         super.dispose();
      }
   }
}
