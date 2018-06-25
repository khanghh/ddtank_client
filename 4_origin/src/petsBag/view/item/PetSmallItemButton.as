package petsBag.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import pet.data.PetInfo;
   
   public class PetSmallItemButton extends PetSmallItem implements ITipedDisplay
   {
       
      
      private var _place:int;
      
      private var _bmpBtn:Bitmap;
      
      private var _btnStyleName:String;
      
      protected var _star:StarBar;
      
      private var _tipStyle:String;
      
      private var _tipData:Object;
      
      private var _tipDirctions:String;
      
      private var _tipGapV:int;
      
      private var _tipGapH:int;
      
      public function PetSmallItemButton(info:PetInfo = null)
      {
         super(info);
         this.mouseChildren = false;
         _star = new StarBar();
         _star.y = 62;
         addChild(_star);
         tipStyle = "petsBag.PetBenchBagTip";
         tipDirctions = "2,7,5,1,6,4";
      }
      
      public function setButtonStyleName(stylename:String) : void
      {
         if(stylename == null)
         {
            ObjectUtils.disposeObject(_bmpBtn);
            _bmpBtn = null;
            _btnStyleName = null;
            info = null;
            return;
         }
         if(_btnStyleName == stylename)
         {
            return;
         }
         _btnStyleName = stylename;
         if(_bmpBtn == null)
         {
            _bmpBtn = new Bitmap();
         }
         _bmpBtn.bitmapData = ComponentFactory.Instance.creatBitmapData(_btnStyleName);
         _bmpBtn.x = 64 - _bmpBtn.width >> 1;
         _bmpBtn.y = 59 - _bmpBtn.height >> 1;
         addChildAt(_bmpBtn,2);
      }
      
      override protected function initView() : void
      {
         super.initView();
         addEventListener("rollOut",onOut);
         addEventListener("rollOver",onOver);
      }
      
      protected function onOver(e:MouseEvent) : void
      {
      }
      
      protected function onOut(e:MouseEvent) : void
      {
      }
      
      override public function set info(value:PetInfo) : void
      {
         if(value != null)
         {
            setButtonStyleName(null);
         }
         .super.info = value;
         if(info)
         {
            _star.starNum(info.StarLevel,"assets.petsBag.starSmall");
            _star.x = (this.width - _star.width) / 2 - 5;
            tipData = info;
            ShowTipManager.Instance.addTip(this);
         }
         else
         {
            _star.starNum(0,"assets.petsBag.starSmall");
            tipData = null;
            ShowTipManager.Instance.removeTip(this);
         }
      }
      
      public function set superInfo(value:PetInfo) : void
      {
         .super.info = value;
      }
      
      override public function dispose() : void
      {
         if(_shiner != null)
         {
            _shiner.removeEventListener("rollOver",onOver);
            _shiner.removeEventListener("rollOut",onOut);
         }
         if(_bmpBtn != null)
         {
            ObjectUtils.disposeObject(_bmpBtn);
            _bmpBtn = null;
         }
         ObjectUtils.disposeObject(_star);
         _star = null;
         ShowTipManager.Instance.removeTip(this);
         super.dispose();
      }
      
      public function get place() : int
      {
         return _place;
      }
      
      public function set place(value:int) : void
      {
         _place = value;
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirctions;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipStyle(value:String) : void
      {
         if(_tipStyle == value)
         {
            return;
         }
         _tipStyle = value;
      }
      
      public function set tipData(value:Object) : void
      {
         if(_tipData == value)
         {
            return;
         }
         _tipData = value;
      }
      
      public function set tipDirctions(value:String) : void
      {
         if(_tipDirctions == value)
         {
            return;
         }
         _tipDirctions = value;
      }
      
      public function set tipGapV(value:int) : void
      {
         if(_tipGapV == value)
         {
            return;
         }
         _tipGapV = value;
      }
      
      public function set tipGapH(value:int) : void
      {
         if(_tipGapH == value)
         {
            return;
         }
         _tipGapH = value;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
