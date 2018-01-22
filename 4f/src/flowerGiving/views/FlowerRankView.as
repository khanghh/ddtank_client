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
      
      public function FlowerRankView(param1:int){super();}
      
      private function initData() : void{}
      
      private function initView() : void{}
      
      private function setRequestTxt() : void{}
      
      private function addEvents() : void{}
      
      protected function __prevBtnClick(param1:MouseEvent) : void{}
      
      protected function __nextBtnClick(param1:MouseEvent) : void{}
      
      protected function __getRewardBtnClick(param1:MouseEvent) : void{}
      
      private function __updateView(param1:PkgEvent) : void{}
      
      private function clearItems() : void{}
      
      protected function __getRewardSuccess(param1:PkgEvent) : void{}
      
      protected function __updateRewardStatus(param1:PkgEvent) : void{}
      
      private function canBtnClick() : Boolean{return false;}
      
      private function removeEvents() : void{}
      
      public function dispose() : void{}
   }
}
