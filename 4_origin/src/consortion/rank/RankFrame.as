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
      
      protected function initItemList(arr:Array) : void
      {
         var i:int = 0;
         var data:* = null;
         var item:* = null;
         clearItemList();
         var len:int = arr.length;
         for(var index:int = 0; i < len; )
         {
            data = arr[i] as RankData;
            setRankTxt(data);
            if(data.Rank != -1)
            {
               item = new RankItem(data);
               item.setView(i);
               item.y = (item.height + 1) * index;
               _itemContent.addChild(item);
               index++;
            }
            i++;
         }
      }
      
      protected function setRankTxt(data:RankData) : void
      {
         if(_type == 8)
         {
            if(data.ConsortiaID == PlayerManager.Instance.Self.ConsortiaID)
            {
               if(data.Rank != -1)
               {
                  _totalRank.text = data.Rank.toString();
               }
               else
               {
                  _totalRank.text = LanguageMgr.GetTranslation("ddt.consortia.norank");
               }
               _totalScroeTxt.text = data.Score.toString();
            }
         }
         else if(data.UserID == PlayerManager.Instance.Self.ID)
         {
            if(data.Rank != -1)
            {
               _totalRank.text = data.Rank.toString();
            }
            else
            {
               _totalRank.text = LanguageMgr.GetTranslation("ddt.consortia.norank");
            }
            _totalScroeTxt.text = data.Score.toString();
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
      
      private function personerRankListHander(e:ConsortionEvent) : void
      {
         _type = 10;
         var arr:Array = e.data as Array;
         _rankList = setCurrtArr(arr);
         setPageTxt(arr);
         setPageArr();
      }
      
      private function setCurrtArr(arr:Array) : Array
      {
         var i:int = 0;
         for(i = 0; i < arr.length; )
         {
            if(arr[i].UserID == PlayerManager.Instance.Self.ID)
            {
               arr.splice(i,1);
               return arr;
            }
            i++;
         }
         return arr;
      }
      
      private function clubRankListHander(e:ConsortionEvent) : void
      {
         _type = 8;
         var arr:Array = e.data as Array;
         _rankList = arr;
         setPageTxt(arr);
         setPageArr();
      }
      
      protected function setPageTxt(arr:Array) : void
      {
         if(!arr)
         {
            return;
         }
         var num:int = Math.ceil(arr.length / 10);
         if(num == 0)
         {
            num = 1;
         }
         TOTALPAGE = num;
         _pageNum.text = _index + "/" + TOTALPAGE;
      }
      
      private function mouseClickHander(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(!_rankList)
         {
            return;
         }
         var _loc2_:* = e.currentTarget;
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
         var i:int = 0;
         var j:int = 0;
         if(!_rankList)
         {
            return;
         }
         var len:int = _rankList.length;
         var arr:Array = [];
         if(_type == 8)
         {
            for(i = (_index - 1) * 8; i < _index * 8; )
            {
               if(_rankList[i])
               {
                  arr.push(_rankList[i]);
               }
               i++;
            }
         }
         else if(_type == 10)
         {
            for(j = (_index - 1) * 10; j < _index * 10; )
            {
               if(_rankList[j])
               {
                  arr.push(_rankList[j]);
               }
               j++;
            }
         }
         initItemList(arr);
      }
      
      private function responseHander(e:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      private function group1changeHandler(e:Event) : void
      {
         SoundManager.instance.playButtonSound();
         var type:int = _group1.selectIndex;
         _index = 1;
         switch(int(type))
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
