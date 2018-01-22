package oldPlayerRegress.view.itemView.packs
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import road7th.comm.PackageIn;
   
   public class PacksView extends Frame
   {
       
      
      private var _titleBg:Bitmap;
      
      private var _packTitle:ScaleFrameImage;
      
      private var _titleBgII:Bitmap;
      
      private var _openPacks:ScaleFrameImage;
      
      private var _bottomBtnBg:ScaleBitmapImage;
      
      private var _getAwardBtn:BaseButton;
      
      private var _packsBg:ScaleBitmapImage;
      
      private var _packsSelect:ScaleFrameImage;
      
      private var _btnArray:Array;
      
      private var _recvArray:Array;
      
      private var _packsGiftView:PacksGiftView;
      
      private var _pakcsGiftData:Array;
      
      private var _clickID:int = 0;
      
      private var _dayNum:int = 0;
      
      private var _pageID:int = 0;
      
      private var _numID:int = 0;
      
      public function PacksView()
      {
         super();
         SocketManager.Instance.out.sendRegressPkg();
         SocketManager.Instance.addEventListener(PkgEvent.format(149,0),__getPacksInfo);
      }
      
      private function __getPacksInfo(param1:PkgEvent) : void
      {
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc12_:* = undefined;
         var _loc9_:int = 0;
         var _loc2_:* = null;
         var _loc5_:int = 0;
         SocketManager.Instance.removeEventListener(PkgEvent.format(149,0),__getPacksInfo);
         removeVariable();
         var _loc4_:PackageIn = param1.pkg;
         _dayNum = _loc4_.readInt();
         var _loc13_:int = _loc4_.readInt();
         _loc13_ = 6;
         _pageID = int((_dayNum - 1) / _loc13_);
         _numID = (_dayNum - 1) % _loc13_;
         _init();
         _loc10_ = 0;
         while(_loc10_ < 15)
         {
            _loc11_ = _loc4_.readByte();
            if(_loc10_ < _pageID * 6)
            {
               _loc6_ = _loc4_.readInt();
               _loc7_ = 0;
               while(_loc7_ < _loc6_)
               {
                  _loc4_.readInt();
                  _loc4_.readInt();
                  _loc7_++;
               }
            }
            else
            {
               if(_loc11_ != 0)
               {
                  _loc3_ = _loc10_ % 6;
                  _recvArray[_loc3_].visible = true;
                  _btnArray[_loc3_].removeEventListener("click",__onBtnClick);
                  (_btnArray[_loc3_] as BaseButton).mouseEnabled = false;
               }
               _loc8_ = _loc4_.readInt();
               _loc12_ = new Vector.<GiftData>();
               _loc9_ = 0;
               while(_loc9_ < _loc8_)
               {
                  _loc2_ = new GiftData();
                  _loc2_.giftID = _loc4_.readInt();
                  _loc2_.giftCount = _loc4_.readInt();
                  _loc12_.push(_loc2_);
                  _loc9_++;
               }
               _pakcsGiftData.push(_loc12_);
            }
            _loc10_++;
         }
         _packsGiftView = new PacksGiftView();
         PositionUtils.setPos(_packsGiftView,"regress.pakcs.gift.pos");
         addToContent(_packsGiftView);
         _loc5_ = 0;
         while(_loc5_ <= _numID)
         {
            if(_btnArray[_loc5_].mouseEnabled == true)
            {
               _packsSelect.visible = true;
               _packsSelect.x = _btnArray[_loc5_].x;
               _packsSelect.y = _btnArray[_loc5_].y;
               _clickID = _pageID * 6 + _loc5_;
               _getAwardBtn.enable = true;
               _packsGiftView.removeGiftChild();
               _packsGiftView.getGiftData = _pakcsGiftData[_loc5_];
               _packsGiftView.setGiftInfo();
               break;
            }
            if(_loc5_ == _numID)
            {
               _getAwardBtn.enable = false;
               _packsGiftView.removeGiftChild();
               if(_numID + 1 < _btnArray.length)
               {
                  _clickID = _numID + 1;
                  _packsSelect.visible = true;
                  _packsSelect.x = _btnArray[_clickID].x;
                  _packsSelect.y = _btnArray[_clickID].y;
                  _packsGiftView.getGiftData = _pakcsGiftData[_clickID];
                  _packsGiftView.setGiftInfo();
               }
            }
            _loc5_++;
         }
      }
      
      private function _init() : void
      {
         initData();
         initView();
         initEvent();
      }
      
      private function initData() : void
      {
         _pakcsGiftData = [];
         _btnArray = new Array(new BaseButton(),new BaseButton(),new BaseButton(),new BaseButton(),new BaseButton(),new BaseButton());
         _recvArray = new Array(new ScaleFrameImage(),new ScaleFrameImage(),new ScaleFrameImage(),new ScaleFrameImage(),new ScaleFrameImage(),new ScaleFrameImage());
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _titleBg = ComponentFactory.Instance.creat("asset.regress.titleBg");
         _packTitle = ComponentFactory.Instance.creatComponentByStylename("regress.packTitle");
         _titleBgII = ComponentFactory.Instance.creat("asset.regress.titleBg");
         PositionUtils.setPos(_titleBgII,"regress.packs.titleII.pos");
         _openPacks = ComponentFactory.Instance.creatComponentByStylename("regress.openPacks");
         _bottomBtnBg = ComponentFactory.Instance.creatComponentByStylename("regress.bottomBgImg");
         _packsBg = ComponentFactory.Instance.creatComponentByStylename("regress.packsBg");
         _getAwardBtn = ComponentFactory.Instance.creat("regress.getAward");
         _getAwardBtn.enable = false;
         if(_dayNum > 12)
         {
            _btnArray.length = 3;
         }
         _loc1_ = 0;
         while(_loc1_ < _btnArray.length)
         {
            _btnArray[_loc1_] = ComponentFactory.Instance.creatComponentByStylename("regress.giftAward" + (String(_loc1_ + 1)));
            addToContent(_btnArray[_loc1_]);
            _recvArray[_loc1_] = ComponentFactory.Instance.creatComponentByStylename("regress.packsReceived");
            _recvArray[_loc1_].x = _btnArray[_loc1_].x + 77;
            _recvArray[_loc1_].y = _btnArray[_loc1_].y - 4;
            addToContent(_recvArray[_loc1_]);
            _loc1_++;
         }
         _packsSelect = ComponentFactory.Instance.creatComponentByStylename("regress.packsSelected");
         addToContent(_titleBg);
         addToContent(_packTitle);
         addToContent(_titleBgII);
         addToContent(_openPacks);
         addToContent(_bottomBtnBg);
         addToContent(_packsBg);
         addToContent(_getAwardBtn);
         addToContent(_packsSelect);
      }
      
      private function initEvent() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _btnArray.length)
         {
            _btnArray[_loc1_].addEventListener("click",__onBtnClick);
            _loc1_++;
         }
         _getAwardBtn.addEventListener("click",__onGetAwardClick);
      }
      
      protected function __onGetAwardClick(param1:MouseEvent) : void
      {
         SocketManager.Instance.out.sendRegressGetAwardPkg(_clickID);
         SocketManager.Instance.addEventListener(PkgEvent.format(149,0),__getPacksInfo);
      }
      
      private function __onBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _packsSelect.visible = true;
         _loc2_ = 0;
         while(_loc2_ < _btnArray.length)
         {
            if(_btnArray[_loc2_] == param1.currentTarget)
            {
               SoundManager.instance.playButtonSound();
               _clickID = _pageID * 6 + _loc2_;
               _getAwardBtn.enable = true;
               if(_recvArray[_loc2_].visible || _loc2_ > _numID)
               {
                  _getAwardBtn.enable = false;
               }
               _packsSelect.x = _btnArray[_loc2_].x;
               _packsSelect.y = _btnArray[_loc2_].y;
               _packsGiftView.removeGiftChild();
               _packsGiftView.getGiftData = _pakcsGiftData[_loc2_];
               _packsGiftView.setGiftInfo();
               break;
            }
            _loc2_++;
         }
      }
      
      public function show() : void
      {
         this.visible = true;
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         if(_btnArray)
         {
            _loc1_ = 0;
            while(_loc1_ < _btnArray.length)
            {
               _btnArray[_loc1_].removeEventListener("click",__onBtnClick);
               _loc1_++;
            }
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         removeVariable();
      }
      
      private function removeVariable() : void
      {
         var _loc1_:int = 0;
         _clickID = 0;
         _dayNum = 0;
         if(_titleBg)
         {
            _titleBg = null;
         }
         if(_packTitle)
         {
            _packTitle.dispose();
            _packTitle = null;
         }
         if(_titleBgII)
         {
            _titleBgII = null;
         }
         if(_openPacks)
         {
            _openPacks.dispose();
            _openPacks = null;
         }
         if(_bottomBtnBg)
         {
            _bottomBtnBg.dispose();
            _bottomBtnBg = null;
         }
         if(_getAwardBtn)
         {
            _getAwardBtn.dispose();
            _getAwardBtn = null;
         }
         if(_packsBg)
         {
            _packsBg.dispose();
            _packsBg = null;
         }
         if(_packsSelect)
         {
            _packsSelect.dispose();
            _packsSelect = null;
         }
         if(_packsGiftView)
         {
            _packsGiftView.dispose();
            _packsGiftView = null;
         }
         if(_pakcsGiftData)
         {
            _loc1_ = 0;
            while(_loc1_ < _pakcsGiftData.length)
            {
               _pakcsGiftData[_loc1_] = null;
               _loc1_++;
            }
            _pakcsGiftData.length = 0;
         }
         removeArray(_btnArray);
         removeArray(_recvArray);
      }
      
      private function removeArray(param1:Array) : void
      {
         var _loc2_:int = 0;
         if(param1)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               if(param1[_loc2_])
               {
                  param1[_loc2_].dispose();
                  param1[_loc2_] = null;
               }
               _loc2_++;
            }
            param1.length = 0;
         }
      }
   }
}
