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
      
      override public function set tipData(param1:Object) : void
      {
         if(param1 is ChangeNumToolTipInfo)
         {
            update(param1.currentTxt,param1.title,param1.current,param1.total,param1.content);
         }
         else
         {
            this.visible = false;
         }
         _tempData = param1;
      }
      
      private function update(param1:FilterFrameText, param2:String, param3:int, param4:int, param5:String) : void
      {
         var _loc6_:FilterFrameText = _currentTxt;
         _currentTxt = param1;
         _container.addChild(_currentTxt);
         _title.text = param2;
         _currentTxt.text = String(param3);
         _totalTxt.text = "/" + String(param4);
         _contentTxt.text = param5;
         drawBG();
         if(_loc6_ != null && _loc6_ != _currentTxt && _loc6_.parent)
         {
            _loc6_.parent.removeChild(_loc6_);
         }
      }
      
      private function reset() : void
      {
         _bg.height = 0;
         _bg.width = 0;
      }
      
      private function drawBG(param1:int = 0) : void
      {
         reset();
         if(param1 == 0)
         {
            _bg.width = _container.width + 10;
            _bg.height = _container.height + 10;
         }
         else
         {
            _bg.width = param1 + 2;
            _bg.height = _container.height + 10;
         }
         _width = _bg.width;
         _height = _bg.height;
      }
      
      public function get tipWidth() : int
      {
         return 0;
      }
      
      public function set tipWidth(param1:int) : void
      {
      }
      
      public function get tipHeight() : int
      {
         return 0;
      }
      
      public function set tipHeight(param1:int) : void
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
