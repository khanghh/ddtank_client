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
      
      public function FlowerRankView(param1:int)
      {
         super();
         this.type = param1;
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
         var _loc1_:String = FlowerGivingManager.instance.xmlData.remain2;
         var _loc2_:Array = _loc1_.split(",");
         switch(int(type))
         {
            case 0:
            case 1:
               _baseRequestTxt.text = LanguageMgr.GetTranslation("flowerGiving.rankView.baseRequest",_loc2_[0]);
               _superRequestTxt.text = LanguageMgr.GetTranslation("flowerGiving.rankView.superRequest",_loc2_[1]);
               break;
            case 2:
               _baseRequestTxt.text = LanguageMgr.GetTranslation("flowerGiving.rankView.baseRequest",_loc2_[2]);
               _superRequestTxt.text = LanguageMgr.GetTranslation("flowerGiving.rankView.superRequest",_loc2_[3]);
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
      
      protected function __prevBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(curPage <= 0)
         {
            return;
         }
         SocketManager.Instance.out.getFlowerRankInfo(type,curPage - 1);
      }
      
      protected function __nextBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(curPage >= pageCount - 1)
         {
            return;
         }
         SocketManager.Instance.out.getFlowerRankInfo(type,curPage + 1);
      }
      
      protected function __getRewardBtnClick(param1:MouseEvent) : void
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
      
      private function __updateView(param1:PkgEvent) : void
      {
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc5_:int = 0;
         var _loc10_:* = null;
         var _loc6_:int = 0;
         clearItems();
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:int = _loc3_.readInt();
         if(type == _loc4_)
         {
            myFlowerCount = _loc3_.readInt();
            myPlace = _loc3_.readInt();
            pageCount = _loc3_.readInt();
            curPage = _loc3_.readInt();
            _loc2_ = _loc3_.readInt();
            _loc2_ = _loc2_ < 8?_loc2_:8;
            _loc7_ = 0;
            while(_loc7_ <= _loc2_ - 1)
            {
               _loc8_ = new FlowerRankInfo();
               _loc8_.place = _loc3_.readInt();
               _loc8_.num = _loc3_.readInt();
               _loc8_.name = _loc3_.readUTF();
               _loc8_.vipLvl = _loc3_.readByte();
               _loc5_ = 0;
               while(_loc5_ <= dataArr.length - 1)
               {
                  _loc11_ = (dataArr[_loc5_] as GiftBagInfo).giftConditionArr[0].conditionValue;
                  _loc12_ = (dataArr[_loc5_] as GiftBagInfo).giftConditionArr[1].conditionValue;
                  if(_loc8_.place >= _loc11_ && _loc8_.place <= _loc12_)
                  {
                     _loc8_.rewardVec = (dataArr[_loc5_] as GiftBagInfo).giftRewardArr;
                     break;
                  }
                  _loc5_++;
               }
               if(_loc8_.rewardVec)
               {
                  _loc10_ = new FlowerRankItem();
                  _loc10_.info = _loc8_;
                  _vbox.addChild(_loc10_);
                  _itemList.push(_loc10_);
               }
               _loc7_++;
            }
         }
         _loc6_ = 0;
         while(_loc6_ <= dataArr.length - 1)
         {
            _loc12_ = (dataArr[_loc6_] as GiftBagInfo).giftConditionArr[1].conditionValue;
            _loc13_ = _loc13_ > _loc12_?_loc13_:int(_loc12_);
            _loc6_++;
         }
         var _loc9_:int = _loc13_ % 8 == 0?_loc13_ / 8:Number(_loc13_ / 8 + 1);
         pageCount = pageCount > _loc9_?_loc9_:int(pageCount);
         pageCount = pageCount == 0?1:pageCount;
         _myFlowerNum.text = myFlowerCount + "";
         if(myPlace <= 0 || myPlace > _loc13_)
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
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ <= _itemList.length - 1)
         {
            ObjectUtils.disposeObject(_itemList[_loc1_]);
            _itemList[_loc1_] = null;
            _loc1_++;
         }
      }
      
      protected function __getRewardSuccess(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:Boolean = _loc2_.readBoolean();
         if(_loc3_)
         {
            SocketManager.Instance.out.getFlowerRewardStatus();
         }
      }
      
      protected function __updateRewardStatus(param1:PkgEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         ysdRwardGet = _loc4_.readBoolean();
         accRwardGet = _loc4_.readBoolean();
         var _loc2_:int = _loc4_.readInt();
         var _loc3_:int = _loc4_.readInt();
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
         var _loc1_:int = 0;
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
         _loc1_ = 0;
         while(_loc1_ <= _itemList.length - 1)
         {
            ObjectUtils.disposeObject(_itemList[_loc1_]);
            _itemList[_loc1_] = null;
            _loc1_++;
         }
      }
   }
}
