package flowerGiving.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flowerGiving.FlowerGivingController;
   import flowerGiving.FlowerGivingManager;
   import flowerGiving.components.FlowerRankItem;
   import flowerGiving.data.FlowerRankInfo;
   import road7th.comm.PackageIn;
   import wonderfulActivity.data.GiftBagInfo;
   
   public class FlowerRankView extends Sprite implements Disposeable
   {
      
      public static const LIST_LEN:int = 8;
       
      
      private var _bg:Bitmap;
      
      private var _bottomBg:Bitmap;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _numTxt:FilterFrameText;
      
      private var _basePrizeTxt:FilterFrameText;
      
      private var _superPrizeTxt:FilterFrameText;
      
      private var _pageBg:Scale9CornerImage;
      
      private var _pageTxt:FilterFrameText;
      
      private var _prevBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _myFlowerLabel:FilterFrameText;
      
      private var _myFlowerNum:FilterFrameText;
      
      private var _myPlace:FilterFrameText;
      
      private var _outOfRank:FilterFrameText;
      
      private var _baseRequestTxt:FilterFrameText;
      
      private var _superRequestTxt:FilterFrameText;
      
      private var _getRewardBtn:SimpleBitmapButton;
      
      private var _vbox:VBox;
      
      private var _itemList:Vector.<FlowerRankItem>;
      
      private var type:int;
      
      private var myFlowerCount:int;
      
      private var myPlace:int;
      
      private var pageCount:int;
      
      private var curPage:int;
      
      private var dataArr:Array;
      
      private var ysdRwardGet:Boolean = false;
      
      private var accRwardGet:Boolean = false;
      
      public function FlowerRankView(type:int)
      {
         super();
         this.type = type;
         initData();
         initView();
         addEvents();
      }
      
      private function initData() : void
      {
         _itemList = new Vector.<FlowerRankItem>();
         switch(int(type))
         {
            case 0:
            case 1:
               dataArr = FlowerGivingController.instance.getDataByRewardMark(1);
               break;
            case 2:
               dataArr = FlowerGivingController.instance.getDataByRewardMark(3);
         }
         SocketManager.Instance.out.getFlowerRankInfo(type,0);
         SocketManager.Instance.out.getFlowerRewardStatus();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("flowerGiving.rankBG");
         addChild(_bg);
         _bottomBg = ComponentFactory.Instance.creat("flowerGiving.bottomBG2");
         addChild(_bottomBg);
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.titleTxt");
         PositionUtils.setPos(_rankTxt,"flowerGiving.rankView.rankTxtPos");
         _rankTxt.text = LanguageMgr.GetTranslation("flowerGiving.rankView.rankTxt");
         addChild(_rankTxt);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.titleTxt");
         PositionUtils.setPos(_nameTxt,"flowerGiving.rankView.nameTxtPos");
         _nameTxt.text = LanguageMgr.GetTranslation("flowerGiving.rankView.nameTxt");
         addChild(_nameTxt);
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.titleTxt");
         PositionUtils.setPos(_numTxt,"flowerGiving.rankView.numTxtPos");
         _numTxt.text = LanguageMgr.GetTranslation("flowerGiving.rankView.numTxt");
         addChild(_numTxt);
         _basePrizeTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.titleTxt");
         PositionUtils.setPos(_basePrizeTxt,"flowerGiving.rankView.basePrizePos");
         _basePrizeTxt.text = LanguageMgr.GetTranslation("flowerGiving.rankView.basePrizeTxt");
         addChild(_basePrizeTxt);
         _superPrizeTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.titleTxt");
         PositionUtils.setPos(_superPrizeTxt,"flowerGiving.rankView.superPrizePos");
         _superPrizeTxt.text = LanguageMgr.GetTranslation("flowerGiving.rankView.superPrizeTxt");
         addChild(_superPrizeTxt);
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.PageCountBg");
         addChild(_pageBg);
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.pageTxt");
         addChild(_pageTxt);
         _prevBtn = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.prevBtn");
         addChild(_prevBtn);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.nextBtn");
         addChild(_nextBtn);
         _myFlowerLabel = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.myFlowerTitleTxt");
         PositionUtils.setPos(_myFlowerLabel,"flowerGiving.rankView.myFlowerLabelPos");
         _myFlowerLabel.text = type == 2?LanguageMgr.GetTranslation("flowerGiving.sendView.myFlowerTitle"):LanguageMgr.GetTranslation("flowerGiving.rankView.myFlowerTitle");
         addChild(_myFlowerLabel);
         _myFlowerNum = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.myFlowerNumTxt");
         PositionUtils.setPos(_myFlowerNum,"flowerGiving.rankView.myFlowerNumPos");
         addChild(_myFlowerNum);
         _myPlace = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.greenTxt");
         PositionUtils.setPos(_myPlace,"flowerGiving.rankVeiw.greenTxtPos");
         _myPlace.text = LanguageMgr.GetTranslation("flowerGiving.rankView.myPlaceTxt");
         addChild(_myPlace);
         _myPlace.visible = false;
         _outOfRank = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.outOfRankTxt");
         PositionUtils.setPos(_outOfRank,"flowerGiving.rankVeiw.greenTxtPos");
         _outOfRank.text = LanguageMgr.GetTranslation("flowerGiving.rankView.outOfRank");
         addChild(_outOfRank);
         _outOfRank.visible = false;
         switch(int(type))
         {
            case 0:
               _baseRequestTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.lightBrownTxt");
               PositionUtils.setPos(_baseRequestTxt,"flowerGiving.rankVeiw.baseRequestPos");
               _baseRequestTxt.text = LanguageMgr.GetTranslation("flowerGiving.rankView.baseRequest");
               addChild(_baseRequestTxt);
               _superRequestTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.lightBrownTxt");
               PositionUtils.setPos(_superRequestTxt,"flowerGiving.rankVeiw.superRequestPos");
               _superRequestTxt.text = LanguageMgr.GetTranslation("flowerGiving.rankView.superRequest");
               addChild(_superRequestTxt);
               break;
            case 1:
            case 2:
               _baseRequestTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.lightBrownTxt");
               PositionUtils.setPos(_baseRequestTxt,"flowerGiving.rankVeiw.baseRequestPos");
               _baseRequestTxt.text = LanguageMgr.GetTranslation("flowerGiving.rankView.baseRequest");
               addChild(_baseRequestTxt);
               _superRequestTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.lightBrownTxt");
               PositionUtils.setPos(_superRequestTxt,"flowerGiving.rankVeiw.superRequestPos");
               _superRequestTxt.text = LanguageMgr.GetTranslation("flowerGiving.rankView.superRequest");
               addChild(_superRequestTxt);
               _getRewardBtn = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.rankView.getRewardBtn");
               PositionUtils.setPos(_getRewardBtn,"flowerGiving.rankView.btnPos2");
               addChild(_getRewardBtn);
         }
         _vbox = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.vBox");
         addChild(_vbox);
         setRequestTxt();
      }
      
      private function setRequestTxt() : void
      {
         var str:String = FlowerGivingManager.instance.xmlData.remain2;
         var arr:Array = str.split(",");
         switch(int(type))
         {
            case 0:
            case 1:
               _baseRequestTxt.text = LanguageMgr.GetTranslation("flowerGiving.rankView.baseRequest",arr[0]);
               _superRequestTxt.text = LanguageMgr.GetTranslation("flowerGiving.rankView.superRequest",arr[1]);
               break;
            case 2:
               _baseRequestTxt.text = LanguageMgr.GetTranslation("flowerGiving.rankView.baseRequest",arr[2]);
               _superRequestTxt.text = LanguageMgr.GetTranslation("flowerGiving.rankView.superRequest",arr[3]);
         }
      }
      
      private function addEvents() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(257,4),__updateView);
         SocketManager.Instance.addEventListener(PkgEvent.format(257,5),__getRewardSuccess);
         SocketManager.Instance.addEventListener(PkgEvent.format(257,6),__updateRewardStatus);
         if(_getRewardBtn)
         {
            _getRewardBtn.addEventListener("click",__getRewardBtnClick);
         }
         _prevBtn.addEventListener("click",__prevBtnClick);
         _nextBtn.addEventListener("click",__nextBtnClick);
      }
      
      protected function __prevBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(curPage <= 0)
         {
            return;
         }
         SocketManager.Instance.out.getFlowerRankInfo(type,curPage - 1);
      }
      
      protected function __nextBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(curPage >= pageCount - 1)
         {
            return;
         }
         SocketManager.Instance.out.getFlowerRankInfo(type,curPage + 1);
      }
      
      protected function __getRewardBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(type) - 1)
         {
            case 0:
               SocketManager.Instance.out.sendGetFlowerReward(0);
               break;
            case 1:
               SocketManager.Instance.out.sendGetFlowerReward(1);
         }
      }
      
      private function __updateView(event:PkgEvent) : void
      {
         var count:int = 0;
         var i:int = 0;
         var info:* = null;
         var baseValue:int = 0;
         var superValue:int = 0;
         var maxValue:int = 0;
         var j:int = 0;
         var item:* = null;
         var k:int = 0;
         clearItems();
         var pkg:PackageIn = event.pkg;
         var viewType:int = pkg.readInt();
         if(type == viewType)
         {
            myFlowerCount = pkg.readInt();
            myPlace = pkg.readInt();
            pageCount = pkg.readInt();
            curPage = pkg.readInt();
            count = pkg.readInt();
            count = count < 8?count:8;
            for(i = 0; i <= count - 1; )
            {
               info = new FlowerRankInfo();
               info.place = pkg.readInt();
               info.num = pkg.readInt();
               info.name = pkg.readUTF();
               info.vipLvl = pkg.readByte();
               for(j = 0; j <= dataArr.length - 1; )
               {
                  baseValue = (dataArr[j] as GiftBagInfo).giftConditionArr[0].conditionValue;
                  superValue = (dataArr[j] as GiftBagInfo).giftConditionArr[1].conditionValue;
                  if(info.place >= baseValue && info.place <= superValue)
                  {
                     info.rewardVec = (dataArr[j] as GiftBagInfo).giftRewardArr;
                     break;
                  }
                  j++;
               }
               if(info.rewardVec)
               {
                  item = new FlowerRankItem();
                  item.info = info;
                  _vbox.addChild(item);
                  _itemList.push(item);
               }
               i++;
            }
         }
         k = 0;
         while(k <= dataArr.length - 1)
         {
            superValue = (dataArr[k] as GiftBagInfo).giftConditionArr[1].conditionValue;
            maxValue = maxValue > superValue?maxValue:int(superValue);
            k++;
         }
         var maxPage:int = maxValue % 8 == 0?maxValue / 8:Number(maxValue / 8 + 1);
         pageCount = pageCount > maxPage?maxPage:int(pageCount);
         pageCount = pageCount == 0?1:pageCount;
         _myFlowerNum.text = myFlowerCount + "";
         if(myPlace <= 0 || myPlace > maxValue)
         {
            _myPlace.visible = false;
            _outOfRank.visible = true;
         }
         else
         {
            _myPlace.visible = true;
            _outOfRank.visible = false;
            _myPlace.text = LanguageMgr.GetTranslation("flowerGiving.rankView.myPlaceTxt",myPlace);
         }
         _pageTxt.text = curPage + 1 + "/" + pageCount;
         if(_getRewardBtn)
         {
            _getRewardBtn.enable = canBtnClick();
         }
      }
      
      private function clearItems() : void
      {
         var i:int = 0;
         for(i = 0; i <= _itemList.length - 1; )
         {
            ObjectUtils.disposeObject(_itemList[i]);
            _itemList[i] = null;
            i++;
         }
      }
      
      protected function __getRewardSuccess(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var isSuccess:Boolean = pkg.readBoolean();
         if(isSuccess)
         {
            SocketManager.Instance.out.getFlowerRewardStatus();
         }
      }
      
      protected function __updateRewardStatus(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         ysdRwardGet = pkg.readBoolean();
         accRwardGet = pkg.readBoolean();
         var giveFlowerStatus:int = pkg.readInt();
         var myGivingFlower:int = pkg.readInt();
         if(_getRewardBtn)
         {
            _getRewardBtn.enable = canBtnClick();
         }
      }
      
      private function canBtnClick() : Boolean
      {
         switch(int(type) - 1)
         {
            case 0:
               return !ysdRwardGet;
            case 1:
               return !accRwardGet;
         }
      }
      
      private function removeEvents() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(257,4),__updateView);
         SocketManager.Instance.removeEventListener(PkgEvent.format(257,5),__getRewardSuccess);
         SocketManager.Instance.removeEventListener(PkgEvent.format(257,6),__updateRewardStatus);
         if(_getRewardBtn)
         {
            _getRewardBtn.removeEventListener("click",__getRewardBtnClick);
         }
         _prevBtn.removeEventListener("click",__prevBtnClick);
         _nextBtn.removeEventListener("click",__nextBtnClick);
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEvents();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bottomBg);
         _bottomBg = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_basePrizeTxt);
         _basePrizeTxt = null;
         ObjectUtils.disposeObject(_superPrizeTxt);
         _superPrizeTxt = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         ObjectUtils.disposeObject(_prevBtn);
         _prevBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_myFlowerLabel);
         _myFlowerLabel = null;
         ObjectUtils.disposeObject(_myFlowerNum);
         _myFlowerNum = null;
         ObjectUtils.disposeObject(_myPlace);
         _myPlace = null;
         ObjectUtils.disposeObject(_baseRequestTxt);
         _baseRequestTxt = null;
         ObjectUtils.disposeObject(_superRequestTxt);
         _superRequestTxt = null;
         ObjectUtils.disposeObject(_getRewardBtn);
         _getRewardBtn = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         for(i = 0; i <= _itemList.length - 1; )
         {
            ObjectUtils.disposeObject(_itemList[i]);
            _itemList[i] = null;
            i++;
         }
      }
   }
}
