package petsBag.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.display.BitmapLoaderProxy;
   import ddt.manager.ItemManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import pet.data.PetInfo;
   import petsBag.event.PetItemEvent;
   
   public class AdoptItem extends Component
   {
      
      public static const ADOPT_PET_ITEM_WIDTH:int = 64;
       
      
      protected var _bg:DisplayObject;
      
      protected var _info:PetInfo;
      
      protected var _petMovieItem:PetBigItem;
      
      protected var _icon:Bitmap;
      
      protected var _isSelect:Boolean = false;
      
      protected var _shiner:DisplayObject;
      
      protected var _star:StarBar;
      
      protected var _goodBitmap:DisplayObject;
      
      protected var _goodTemplateId:int;
      
      private var _isGoodItem:Boolean = false;
      
      private var _goodItem:ItemTemplateInfo;
      
      private var _itemPlace:int = -1;
      
      private var _itemAmount:int = 0;
      
      private var _amountTxt:FilterFrameText;
      
      public function AdoptItem(info:PetInfo)
      {
         super();
         _info = info;
         initView();
         initEvent();
         if(_info)
         {
            this.tipData = _info;
         }
         tipDirctions = "6,7,4,5";
      }
      
      public function get info() : PetInfo
      {
         return _info;
      }
      
      public function set info(value:PetInfo) : void
      {
         _info = value;
         if(_info)
         {
            this.tipData = _info;
         }
      }
      
      public function set place(val:int) : void
      {
         _itemPlace = val;
      }
      
      public function get place() : int
      {
         return _itemPlace;
      }
      
      public function set itemAmount(val:int) : void
      {
         _itemAmount = val;
      }
      
      public function set itemTemplateId(val:int) : void
      {
         if(val == _goodTemplateId)
         {
            return;
         }
         _goodTemplateId = val;
         _goodItem = ItemManager.Instance.getTemplateById(_goodTemplateId);
         _isGoodItem = true;
         refreshView();
      }
      
      public function get isGoodItem() : Boolean
      {
         return _isGoodItem;
      }
      
      public function get itemInfo() : ItemTemplateInfo
      {
         return _goodItem;
      }
      
      private function refreshView() : void
      {
         ObjectUtils.disposeObject(_bg);
         ObjectUtils.disposeObject(_shiner);
         ObjectUtils.disposeObject(_petMovieItem);
         ObjectUtils.disposeObject(_star);
         _bg = ComponentFactory.Instance.creatBitmap("assets.farm.petPnlBg");
         addChild(_bg);
         _shiner = ComponentFactory.Instance.creat("assets.farm.petPnlBg2");
         addChild(_shiner);
         _shiner.visible = _isSelect;
         var url:String = PathManager.solveGoodsPath(_goodItem.CategoryID,_goodItem.Pic,PlayerManager.Instance.Self.Sex,"icon");
         var size:Rectangle = ComponentFactory.Instance.creatCustomObject("farm.adoptItem.goodBitmapSize");
         _goodBitmap = new BitmapLoaderProxy(url,size);
         PositionUtils.setPos(_goodBitmap,"assets.farm.itemPos");
         addChild(_goodBitmap);
         _amountTxt = ComponentFactory.Instance.creatComponentByStylename("farm.adoptItemTxt");
         _amountTxt.text = _itemAmount.toString();
         addChild(_amountTxt);
         var tipInfo:GoodTipInfo = new GoodTipInfo();
         tipInfo.itemInfo = _goodItem;
         this.tipData = tipInfo;
      }
      
      protected function initView() : void
      {
         this.buttonMode = true;
         if(_info && _info.StarLevel == 4)
         {
            _bg = ComponentFactory.Instance.creatBitmap("assets.farm.unSelectpetPnlBgFourStar");
            addChild(_bg);
            _shiner = ComponentFactory.Instance.creat("assets.farm.SelectpetPnlBgFourStar");
            addChild(_shiner);
         }
         else
         {
            _bg = ComponentFactory.Instance.creatBitmap("assets.farm.petPnlBg");
            addChild(_bg);
            _shiner = ComponentFactory.Instance.creat("assets.farm.petPnlBg2");
            addChild(_shiner);
         }
         _shiner.visible = _isSelect;
         if(_info)
         {
            _petMovieItem = ComponentFactory.Instance.creat("petsBag.petMovieItem");
            _petMovieItem.info = _info;
            addChild(_petMovieItem);
            _star = ComponentFactory.Instance.creat("farm.starBar.petStar");
            addChild(_star);
            _star.starNum(_info.StarLevel,"assets.farm.star");
         }
      }
      
      protected function initEvent() : void
      {
         addEventListener("click",__selectPet);
      }
      
      protected function __selectPet(e:MouseEvent) : void
      {
         dispatchEvent(new PetItemEvent("itemclick",this,true));
         isSelect = true;
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("click",__selectPet);
      }
      
      override public function get tipStyle() : String
      {
         if(_isGoodItem)
         {
            return "ddt.view.tips.GoodTip";
         }
         return "petsBag.view.item.PetTip";
      }
      
      public function set isSelect(value:Boolean) : void
      {
         _isSelect = value;
         _shiner.visible = _isSelect;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_shiner)
         {
            ObjectUtils.disposeObject(_shiner);
            _shiner = null;
         }
         if(_star)
         {
            ObjectUtils.disposeObject(_star);
            _star = null;
         }
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
            _icon = null;
         }
         if(_petMovieItem)
         {
            ObjectUtils.disposeObject(_petMovieItem);
            _petMovieItem = null;
         }
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         _info = null;
         if(_goodBitmap && _goodBitmap.parent)
         {
            _goodBitmap.parent.removeChild(_goodBitmap);
         }
         _goodBitmap = null;
         ObjectUtils.disposeObject(_amountTxt);
         _amountTxt = null;
         super.dispose();
      }
   }
}
