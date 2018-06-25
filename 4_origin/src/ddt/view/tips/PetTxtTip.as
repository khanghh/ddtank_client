package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import flash.text.TextFormat;
   
   public class PetTxtTip extends BaseTip
   {
       
      
      protected var property_txt:FilterFrameText;
      
      protected var detail_txt:FilterFrameText;
      
      protected var _bg:ScaleBitmapImage;
      
      private var _tempData:Object;
      
      private var _oriW:int;
      
      private var _oriH:int;
      
      public function PetTxtTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         mouseChildren = false;
         mouseEnabled = false;
         super.init();
         _bg = ComponentFactory.Instance.creat("core.GoodsTipBg");
         property_txt = ComponentFactory.Instance.creat("core.PerpertyTxt");
         detail_txt = ComponentFactory.Instance.creat("core.DetailTxt");
         var txtW:int = detail_txt.width;
         detail_txt.multiline = true;
         detail_txt.wordWrap = true;
         detail_txt.width = txtW;
         detail_txt.selectable = false;
         property_txt.selectable = false;
         this.tipbackgound = _bg;
         _oriW = 184;
         _oriH = 90;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(property_txt)
         {
            addChild(property_txt);
         }
         if(detail_txt)
         {
            addChild(detail_txt);
            updateWH();
         }
      }
      
      override public function get tipData() : Object
      {
         return _tempData;
      }
      
      override public function set tipData(data:Object) : void
      {
         if(data is PropTxtTipInfo)
         {
            _tempData = data;
            this.visible = true;
            this.propertyText(data.property);
            this.detailText(data.detail);
            this.propertyTextColor(data.color);
         }
         else
         {
            this.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(property_txt);
         property_txt = null;
         ObjectUtils.disposeObject(detail_txt);
         detail_txt = null;
         super.dispose();
      }
      
      private function propertyTextColor(color:uint) : void
      {
         var format:TextFormat = property_txt.getTextFormat();
         format.color = color;
         property_txt.setTextFormat(format);
      }
      
      private function propertyText(value:String) : void
      {
         property_txt.text = value;
         updateWidth();
      }
      
      protected function updateWidth() : void
      {
         if(property_txt.x + property_txt.width >= _oriW)
         {
            _bg.width = property_txt.x + property_txt.width + 2;
         }
         else
         {
            _bg.width = _oriW;
         }
         _width = _bg.width;
      }
      
      private function detailText(value:String) : void
      {
         detail_txt.text = value;
         updateWH();
      }
      
      protected function updateWH() : void
      {
         if(detail_txt.y + detail_txt.height >= _oriH)
         {
            _bg.height = detail_txt.y + detail_txt.height + 2;
         }
         else
         {
            _bg.height = _oriH;
         }
         _height = _bg.height;
         detail_txt.y = property_txt.y + property_txt.height + 5;
      }
   }
}
