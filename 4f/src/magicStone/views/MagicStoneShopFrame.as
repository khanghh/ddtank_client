package magicStone.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import magicStone.MagicStoneControl;
   import magicStone.components.MagicStoneShopItem;
   import road7th.comm.PackageIn;
   
   public class MagicStoneShopFrame extends BaseAlerFrame
   {
      
      public static const SHOP_ITEM_NUM:uint = 8;
       
      
      private var _goodItems:Vector.<MagicStoneShopItem>;
      
      private var _rightItemLightMc:MovieClip;
      
      private var _goodItemContainerAll:Sprite;
      
      private var _goodItemContainerBg:Image;
      
      private var _navigationBarContainer:Sprite;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _currentPageTxt:FilterFrameText;
      
      private var _currentPageInput:Scale9CornerImage;
      
      private var _scoreNumBG:Scale9CornerImage;
      
      private var _scoreText:FilterFrameText;
      
      private var _scoreNumText:FilterFrameText;
      
      private var _label:FilterFrameText;
      
      private var curPage:int = 1;
      
      public function MagicStoneShopFrame(){super();}
      
      override protected function init() : void{}
      
      private function initView() : void{}
      
      public function loadList() : void{}
      
      public function setList(param1:Vector.<ShopItemInfo>) : void{}
      
      private function clearitems() : void{}
      
      private function initEvents() : void{}
      
      protected function __updateRemainCount(param1:PkgEvent) : void{}
      
      private function __pageBtnClick(param1:MouseEvent) : void{}
      
      public function updateScore(param1:int) : void{}
      
      public function show() : void{}
      
      private function removeEvents() : void{}
      
      override public function dispose() : void{}
      
      public function getType() : int{return 0;}
   }
}
