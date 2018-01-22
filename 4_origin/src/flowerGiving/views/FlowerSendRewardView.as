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
         var _loc2_:int = 0;
         var _loc1_:* = null;
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
         _loc2_ = 0;
         while(_loc2_ <= dataArr.length - 1)
         {
            _loc1_ = new FlowerSendRewardItem(_loc2_);
            _loc1_.info = dataArr[_loc2_];
            _listItem.push(_loc1_);
            _vbox.addChild(_loc1_);
            _loc2_++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function addEvents() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(257,6),__updateRewardStatus);
         SocketManager.Instance.addEventListener(PkgEvent.format(257,5),__getRewardSuccess);
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
         var _loc7_:int = 0;
         var _loc6_:PackageIn = param1.pkg;
         var _loc4_:Boolean = _loc6_.readBoolean();
         var _loc2_:Boolean = _loc6_.readBoolean();
         var _loc3_:int = _loc6_.readInt();
         var _loc5_:int = _loc6_.readInt();
         _loc7_ = 0;
         while(_loc7_ <= _listItem.length - 1)
         {
            if(_loc5_ >= (_listItem[_loc7_] as FlowerSendRewardItem).num)
            {
               (_listItem[_loc7_] as FlowerSendRewardItem).setBtnEnable(1);
               if((_loc3_ & 1 << _loc7_) != 0)
               {
                  (_listItem[_loc7_] as FlowerSendRewardItem).setBtnEnable(2);
               }
            }
            else
            {
               (_listItem[_loc7_] as FlowerSendRewardItem).setBtnEnable(0);
            }
            _loc7_++;
         }
         _myFlowerNumTxt.text = _loc5_.toString();
      }
      
      private function updateView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ <= dataArr.length - 1)
         {
            _loc1_ = new FlowerSendRewardItem(_loc2_);
            _listItem.push(_loc1_);
            _vbox.addChild(_loc1_);
            _loc2_++;
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
         for each(var _loc1_ in _listItem)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
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
