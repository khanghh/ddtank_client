package flowerGiving.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flowerGiving.FlowerGivingController;
   import flowerGiving.components.FlowerSendRewardItem;
   import road7th.comm.PackageIn;
   
   public class FlowerSendRewardView extends Sprite implements Disposeable
   {
       
      
      private var _back:Bitmap;
      
      private var _titleTxt1:FilterFrameText;
      
      private var _titleTxt2:FilterFrameText;
      
      private var _titleTxt3:FilterFrameText;
      
      private var _myFlowerTitleTxt:FilterFrameText;
      
      private var _myFlowerNumTxt:FilterFrameText;
      
      private var _vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _listItem:Vector.<FlowerSendRewardItem>;
      
      private var dataArr:Array;
      
      public function FlowerSendRewardView()
      {
         super();
         initData();
         initView();
         addEvents();
      }
      
      private function initData() : void
      {
         _listItem = new Vector.<FlowerSendRewardItem>();
         dataArr = FlowerGivingController.instance.getDataByRewardMark(6);
         SocketManager.Instance.out.getFlowerRewardStatus();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var item:* = null;
         _back = ComponentFactory.Instance.creat("flowerGiving.accumuGivingBack");
         addChild(_back);
         _titleTxt1 = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.titleTxt");
         addChild(_titleTxt1);
         PositionUtils.setPos(_titleTxt1,"flowerGiving.sendView.title1Pos");
         _titleTxt1.text = LanguageMgr.GetTranslation("flowerGiving.sendView.title1Txt");
         _titleTxt2 = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.titleTxt");
         addChild(_titleTxt2);
         PositionUtils.setPos(_titleTxt2,"flowerGiving.sendView.title2Pos");
         _titleTxt2.text = LanguageMgr.GetTranslation("flowerGiving.sendView.title2Txt");
         _titleTxt3 = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.titleTxt");
         addChild(_titleTxt3);
         PositionUtils.setPos(_titleTxt3,"flowerGiving.sendView.title3Pos");
         _titleTxt3.text = LanguageMgr.GetTranslation("flowerGiving.sendView.title3Txt");
         _myFlowerTitleTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.myFlowerTitleTxt");
         addChild(_myFlowerTitleTxt);
         PositionUtils.setPos(_myFlowerTitleTxt,"flowerGiving.sendView.myFlowerTitlePos");
         _myFlowerTitleTxt.text = LanguageMgr.GetTranslation("flowerGiving.rankView.myFlowerTitle");
         _myFlowerNumTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.myFlowerNumTxt");
         addChild(_myFlowerNumTxt);
         PositionUtils.setPos(_myFlowerNumTxt,"flowerGiving.sendView.myFlowerNumPos");
         _myFlowerNumTxt.text = "999";
         _vbox = ComponentFactory.Instance.creatComponentByStylename("flowerSendView.vBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("flowerSendView.scrollpanel");
         _scrollPanel.setView(_vbox);
         addChild(_scrollPanel);
         for(i = 0; i <= dataArr.length - 1; )
         {
            item = new FlowerSendRewardItem(i);
            item.info = dataArr[i];
            _listItem.push(item);
            _vbox.addChild(item);
            i++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function addEvents() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(257,6),__updateRewardStatus);
         SocketManager.Instance.addEventListener(PkgEvent.format(257,5),__getRewardSuccess);
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
         var i:int = 0;
         var pkg:PackageIn = event.pkg;
         var yesBtnStatus:Boolean = pkg.readBoolean();
         var accBtnStatus:Boolean = pkg.readBoolean();
         var giveFlowerStatus:int = pkg.readInt();
         var myGivingFlower:int = pkg.readInt();
         for(i = 0; i <= _listItem.length - 1; )
         {
            if(myGivingFlower >= (_listItem[i] as FlowerSendRewardItem).num)
            {
               (_listItem[i] as FlowerSendRewardItem).setBtnEnable(1);
               if((giveFlowerStatus & 1 << i) != 0)
               {
                  (_listItem[i] as FlowerSendRewardItem).setBtnEnable(2);
               }
            }
            else
            {
               (_listItem[i] as FlowerSendRewardItem).setBtnEnable(0);
            }
            i++;
         }
         _myFlowerNumTxt.text = myGivingFlower.toString();
      }
      
      private function updateView() : void
      {
         var i:int = 0;
         var item:* = null;
         for(i = 0; i <= dataArr.length - 1; )
         {
            item = new FlowerSendRewardItem(i);
            _listItem.push(item);
            _vbox.addChild(item);
            i++;
         }
      }
      
      private function removeEvents() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(257,6),__updateRewardStatus);
         SocketManager.Instance.removeEventListener(PkgEvent.format(257,5),__getRewardSuccess);
      }
      
      public function dispose() : void
      {
         removeEvents();
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         if(_titleTxt1)
         {
            ObjectUtils.disposeObject(_titleTxt1);
         }
         _titleTxt1 = null;
         if(_titleTxt2)
         {
            ObjectUtils.disposeObject(_titleTxt2);
         }
         _titleTxt2 = null;
         if(_titleTxt3)
         {
            ObjectUtils.disposeObject(_titleTxt3);
         }
         _titleTxt3 = null;
         if(_myFlowerTitleTxt)
         {
            ObjectUtils.disposeObject(_myFlowerTitleTxt);
         }
         _myFlowerTitleTxt = null;
         if(_myFlowerNumTxt)
         {
            ObjectUtils.disposeObject(_myFlowerNumTxt);
         }
         _myFlowerNumTxt = null;
         var _loc3_:int = 0;
         var _loc2_:* = _listItem;
         for each(var item in _listItem)
         {
            ObjectUtils.disposeObject(item);
            item = null;
         }
         _listItem = null;
         if(_vbox)
         {
            ObjectUtils.disposeObject(_vbox);
         }
         _vbox = null;
         if(_scrollPanel)
         {
            ObjectUtils.disposeObject(_scrollPanel);
         }
         _scrollPanel = null;
         if(parent)
         {
            ObjectUtils.disposeObject(this);
         }
      }
   }
}
