package consortion.rank
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.event.ConsortionEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class RankFrame extends Frame
   {
      
      private static const PRANK:int = 0;
      
      private static const CRANK:int = 1;
      
      private static const BRANK:int = 0;
      
      private static const LRANK:int = 1;
      
      private static const CPAGE:int = 8;
      
      protected static const PPAGE:int = 10;
      
      protected static const LIMITPAGE:int = 1;
      
      protected static var TOTALPAGE:int = 1;
       
      
      private var _index:int = 1;
      
      protected var _back:Bitmap;
      
      protected var _pRank:SelectedButton;
      
      protected var _cRank:SelectedButton;
      
      private var _group1:SelectedButtonGroup;
      
      private var _group2:SelectedButtonGroup;
      
      protected var _helpBtn:SimpleBitmapButton;
      
      protected var _rightBtn:BaseButton;
      
      protected var _leftBtn:BaseButton;
      
      protected var _pageNum:FilterFrameText;
      
      protected var _totalRank:FilterFrameText;
      
      protected var _totalScroeTxt:FilterFrameText;
      
      protected var _itemContent:Sprite;
      
      protected var _type:int;
      
      protected var _rankList:Array;
      
      protected var _prankBit:Bitmap;
      
      protected var _crankBit:Bitmap;
      
      protected var _pageBack:Scale9CornerImage;
      
      private var _isHave:Boolean;
      
      public function RankFrame()
      {
         super();
         initView();
         initEvents();
      }
      
      protected function initView() : void
      {
         escEnable = true;
         titleText = LanguageMgr.GetTranslation("ddt.consortia.title");
         _back = ComponentFactory.Instance.creat("asset.consortion.rank.groud");
         addToContent(_back);
         _prankBit = ComponentFactory.Instance.creat("consortion.rank.per");
         addToContent(_prankBit);
         _crankBit = ComponentFactory.Instance.creat("consortion.rank.cor");
         addToContent(_crankBit);
         _crankBit.visible = false;
         _pRank = ComponentFactory.Instance.creatComponentByStylename("consortion.pseleBtn");
         addToContent(_pRank);
         _cRank = ComponentFactory.Instance.creatComponentByStylename("consortion.cseleBtn");
         addToContent(_cRank);
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"consortion.rank.helpBtn",null,LanguageMgr.GetTranslation("store.view.HelpButtonText"),"consortion.rank.descript",400,480,false) as SimpleBitmapButton;
         _group1 = new SelectedButtonGroup();
         _group1.addSelectItem(_pRank);
         _group1.addSelectItem(_cRank);
         _group1.selectIndex = 0;
         _pageBack = ComponentFactory.Instance.creatComponentByStylename("asset.consortion.upDownTextBgImgAsset");
         addToContent(_pageBack);
         _rightBtn = ComponentFactory.Instance.creatComponentByStylename("consortion.rank.nextPageBtn");
         addToContent(_rightBtn);
         _leftBtn = ComponentFactory.Instance.creatComponentByStylename("consortion.rank.prePageBtn");
         addToContent(_leftBtn);
         _pageNum = ComponentFactory.Instance.creatComponentByStylename("consortion.rank.pageNum");
         _pageNum.text = "1/1";
         addToContent(_pageNum);
         _totalRank = ComponentFactory.Instance.creatComponentByStylename("consortion.rank.totalRank");
         addToContent(_totalRank);
         _totalScroeTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.rank.totalScroeTxt");
         addToContent(_totalScroeTxt);
         _itemContent = new Sprite();
         _itemContent.x = 32;
         _itemContent.y = 130;
         addToContent(_itemContent);
      }
      
      protected function initItemList(param1:Array) : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         clearItemList();
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
               _loc3_.y = (_loc3_.height + 1) * _loc2_;
               _itemContent.addChild(_loc3_);
               _loc2_++;
            }
            _loc6_++;
         }
      }
      
      protected function setRankTxt(param1:RankData) : void
      {
         if(_type == 8)
         {
            if(param1.ConsortiaID == PlayerManager.Instance.Self.ConsortiaID)
            {
               if(param1.Rank != -1)
               {
                  _totalRank.text = param1.Rank.toString();
               }
               else
               {
                  _totalRank.text = LanguageMgr.GetTranslation("ddt.consortia.norank");
               }
               _totalScroeTxt.text = param1.Score.toString();
            }
         }
         else if(param1.UserID == PlayerManager.Instance.Self.ID)
         {
            if(param1.Rank != -1)
            {
               _totalRank.text = param1.Rank.toString();
            }
            else
            {
               _totalRank.text = LanguageMgr.GetTranslation("ddt.consortia.norank");
            }
            _totalScroeTxt.text = param1.Score.toString();
         }
      }
      
      protected function clearItemList() : void
      {
         while(_itemContent.numChildren)
         {
            ObjectUtils.disposeObject(_itemContent.getChildAt(0));
         }
      }
      
      private function initEvents() : void
      {
         ConsortionModelManager.Instance.addEventListener("club_rank_list",clubRankListHander);
         ConsortionModelManager.Instance.addEventListener("club_per_list",personerRankListHander);
         _rightBtn.addEventListener("click",mouseClickHander);
         _leftBtn.addEventListener("click",mouseClickHander);
         addEventListener("response",responseHander);
         _group1.addEventListener("change",group1changeHandler);
      }
      
      private function removeEvents() : void
      {
         ConsortionModelManager.Instance.removeEventListener("club_rank_list",clubRankListHander);
         ConsortionModelManager.Instance.removeEventListener("club_per_list",personerRankListHander);
         _rightBtn.removeEventListener("click",mouseClickHander);
         _leftBtn.removeEventListener("click",mouseClickHander);
         _group1.removeEventListener("change",group1changeHandler);
         removeEventListener("response",responseHander);
      }
      
      private function personerRankListHander(param1:ConsortionEvent) : void
      {
         _type = 10;
         var _loc2_:Array = param1.data as Array;
         _rankList = setCurrtArr(_loc2_);
         setPageTxt(_loc2_);
         setPageArr();
      }
      
      private function setCurrtArr(param1:Array) : Array
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_].UserID == PlayerManager.Instance.Self.ID)
            {
               param1.splice(_loc2_,1);
               return param1;
            }
            _loc2_++;
         }
         return param1;
      }
      
      private function clubRankListHander(param1:ConsortionEvent) : void
      {
         _type = 8;
         var _loc2_:Array = param1.data as Array;
         _rankList = _loc2_;
         setPageTxt(_loc2_);
         setPageArr();
      }
      
      protected function setPageTxt(param1:Array) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:int = Math.ceil(param1.length / 10);
         if(_loc2_ == 0)
         {
            _loc2_ = 1;
         }
         TOTALPAGE = _loc2_;
         _pageNum.text = _index + "/" + TOTALPAGE;
      }
      
      private function mouseClickHander(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(!_rankList)
         {
            return;
         }
         var _loc2_:* = param1.currentTarget;
         if(_rightBtn !== _loc2_)
         {
            if(_leftBtn === _loc2_)
            {
               _index = Number(_index) - 1;
               if(_index < 1)
               {
                  _index = TOTALPAGE;
               }
            }
         }
         else
         {
            _index = Number(_index) + 1;
            if(_index > TOTALPAGE)
            {
               _index = 1;
            }
         }
         _pageNum.text = _index + "/" + TOTALPAGE;
         setPageArr();
      }
      
      protected function setPageArr() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(!_rankList)
         {
            return;
         }
         var _loc2_:int = _rankList.length;
         var _loc1_:Array = [];
         if(_type == 8)
         {
            _loc4_ = (_index - 1) * 8;
            while(_loc4_ < _index * 8)
            {
               if(_rankList[_loc4_])
               {
                  _loc1_.push(_rankList[_loc4_]);
               }
               _loc4_++;
            }
         }
         else if(_type == 10)
         {
            _loc3_ = (_index - 1) * 10;
            while(_loc3_ < _index * 10)
            {
               if(_rankList[_loc3_])
               {
                  _loc1_.push(_rankList[_loc3_]);
               }
               _loc3_++;
            }
         }
         initItemList(_loc1_);
      }
      
      private function responseHander(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      private function group1changeHandler(param1:Event) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:int = _group1.selectIndex;
         _index = 1;
         switch(int(_loc2_))
         {
            case 0:
               _prankBit.visible = true;
               _crankBit.visible = false;
               ConsortionModelManager.Instance.getPerRank();
               break;
            case 1:
               _crankBit.visible = true;
               _prankBit.visible = false;
               ConsortionModelManager.Instance.getConsortionRank();
         }
      }
      
      override public function dispose() : void
      {
         removeEvents();
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         super.dispose();
      }
   }
}
