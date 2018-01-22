package consortion.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   
   public class KeepPayTip extends BaseTip
   {
       
      
      private var _tempData:Object;
      
      private var _name:FilterFrameText;
      
      private var _decript:FilterFrameText;
      
      private var _time:FilterFrameText;
      
      private var _container:Sprite;
      
      private var _bg:ScaleBitmapImage;
      
      public function KeepPayTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         _container = new Sprite();
         _name = ComponentFactory.Instance.creatComponentByStylename("keepPayTip.name");
         _container.addChild(_name);
         _decript = ComponentFactory.Instance.creatComponentByStylename("keepPayTip.discript");
         _container.addChild(_decript);
         _time = ComponentFactory.Instance.creatComponentByStylename("keepPayTip.time");
         _container.addChild(_time);
         _bg = ComponentFactory.Instance.creat("core.GoodsTipBg");
         super.init();
         this.tipbackgound = _bg;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
         }
         _name = null;
         if(_decript)
         {
            ObjectUtils.disposeObject(_decript);
         }
         _decript = null;
         if(_time)
         {
            ObjectUtils.disposeObject(_time);
         }
         _time = null;
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
         _name.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaInfoPane.week");
         _decript.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaInfoPane.time");
         _time.text = param1 as String;
         _tempData = param1;
         drawBG();
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
            _bg.width = _container.width + 20;
            _bg.height = _container.height + 10;
         }
         else
         {
            _bg.width = param1 + 2;
            _bg.height = _container.height + 5;
         }
         _width = _bg.width;
         _height = _bg.height;
      }
   }
}
