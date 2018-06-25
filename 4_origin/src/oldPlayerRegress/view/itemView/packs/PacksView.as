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
      
      private function __getPacksInfo(event:PkgEvent) : void
      {
         var i:int = 0;
         var isRecv:int = 0;
         var len:int = 0;
         var j:int = 0;
         var curID:int = 0;
         var propsNum:int = 0;
         var giftDataVector:* = undefined;
         var k:int = 0;
         var giftData:* = null;
         var l:int = 0;
         SocketManager.Instance.removeEventListener(PkgEvent.format(149,0),__getPacksInfo);
         removeVariable();
         var pkg:PackageIn = event.pkg;
         _dayNum = pkg.readInt();
         var length:int = pkg.readInt();
         length = 6;
         _pageID = int((_dayNum - 1) / length);
         _numID = (_dayNum - 1) % length;
         _init();
         for(i = 0; i < 15; )
         {
            isRecv = pkg.readByte();
            if(i < _pageID * 6)
            {
               len = pkg.readInt();
               for(j = 0; j < len; )
               {
                  pkg.readInt();
                  pkg.readInt();
                  j++;
               }
            }
            else
            {
               if(isRecv != 0)
               {
                  curID = i % 6;
                  _recvArray[curID].visible = true;
                  _btnArray[curID].removeEventListener("click",__onBtnClick);
                  (_btnArray[curID] as BaseButton).mouseEnabled = false;
               }
               propsNum = pkg.readInt();
               giftDataVector = new Vector.<GiftData>();
               for(k = 0; k < propsNum; )
               {
                  giftData = new GiftData();
                  giftData.giftID = pkg.readInt();
                  giftData.giftCount = pkg.readInt();
                  giftDataVector.push(giftData);
                  k++;
               }
               _pakcsGiftData.push(giftDataVector);
            }
            i++;
         }
         _packsGiftView = new PacksGiftView();
         PositionUtils.setPos(_packsGiftView,"regress.pakcs.gift.pos");
         addToContent(_packsGiftView);
         for(l = 0; l <= _numID; )
         {
            if(_btnArray[l].mouseEnabled == true)
            {
               _packsSelect.visible = true;
               _packsSelect.x = _btnArray[l].x;
               _packsSelect.y = _btnArray[l].y;
               _clickID = _pageID * 6 + l;
               _getAwardBtn.enable = true;
               _packsGiftView.removeGiftChild();
               _packsGiftView.getGiftData = _pakcsGiftData[l];
               _packsGiftView.setGiftInfo();
               break;
            }
            if(l == _numID)
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
            l++;
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
         var i:int = 0;
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
         i = 0;
         while(i < _btnArray.length)
         {
            _btnArray[i] = ComponentFactory.Instance.creatComponentByStylename("regress.giftAward" + (String(i + 1)));
            addToContent(_btnArray[i]);
            _recvArray[i] = ComponentFactory.Instance.creatComponentByStylename("regress.packsReceived");
            _recvArray[i].x = _btnArray[i].x + 77;
            _recvArray[i].y = _btnArray[i].y - 4;
            addToContent(_recvArray[i]);
            i++;
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
         var i:int = 0;
         for(i = 0; i < _btnArray.length; )
         {
            _btnArray[i].addEventListener("click",__onBtnClick);
            i++;
         }
         _getAwardBtn.addEventListener("click",__onGetAwardClick);
      }
      
      protected function __onGetAwardClick(event:MouseEvent) : void
      {
         SocketManager.Instance.out.sendRegressGetAwardPkg(_clickID);
         SocketManager.Instance.addEventListener(PkgEvent.format(149,0),__getPacksInfo);
      }
      
      private function __onBtnClick(event:MouseEvent) : void
      {
         var i:int = 0;
         _packsSelect.visible = true;
         for(i = 0; i < _btnArray.length; )
         {
            if(_btnArray[i] == event.currentTarget)
            {
               SoundManager.instance.playButtonSound();
               _clickID = _pageID * 6 + i;
               _getAwardBtn.enable = true;
               if(_recvArray[i].visible || i > _numID)
               {
                  _getAwardBtn.enable = false;
               }
               _packsSelect.x = _btnArray[i].x;
               _packsSelect.y = _btnArray[i].y;
               _packsGiftView.removeGiftChild();
               _packsGiftView.getGiftData = _pakcsGiftData[i];
               _packsGiftView.setGiftInfo();
               break;
            }
            i++;
         }
      }
      
      public function show() : void
      {
         this.visible = true;
      }
      
      private function removeEvent() : void
      {
         var i:int = 0;
         if(_btnArray)
         {
            for(i = 0; i < _btnArray.length; )
            {
               _btnArray[i].removeEventListener("click",__onBtnClick);
               i++;
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
         var i:int = 0;
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
            for(i = 0; i < _pakcsGiftData.length; )
            {
               _pakcsGiftData[i] = null;
               i++;
            }
            _pakcsGiftData.length = 0;
         }
         removeArray(_btnArray);
         removeArray(_recvArray);
      }
      
      private function removeArray(array:Array) : void
      {
         var i:int = 0;
         if(array)
         {
            for(i = 0; i < array.length; )
            {
               if(array[i])
               {
                  array[i].dispose();
                  array[i] = null;
               }
               i++;
            }
            array.length = 0;
         }
      }
   }
}
