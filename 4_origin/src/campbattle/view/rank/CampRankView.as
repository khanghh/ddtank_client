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
      
      public function setList(arr:Array) : void
      {
         _rankList = arr;
         setPageTxt(_rankList);
         setPageArr();
         setMyrank();
      }
      
      private function setMyrank() : void
      {
         var i:int = 0;
         var data:* = null;
         if(!_rankList)
         {
            return;
         }
         var len:int = _rankList.length;
         for(i = 0; i < len; )
         {
            data = _rankList[i] as RankData;
            if(data.ZoneID == PlayerManager.Instance.Self.ZoneID && data.UserID == PlayerManager.Instance.Self.ID)
            {
               _totalRank.text = data.Rank.toString();
               _totalScroeTxt.text = data.Score.toString();
               break;
            }
            i++;
         }
      }
      
      override protected function initItemList(arr:Array) : void
      {
         var i:int = 0;
         var data:* = null;
         var item:* = null;
         clearItemList();
         _itemContent.x = 34;
         _itemContent.y = 95;
         var len:int = arr.length;
         var index:int = 0;
         while(i < len)
         {
            data = arr[i] as RankData;
            setRankTxt(data);
            if(data.Rank != -1)
            {
               item = new RankItem(data);
               item.setView(i);
               item.setCampBattleStlye(false);
               item.y = (item.height + 4) * index;
               _itemContent.addChild(item);
               index++;
            }
            i++;
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
