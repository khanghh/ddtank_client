package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class ChangeNumToolTip extends BaseTip implements ITransformableTip
   {
       
      
      private var _title:FilterFrameText;
      
      private var _currentTxt:FilterFrameText;
      
      private var _totalTxt:FilterFrameText;
      
      private var _contentTxt:FilterFrameText;
      
      private var _container:Sprite;
      
      private var _tempData:Object;
      
      private var _bg:ScaleBitmapImage;
      
      public function ChangeNumToolTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         _title = ComponentFactory.Instance.creatComponentByStylename("ChangeNumToolTip.titleTxt");
         _totalTxt = ComponentFactory.Instance.creatComponentByStylename("ChangeNumToolTip.totalTxt");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("ChangeNumToolTip.contentTxt");
         _bg = ComponentFactory.Instance.creat("core.GoodsTipBg");
         _container = new Sprite();
         _container.addChild(_title);
         _container.addChild(_totalTxt);
         _container.addChild(_contentTxt);
         super.init();
         this.tipbackgound = _bg;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         addChild(_container);
         _container.mouseEnabled = false;
         _container.mouseChildren = false;
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      override public function get tipData() : Object
      {
         return _tempData;
      }
      
      override public function set tipData(data:Object) : void
      {
         if(data is ChangeNumToolTipInfo)
         {
            update(data.currentTxt,data.title,data.current,data.total,data.content);
         }
         else
         {
            this.visible = false;
         }
         _tempData = data;
      }
      
      private function update(currentTxt:FilterFrameText, title:String, current:int, total:int, content:String) : void
      {
         var crntTxt:FilterFrameText = _currentTxt;
         _currentTxt = currentTxt;
         _container.addChild(_currentTxt);
         _title.text = title;
         _currentTxt.text = String(current);
         _totalTxt.text = "/" + String(total);
         _contentTxt.text = content;
         drawBG();
         if(crntTxt != null && crntTxt != _currentTxt && crntTxt.parent)
         {
            crntTxt.parent.removeChild(crntTxt);
         }
      }
      
      private function reset() : void
      {
         _bg.height = 0;
         _bg.width = 0;
      }
      
      private function drawBG($width:int = 0) : void
      {
         reset();
         if($width == 0)
         {
            _bg.width = _container.width + 10;
            _bg.height = _container.height + 10;
         }
         else
         {
            _bg.width = $width + 2;
            _bg.height = _container.height + 10;
         }
         _width = _bg.width;
         _height = _bg.height;
      }
      
      public function get tipWidth() : int
      {
         return 0;
      }
      
      public function set tipWidth(w:int) : void
      {
      }
      
      public function get tipHeight() : int
      {
         return 0;
      }
      
      public function set tipHeight(h:int) : void
      {
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_currentTxt)
         {
            ObjectUtils.disposeObject(_currentTxt);
         }
         _currentTxt = null;
         if(_totalTxt)
         {
            ObjectUtils.disposeObject(_totalTxt);
         }
         _totalTxt = null;
         if(_contentTxt)
         {
            ObjectUtils.disposeObject(_contentTxt);
         }
         _contentTxt = null;
         if(_container)
         {
            ObjectUtils.disposeObject(_container);
         }
         _container = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
