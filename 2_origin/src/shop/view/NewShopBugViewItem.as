package shop.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class NewShopBugViewItem extends Sprite implements ISelectable, Disposeable
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _lightEffect:Bitmap;
      
      private var _cell:ShopItemCell;
      
      private var _count:String;
      
      private var _money:int;
      
      private var _countTxt:FilterFrameText;
      
      private var _countBg:Image;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _type:int;
      
      public function NewShopBugViewItem(param1:int = 0, param2:String = "", param3:int = 0, param4:ShopItemCell = null)
      {
         super();
         buttonMode = true;
         _type = param1;
         _count = param2;
         _money = param3;
         _cell = param4;
         var _loc5_:* = 61;
         _cell.height = _loc5_;
         _cell.width = _loc5_;
         PositionUtils.setPos(_cell,"ddtshop.NewShopBugViewItem.cell.pos");
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.BugleViewBg");
         _lightEffect = ComponentFactory.Instance.creatBitmap("asset.ddtshop.lightEffect");
         _lightEffect.visible = false;
         _lightEffect.x = 14;
         _lightEffect.y = 7;
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.newBugleViewCountText");
         _countBg = ComponentFactory.Instance.creatComponentByStylename("asset.medicineQuickBug.countBg");
         _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.newBugleViewMoneyText");
         _loc5_ = false;
         _moneyTxt.mouseEnabled = _loc5_;
         _countTxt.mouseEnabled = _loc5_;
         _count = getSpecifiedString(_count);
         _countTxt.text = _count;
         _moneyTxt.text = String(_money) + LanguageMgr.GetTranslation("money");
         _bg.setFrame(1);
         addChild(_bg);
         addChild(_cell);
         addChild(_countTxt);
         addChild(_countBg);
         addChild(_moneyTxt);
         addChild(_lightEffect);
      }
      
      private function getSpecifiedString(param1:String) : String
      {
         var _loc3_:int = 0;
         if(!param1)
         {
            return "";
         }
         var _loc2_:String = "";
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1.charCodeAt(_loc3_) >= 48 && param1.charCodeAt(_loc3_) <= 57)
            {
               _loc2_ = _loc2_ + param1.charAt(_loc3_);
            }
            _loc3_++;
         }
         return "+" + _loc2_;
      }
      
      public function get info() : ItemTemplateInfo
      {
         return _cell.info;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _lightEffect.visible;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _lightEffect.visible = param1;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this as DisplayObject;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get count() : String
      {
         return _count;
      }
      
      public function get money() : int
      {
         return _money;
      }
      
      public function dispose() : void
      {
         _bg.dispose();
         _bg = null;
         _cell.dispose();
         _cell = null;
         _countTxt.dispose();
         _countTxt = null;
         _moneyTxt.dispose();
         _moneyTxt = null;
         if(_lightEffect)
         {
            ObjectUtils.disposeObject(_lightEffect);
         }
         _lightEffect = null;
         if(_countBg)
         {
            _countBg.dispose();
         }
         _countBg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
