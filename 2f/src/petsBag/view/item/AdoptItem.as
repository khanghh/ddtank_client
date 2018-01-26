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
      
      public function AdoptItem(param1:PetInfo){super();}
      
      public function get info() : PetInfo{return null;}
      
      public function set info(param1:PetInfo) : void{}
      
      public function set place(param1:int) : void{}
      
      public function get place() : int{return 0;}
      
      public function set itemAmount(param1:int) : void{}
      
      public function set itemTemplateId(param1:int) : void{}
      
      public function get isGoodItem() : Boolean{return false;}
      
      public function get itemInfo() : ItemTemplateInfo{return null;}
      
      private function refreshView() : void{}
      
      protected function initView() : void{}
      
      protected function initEvent() : void{}
      
      protected function __selectPet(param1:MouseEvent) : void{}
      
      protected function removeEvent() : void{}
      
      override public function get tipStyle() : String{return null;}
      
      public function set isSelect(param1:Boolean) : void{}
      
      override public function dispose() : void{}
   }
}
