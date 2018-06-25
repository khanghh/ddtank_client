package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import flash.text.TextFormat;
   
   public class FightBuffTip extends BaseTip
   {
       
      
      private var buff_txt:FilterFrameText;
      
      private var detail_txt:FilterFrameText;
      
      private var _bg:ScaleBitmapImage;
      
      private var _tempData:Object;
      
      private var _oriW:int;
      
      private var _oriH:int;
      
      private var _state:int;
      
      public function FightBuffTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg = ComponentFactory.Instance.creat("core.GoodsTipBg");
         buff_txt = ComponentFactory.Instance.creat("core.FightBuffTxt");
         detail_txt = ComponentFactory.Instance.creat("core.FightBuffDetailTxt");
         var txtW:int = detail_txt.width;
         detail_txt.multiline = true;
         detail_txt.wordWrap = true;
         detail_txt.width = txtW;
         detail_txt.selectable = false;
         buff_txt.selectable = false;
         this.tipbackgound = _bg;
         _oriW = 200;
         _oriH = 80;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(buff_txt)
         {
            addChild(buff_txt);
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
         }
         else
         {
            this.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(buff_txt);
         buff_txt = null;
         ObjectUtils.disposeObject(detail_txt);
         detail_txt = null;
         super.dispose();
      }
      
      private function propertyTextColor(color:uint) : void
      {
         var format:TextFormat = buff_txt.getTextFormat();
         format.color = color;
         buff_txt.setTextFormat(format);
      }
      
      private function propertyText(value:String) : void
      {
         buff_txt.text = value;
      }
      
      private function detailText(value:String) : void
      {
         detail_txt.htmlText = value;
         updateWH();
      }
      
      private function updateWH() : void
      {
         if(detail_txt.y + detail_txt.height >= _oriH)
         {
            _bg.height = detail_txt.y + detail_txt.height + 2;
         }
         else
         {
            _bg.height = _oriH;
         }
         _bg.width = _oriW;
         _width = _bg.width;
         _height = _bg.height;
      }
   }
}
